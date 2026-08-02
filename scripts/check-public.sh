#!/usr/bin/env bash
set -uo pipefail

echo "Public repository safety check"

if ! command -v git >/dev/null 2>&1; then
  echo "FAIL: git is required to resolve files that could be committed."
  exit 2
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "FAIL: run this command inside a Git work tree."
  exit 2
fi

candidate_list="$(mktemp)"
trap 'rm -f "$candidate_list"' EXIT

git ls-files -z --cached --others --exclude-standard >"$candidate_list"

if [ ! -s "$candidate_list" ]; then
  echo "PASS: no tracked or unignored files to inspect."
  exit 0
fi

failed=0

while IFS= read -r -d '' file; do
  case "$file" in
    .env|.env.*|.npmrc|.pypirc|.netrc|*.pem|*.key|*.p12|*.pfx|*.jks|*.keystore|*/id_rsa|*/id_ed25519|docs/NOTION.local.md)
      if [ "$file" != ".env.example" ]; then
        echo "FAIL: sensitive filename could be committed: $file"
        failed=1
      fi
      ;;
  esac

  if [ ! -f "$file" ] || ! grep -Iq . "$file"; then
    continue
  fi

  if grep -EIl -- '-----BEGIN ([A-Z0-9 ]+ )?PRIVATE KEY-----|AKIA[0-9A-Z]{16}|github_pat_[A-Za-z0-9_]{20,}|gh[pousr]_[A-Za-z0-9]{20,}|sk-[A-Za-z0-9_-]{20,}|xox[baprs]-[A-Za-z0-9-]{10,}' "$file" >/dev/null; then
    echo "FAIL: possible credential pattern: $file"
    failed=1
  fi

  if grep -EIl -- '/Users/[A-Za-z0-9._-]+/|/home/[A-Za-z0-9._-]+/' "$file" >/dev/null; then
    echo "FAIL: personal absolute home path: $file"
    failed=1
  fi

  if grep -EIl -- 'https://(www\.)?(notion\.so|notion\.site|app\.notion\.com)/' "$file" >/dev/null; then
    echo "FAIL: personal Notion page link: $file"
    failed=1
  fi
done <"$candidate_list"

if [ "$failed" -ne 0 ]; then
  echo "Public safety check failed. Review the filenames above before committing."
  exit 1
fi

echo "PASS: no common secret, personal home path, or personal Notion page pattern found."
echo "Note: this heuristic check does not replace a dedicated secret scanner."
