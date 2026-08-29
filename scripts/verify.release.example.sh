#!/usr/bin/env bash
set -euo pipefail

# Copy this file to scripts/verify.release.sh only when the project has an
# explicit release gate. Do not turn a general regression suite into a default.
echo "NOT_RUN: configure scripts/verify.release.sh for this project's release gate." >&2
exit 2
