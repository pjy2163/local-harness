#!/usr/bin/env bash
set -euo pipefail

MAX_REVIEW_LINES=600
MAX_REVIEW_FILES=12

mode="staged"
range=""
staged_explicit=false
allow_large=false
reason=""

usage() {
  cat <<'EOF'
Usage:
  bash scripts/check-commit-scope.sh --staged
  bash scripts/check-commit-scope.sh --range <git-range>

Options:
  --allow-large       Continue after a review-stop threshold only with --reason.
  --reason <text>     Explain why the staged change cannot be split.
  -h, --help          Show this help.

The default review stop is 600 non-generated text changed lines or 12 non-generated text files.
Binary files are reported separately.
An exception records a technical reason only; it does not replace required user agreement.
EOF
}

fail() {
  echo "FAIL: $*" >&2
  exit 2
}

while (($# > 0)); do
  case "$1" in
    --staged)
      [[ "$mode" == "staged" && "$staged_explicit" != true ]] || fail "--staged and --range cannot be used together."
      staged_explicit=true
      shift
      ;;
    --range)
      [[ $# -ge 2 ]] || fail "--range requires a Git revision range."
      [[ "$mode" == "staged" && "$staged_explicit" != true && -z "$range" ]] || fail "--staged and --range cannot be used together."
      mode="range"
      range="$2"
      shift 2
      ;;
    --allow-large)
      allow_large=true
      shift
      ;;
    --reason)
      [[ $# -ge 2 ]] || fail "--reason requires text."
      reason="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      usage >&2
      fail "unknown option: $1"
      ;;
  esac
done

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || fail "run this command inside a Git work tree."

if [[ "$mode" == "range" ]]; then
  if git diff --no-ext-diff --quiet "$range" -- >/dev/null 2>&1; then
    :
  else
    diff_status=$?
    ((diff_status <= 1)) || fail "invalid Git range: $range"
  fi
  diff_args=(diff --numstat --no-renames "$range")
  label="range $range"
else
  diff_args=(diff --cached --numstat --no-renames)
  label="staged changes"
fi

is_generated_or_lockfile() {
  case "$1" in
    package-lock.json|npm-shrinkwrap.json|pnpm-lock.yaml|yarn.lock|bun.lock|bun.lockb|*/package-lock.json|*/npm-shrinkwrap.json|*/pnpm-lock.yaml|*/yarn.lock|*/bun.lock|*/bun.lockb|*.min.js|*.min.css|*.map|gradle/wrapper/gradle-wrapper.jar)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

total_files=0
review_files=0
generated_files=0
binary_files=0
review_lines=0
generated_lines=0

while IFS=$'\t' read -r added deleted path; do
  [[ -n "${path:-}" ]] || continue
  total_files=$((total_files + 1))

  if [[ "$added" == "-" || "$deleted" == "-" ]]; then
    binary_files=$((binary_files + 1))
    continue
  fi

  changed_lines=$((added + deleted))
  if is_generated_or_lockfile "$path"; then
    generated_files=$((generated_files + 1))
    generated_lines=$((generated_lines + changed_lines))
  else
    review_files=$((review_files + 1))
    review_lines=$((review_lines + changed_lines))
  fi
done < <(git "${diff_args[@]}")

if ((total_files == 0)); then
  echo "PASS: ${label} has no changed files."
  exit 0
fi

echo "Commit scope: ${label}"
echo "- Reviewable text: ${review_files} files, ${review_lines} changed lines"
echo "- Generated or lock files: ${generated_files} files, ${generated_lines} changed lines"
echo "- Binary files: ${binary_files}"

over_lines=false
over_files=false
((review_lines > MAX_REVIEW_LINES)) && over_lines=true
((review_files > MAX_REVIEW_FILES)) && over_files=true

if [[ "$over_lines" == true || "$over_files" == true ]]; then
  echo "REVIEW STOP: exceeds ${MAX_REVIEW_LINES} lines or ${MAX_REVIEW_FILES} files." >&2
  if [[ "$allow_large" != true ]]; then
    echo "Split by behavior, rule, or technical boundary. If splitting is truly unsafe, obtain user agreement and rerun with --allow-large --reason \"...\"." >&2
    exit 1
  fi

  [[ "$reason" =~ [^[:space:]] ]] || fail "--allow-large requires a nonblank --reason."
  echo "EXCEPTION: ${reason}" >&2
  echo "PASS: exception recorded; add the reason and user agreement to the review packet."
  exit 0
fi

if ((generated_files > 0 && review_files > 0)); then
  echo "NOTE: generated or lock files are excluded from the size threshold; keep them in a separate dependency boundary unless they are required by this code change."
fi

echo "PASS: within the review-stop threshold."
