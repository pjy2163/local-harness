#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

failures=0

require_file() {
  local file="$1"
  if [[ ! -f "$file" ]]; then
    echo "FAIL: missing role contract file: $file" >&2
    failures=$((failures + 1))
  fi
}

require_line() {
  local file="$1"
  local expected="$2"
  local label="$3"
  if [[ -f "$file" ]] && ! grep -Fqx -- "$expected" "$file"; then
    echo "FAIL: $label ($file)" >&2
    echo "      expected: $expected" >&2
    failures=$((failures + 1))
  fi
}

require_text() {
  local file="$1"
  local expected="$2"
  local label="$3"
  if [[ -f "$file" ]] && ! grep -Fq -- "$expected" "$file"; then
    echo "FAIL: $label ($file)" >&2
    echo "      expected text: $expected" >&2
    failures=$((failures + 1))
  fi
}

for file in \
  .codex/config.toml \
  .codex/agents/luna-max.toml \
  .codex/agents/sol-planner.toml \
  .codex/agents/sol-approver.toml \
  .codex/agents/sol-high.toml \
  docs/AGENT_ROLES.md; do
  require_file "$file"
done

require_line .codex/config.toml 'model = "gpt-5.6-luna"' "project default model"
require_line .codex/config.toml 'model_reasoning_effort = "max"' "project default effort"
require_line .codex/config.toml 'default_subagent_model = "gpt-5.6-luna"' "default subagent model"
require_line .codex/config.toml 'default_subagent_reasoning_effort = "max"' "default subagent effort"

check_role() {
  local file="$1"
  local name="$2"
  local model="$3"
  local effort="$4"
  local sandbox="$5"
  local service_tier="${6:-}"

  require_line "$file" "name = \"$name\"" "$name role name"
  require_line "$file" "model = \"$model\"" "$name model"
  require_line "$file" "model_reasoning_effort = \"$effort\"" "$name effort"
  require_line "$file" "sandbox_mode = \"$sandbox\"" "$name sandbox"
  if [[ -n "$service_tier" ]]; then
    require_line "$file" "service_tier = \"$service_tier\"" "$name service tier"
  fi
}

check_optional_notion() {
  local file="$1"
  local name="$2"
  require_line "$file" 'enabled = false' "$name optional Notion disabled"
  require_line "$file" 'required = false' "$name optional Notion non-required"
}

check_role .codex/agents/luna-max.toml luna_max gpt-5.6-luna max workspace-write fast
check_role .codex/agents/sol-planner.toml sol_planner gpt-5.6-sol max read-only
check_role .codex/agents/sol-approver.toml sol_approver gpt-5.6-sol medium read-only
check_role .codex/agents/sol-high.toml sol_high gpt-5.6-sol xhigh read-only
check_optional_notion .codex/agents/sol-planner.toml sol_planner
check_optional_notion .codex/agents/sol-approver.toml sol_approver
check_optional_notion .codex/agents/sol-high.toml sol_high

require_text docs/AGENT_ROLES.md '`luna_max` | `gpt-5.6-luna` / `max` / `fast`' "docs luna_max row"
require_text docs/AGENT_ROLES.md '`sol_planner` | `gpt-5.6-sol` / `max`' "docs sol_planner row"
require_text docs/AGENT_ROLES.md '`sol_approver` | `gpt-5.6-sol` / `medium`' "docs sol_approver row"
require_text docs/AGENT_ROLES.md '`sol_high` | `gpt-5.6-sol` / `xhigh`' "docs sol_high row"
require_text docs/AGENT_ROLES.md 'All Sol roles are read-only' "docs Sol read-only rule"

if ((failures > 0)); then
  echo "FAIL: role contract drift detected ($failures finding(s))." >&2
  exit 1
fi

echo "PASS: role docs and named-agent configuration agree."
