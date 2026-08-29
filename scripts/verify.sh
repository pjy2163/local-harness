#!/usr/bin/env bash
set -u

usage() {
  cat <<'EOF'
Usage: bash scripts/verify.sh --focused|--release

Modes:
  --focused  Run scripts/verify.project.sh
  --release  Run scripts/verify.release.sh
  --help     Show this help
EOF
}

if [ "$#" -ne 1 ]; then
  echo "NOT_RUN: exactly one verification mode is required." >&2
  usage >&2
  exit 2
fi

mode="$1"
case "$mode" in
  --focused)
    label="focused"
    hook="scripts/verify.project.sh"
    ;;
  --release)
    label="release"
    hook="scripts/verify.release.sh"
    ;;
  --help)
    usage
    exit 0
    ;;
  *)
    echo "NOT_RUN: invalid verification mode: $mode" >&2
    usage >&2
    exit 2
    ;;
esac

if [ ! -f "$hook" ]; then
  echo "NOT_RUN: missing verification hook: $hook" >&2
  exit 2
fi

echo "START: $label verification ($hook)"
bash "$hook"
status=$?
echo "END: $label verification (exit $status)"
exit "$status"
