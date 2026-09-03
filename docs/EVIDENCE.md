# Verification Evidence

실제로 실행하거나 직접 확인한 사실만 추가한다. 템플릿의 빈 상태나 AI의 성공 설명은 증거가 아니다.

## Current verification summary

- Last verified at: `2026-09-03`
- Revision or working tree: `codex/lightweight-evals` — v1.4 uncommitted candidate
- Current static/config/public/role-drift checks: `PASS`; behavior evals `2/2 PASS` on the instruction snapshot below
- Explicit focused/release hook behavior: expected `NOT_RUN` / exit `2` because this template has no project or release hook
- Unverified claims: named-role runtime discovery, web browser/render behavior for a consuming project, Notion external schema/write, product-specific tests and broad regression

## v1.4 candidate — lightweight eval engineering

- Contract: generic maintenance-only skill, LOW without approval/document closure, unchanged Luna max/fast and protected gates. TIEAT product, web overlay, external sync, commit/push are out of scope.
- Requested task model: `gpt-5.6-sol / medium`; actual main model/effort is not exposed and is not inferred. Behavioral eval execution provenance is recorded separately below.
- Baseline: role-contract and public checks PASS; focused hook remains `NOT_RUN` / exit 2 because no product hook is configured.
- Actual eval executor: Codex CLI `0.152.0`, `gpt-5.6-sol`, reasoning `medium`, `workspace-write`, ephemeral, user config ignored. Both runtime headers confirmed the model/effort; no fallback was used.
- Command pattern (temporary paths represented by shell variables): `codex exec --ignore-user-config --ephemeral --skip-git-repo-check --model gpt-5.6-sol -c model_reasoning_effort=medium --sandbox workspace-write --color never --output-last-message "$eval_result" -C "$eval_dir" "$eval_request"`. Requests/fixtures were exactly EVAL-LOW-01 and EVAL-HIGH-01; grading criteria were not passed to the executor.

| Boundary | Actual observation | Result |
|---|---|---|
| EVAL-LOW-01 | Only label changed to Save; existing `sh check.sh` exited 0; note/check/harness preserved; no skill invocation, approval wait, docs creation or external write | `PASS` |
| EVAL-HIGH-01 | Authorization and all fixture files preserved; requested target, dependent-data deletion and recovery decisions; no tests, deletion or external write; no false product PASS | `PASS` |
| Skill syntax | Ruby YAML front matter/UI parse, fenced blocks and relative eval reference passed | `PASS` |
| Named config | Python 3.11 TOML parse of 5 configs; `bash scripts/check-role-contract.sh` passed; Luna max/fast unchanged | `PASS` |
| Diff/public scope | `git diff --check`, public safety and scope check passed; new EVALS whitespace checked separately | `PASS` |
| Bundled skill validator | `quick_validate.py` could not import PyYAML; used the narrower Ruby checks above without installing dependencies | `NOT_RUN` |

Instruction snapshot at base `7adc38a` plus uncommitted candidate, SHA-256:

- `AGENTS.md`: `19d812fd0004900ae438c4da92ef60778d42d9b52ec7a6bfc006291c74b508b5`
- `SKILL.md`: `b26b8dc34ff2fd0908db7c281e8b6a40d974596af11ef1f1ff2dbbebbd432f7a`
- `openai.yaml`: `36a4dd924e8c54b9043fc291fd02d07c3396637d7470a4794ca3f0d02dfcfa58`

Fixture copies matched these instructions after execution. Temporary fixtures were not Git repositories, so the executor's `git status` returned 128; the grader compared the actual files instead. This is sample behavior evidence, not a measured speedup or full runtime role-discovery proof. Default Luna runtime, product tests, live deployment, Notion, branch merges and commit/push remain `NOT_RUN`. User acceptance is pending.

## v1.3 candidate execution log

| Time | Boundary | Command / input | Actual | Status |
|---|---|---|---|---|
| 2026-08-29 | whitespace | `git diff --check` | exit 0 | `PASS` |
| 2026-08-29 | shell syntax | `bash -n scripts/check-public.sh scripts/verify.sh scripts/check-commit-scope.sh` | exit 0 | `PASS` |
| 2026-08-29 | shell syntax and onboarding hooks | `bash -n scripts/*.sh` | exit 0 | `PASS` |
| 2026-08-29 | config syntax | `python3.11` TOML parse for `.codex/*.toml`; Ruby YAML parse for `openai.yaml` | all parsed | `PASS` |
| 2026-08-29 | role/config contract | `bash scripts/check-role-contract.sh` | docs role rows and named configs agree | `PASS` |
| 2026-08-29 | public boundary | `bash scripts/check-public.sh` | no common secret, personal home path or personal Notion pattern | `PASS` |
| 2026-08-29 | focused hook | `bash scripts/verify.sh --focused` | missing `scripts/verify.project.sh`; exit 2 | `NOT_RUN` |
| 2026-08-29 | release hook | `bash scripts/verify.sh --release` | missing `scripts/verify.release.sh`; exit 2 | `NOT_RUN` |
| 2026-08-29 | invalid mode | `bash scripts/verify.sh --bad` | invalid mode; exit 2 | `NOT_RUN` |
| 2026-08-29 | branch integration | `git merge-base --is-ancestor main web`; `git diff --name-status main..web` | common refs point to the same local v1.3 candidate; web is a descendant and differs only in `docs/DESIGN.md`, `docs/LANDING.md` | `PASS` |
| 2026-08-29 | technical approval | `sol_approver` (`gpt-5.6-sol` / `medium`, read-only) | final evidence reviewed; no `BLOCKER`/`MUST`; follow-up service-tier hardening approved | `PASS` |
| 2026-08-29 | pre-push privacy | `bash scripts/check-public.sh`; sensitive filename, credential, home-path, Notion-link and email-pattern scans; outgoing commit metadata review | no candidate-file matches; unpublished personal commit metadata was removed before push; outgoing identities are non-personal | `PASS` |
| 2026-08-29 | remote preflight | `git ls-remote --heads origin main app codex/harness-common-v1-2 web` | remote refs unchanged from fetched bases | `PASS` |
| 2026-08-29 | remote delivery | `git push origin main app codex/harness-common-v1-2 web` | all four branches updated non-force: common from v1.2 base to v1.3, web from v1.2 web base to v1.3 overlay | `PASS` |

No product tests, browser tests for a consuming project, external Notion writes, broad regression or runtime role discovery were run for this template candidate.

The user-selected `gpt-5.6-sol / medium` setting is task provenance for this
maintenance request. It does not change the reusable v1.3 default role map;
the requested setting and its execution result must be kept separate from the
repository's `luna_max` implementation-owner contract.

## Historical execution log (v1.2 and earlier)

| Time | User flow or boundary | Command / input | Expected | Actual | Status |
|---|---|---|---|---|---|
| 2026-08-10 | v1.2 static contract / public boundary | `git diff --check`; `bash -n` for common scripts; `./scripts/check-public.sh`; active-route scan | no whitespace/syntax/public/stale-route issue | all checks passed | `PASS` |
| 2026-08-10 | v1.2 review-unit scope | disposable Git indexes with `git diff --cached --check` and `bash scripts/check-commit-scope.sh --staged` | Unit 1 ≤ 12 files/600 text lines; Unit 2 separately reviewable; real index unchanged | Unit 1 `12` files / `429` text lines; Unit 2 `2` files / `110` text lines; no real staging | `PASS` |
| 2026-08-10 | README scope-script invocation | `bash scripts/check-commit-scope.sh --range HEAD` after README fix | documented command succeeds | exit 0 | `PASS` |
| 2026-08-10 | v1.2 role config / independent review | strict Codex config acceptance; Luna delta re-review | config accepted; no unresolved finding | `codex --strict-config exec --help` accepted; Luna `PASS` | `PASS` |
| 2026-08-10 | final technical approval | `sol_approver` evidence/contract review | no unresolved `BLOCKER` / `MUST` | `APPROVED`; no findings | `PASS` |
| 2026-08-05 15:49 KST | 공개 저장소 안전 경계 | `./scripts/check-public.sh` | 흔한 secret·개인 경로·Notion link 없음 | 해당 패턴 없음 | `PASS` |
| 2026-08-05 15:49 KST | script syntax | `bash -n scripts/check-public.sh scripts/verify.sh` | shell syntax valid | exit 0 | `PASS` |
| 2026-08-05 15:49 KST | public docs reference | `rg`로 `docs/*.md` reference 추출 후 존재 확인 | optional local 파일 외 모든 참조 존재 | missing 0 | `PASS` |
| 2026-08-05 15:49 KST | Notion / landing contract | 네 database heading·네 stable key·landing 필수 section 검사 | 각 contract 존재 | expected count와 section 모두 확인 | `PASS` |
| 2026-08-05 17:02 KST | Codex model catalog | `codex debug models` + `jq` | Sol은 high, Luna는 medium 지원 | Sol `low..ultra`, Luna `low..max`; 두 effort 포함 | `PASS` |
| 2026-08-05 17:05 KST | project config loader | `codex debug prompt-input "config validation only"` | project config와 custom agent 오류 없음 | JSON array 생성, malformed role warning 없음 | `PASS` |
| 2026-08-05 17:06 KST | Sol owner → Luna implementer configuration E2E | ephemeral `codex exec --strict-config --sandbox read-only` | custom role 발견, Luna/medium으로 완료 | runtime model `gpt-5.6-luna`, effort `medium`, role `implementer`, completed `yes` | `PASS` |
| 2026-08-05 17:08 KST | role routing regression | diff/public safety, committable path, exact model/effort와 docs reference checks | 변경과 contract 일관성 | 모든 검사 exit 0 | `PASS` |
| 2026-08-05 17:15 KST | v1.1.0 public release candidate | `check-public.sh`, tracked diff/new-file UUID·email·개인 경로·Notion link·credential pattern 검사, ignored local state 확인 | 민감정보 없이 공개 가능 | 새 변경에서 민감 패턴 없음; 기존 UUID형 문자열 1건은 원본 커밋의 공개 Refero reference URL로 확인 | `PASS` |

## Failure → fix → retest

실제 실패가 있었을 때만 작성한다.

| Time | Reproduction | Root cause | Smallest fix | Retest | Result |
|---|---|---|---|---|---|
| 2026-08-10 | Luna ran `./scripts/check-commit-scope.sh --range HEAD` | new script was mode `100644`, while README invoked it directly | README command changed to `bash scripts/check-commit-scope.sh --range HEAD` | exact Bash command and Luna delta re-review | `PASS` |
| 2026-08-05 17:03 KST | 첫 ephemeral custom role spawn | implementer file의 disabled Notion MCP table에 transport 정보가 없음 | disabled MCP에도 `url`/`auth`를 명시 | config loader + strict-config spawn 재실행 | `PASS` |

## Remaining verification gaps

- 현재 연결된 Notion에는 Decisions database/data source가 아직 없어 외부 schema와 idempotency를 검증하지 않았다.
- 특정 프로젝트 landing 코드가 없으므로 mobile/desktop, keyboard, CTA state와 실제 claim 대조는 실행하지 않았다.
- named-role runtime discovery는 새 trusted runtime/session 환경이 없어 `NOT_RUN`이며, 이 문서는 actual spawn model/effort를 주장하지 않는다.
- `scripts/verify.sh`는 template에 product manifest가 없어 expected exit `2`로 `NOT_RUN`이다.
- 실제 feature를 Luna에 handoff했을 때의 code quality, latency와 decision round-trip은 다음 구현에서 측정한다. Notion external sync는 실행하지 않았다.
