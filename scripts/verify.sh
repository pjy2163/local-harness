#!/usr/bin/env bash
set -uo pipefail

echo "========================================"
echo "Project verification"
echo "========================================"

CHECKS_RUN=0

run_check() {
  local label="$1"
  shift

  echo
  echo "== ${label} =="

  if "$@"; then
    CHECKS_RUN=$((CHECKS_RUN + 1))
    echo "PASS: ${label}"
  else
    local status=$?
    echo "FAIL: ${label} (exit ${status})"
    exit "$status"
  fi
}

finish_successfully() {
  echo
  echo "========================================"
  echo "VERIFY PASS"
  echo "Checks executed: $CHECKS_RUN"
  echo "========================================"
}

has_node_script() {
  local script_name="$1"
  node -e "const p=require('./package.json'); process.exit(p.scripts?.['${script_name}'] ? 0 : 1)"
}

select_node_runner() {
  if [ -f "pnpm-lock.yaml" ]; then
    if ! command -v pnpm >/dev/null 2>&1; then
      echo "pnpm-lock.yaml found, but pnpm is unavailable."
      exit 2
    fi
    NODE_RUNNER=(pnpm)
  elif [ -f "yarn.lock" ]; then
    if ! command -v yarn >/dev/null 2>&1; then
      echo "yarn.lock found, but yarn is unavailable."
      exit 2
    fi
    NODE_RUNNER=(yarn)
  elif [ -f "bun.lock" ] || [ -f "bun.lockb" ]; then
    if ! command -v bun >/dev/null 2>&1; then
      echo "Bun lockfile found, but bun is unavailable."
      exit 2
    fi
    NODE_RUNNER=(bun)
  else
    if ! command -v npm >/dev/null 2>&1; then
      echo "package.json found, but npm is unavailable."
      exit 2
    fi
    NODE_RUNNER=(npm)
  fi
}

run_node_checks() {
  if ! command -v node >/dev/null 2>&1; then
    echo "Node project detected, but node is unavailable."
    exit 2
  fi

  select_node_runner

  if [ ! -d "node_modules" ] && [ "${NODE_RUNNER[0]}" != "bun" ]; then
    echo "Node dependencies are not installed. Install them before verification."
    exit 2
  fi

  if has_node_script "typecheck"; then
    run_check "Node typecheck" "${NODE_RUNNER[@]}" run typecheck
  fi

  if has_node_script "lint"; then
    run_check "Node lint" "${NODE_RUNNER[@]}" run lint
  fi

  if has_node_script "test"; then
    run_check "Node test" env CI=1 "${NODE_RUNNER[@]}" run test
  fi

  if has_node_script "build"; then
    run_check "Node build" "${NODE_RUNNER[@]}" run build
  fi
}

select_python_runner() {
  if [ -f "uv.lock" ] && command -v uv >/dev/null 2>&1; then
    PYTHON_RUNNER=(uv run python)
  elif [ -f "poetry.lock" ] && command -v poetry >/dev/null 2>&1; then
    PYTHON_RUNNER=(poetry run python)
  elif command -v python3 >/dev/null 2>&1; then
    PYTHON_RUNNER=(python3)
  elif command -v python >/dev/null 2>&1; then
    PYTHON_RUNNER=(python)
  else
    echo "Python project detected, but no Python runtime is available."
    exit 2
  fi
}

python_has_module() {
  local module_name="$1"
  "${PYTHON_RUNNER[@]}" -c "import ${module_name}" >/dev/null 2>&1
}

run_python_checks() {
  select_python_runner

  run_check \
    "Python compile" \
    "${PYTHON_RUNNER[@]}" -m compileall -q \
    -x '(^|/)(\.venv|venv|node_modules|\.git|build|dist)(/|$)' .

  if python_has_module "ruff"; then
    run_check "Python lint" "${PYTHON_RUNNER[@]}" -m ruff check .
  fi

  if python_has_module "pytest"; then
    run_check "Python test" "${PYTHON_RUNNER[@]}" -m pytest -q
  fi
}

run_gradle_checks() {
  run_check "Gradle build" ./gradlew build
}

run_maven_checks() {
  run_check "Maven test" ./mvnw test
}

run_go_checks() {
  if ! command -v go >/dev/null 2>&1; then
    echo "Go project detected, but go is unavailable."
    exit 2
  fi
  run_check "Go test" go test ./...
}

run_rust_checks() {
  if ! command -v cargo >/dev/null 2>&1; then
    echo "Rust project detected, but cargo is unavailable."
    exit 2
  fi
  run_check "Rust test" cargo test --all-targets
}

if [ -f "scripts/verify.project.sh" ]; then
  run_check "Project-specific verification" bash scripts/verify.project.sh
  finish_successfully
  exit 0
fi

if [ -f "package.json" ]; then
  run_node_checks
fi

if [ -f "pyproject.toml" ] || [ -f "requirements.txt" ] || [ -f "setup.py" ]; then
  run_python_checks
fi

if [ -f "gradlew" ]; then
  run_gradle_checks
fi

if [ -f "mvnw" ]; then
  run_maven_checks
fi

if [ -f "go.mod" ]; then
  run_go_checks
fi

if [ -f "Cargo.toml" ]; then
  run_rust_checks
fi

if [ "$CHECKS_RUN" -eq 0 ]; then
  echo
  echo "No supported verification commands were detected."
  echo "Add scripts/verify.project.sh with the actual project commands."
  exit 2
fi

finish_successfully
