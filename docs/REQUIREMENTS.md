# Requirements and Contract

이 문서는 local-harness 자체의 안정적인 요구사항 원장이다. 사용하는 제품의 업무 규칙과 도메인 요구사항은 각 프로젝트가 소유하며 이 파일에 복사하지 않는다. 현재 실행 상태는 [`STATE.md`](STATE.md), 실행 증거는 [`EVIDENCE.md`](EVIDENCE.md)가 소유한다.

## Contract rules

- `R-###`는 요구사항·작업·검증을 연결하는 stable key다.
- 사람은 문제, priority, acceptance intent, Source of Truth, 업무 규칙과 호환성 결정을 확정한다.
- AI는 저장소에서 확인한 상태와 후보를 기록하되, 확인하지 않은 값을 `가정` 또는 `미확인`으로 표시한다.
- `DRAFT | READY | ACTIVE | BLOCKED | DONE | REMOVED`는 요구사항 상태이고 `NOW | NEXT | LATER`는 priority다.
- 요구사항 상세에 Notion ID, database schema, property 이름을 복제하지 않는다. 선택적 mirror contract는 [`NOTION.local.example.md`](NOTION.local.example.md) 한 곳에 둔다.
- acceptance 전에는 `DONE`으로 바꾸지 않는다. 검증하지 않은 성공을 acceptance 근거로 사용하지 않는다.

## Requirement index

| ID | Requirement | Acceptance summary | Priority | Status | Notes |
|---|---|---|---|---|---|
| R-001 | local Source of Truth와 적응형 project loop | 상태·요구사항·흐름·증거·사람 결정의 책임이 분리되고 가장 작은 E2E를 선택한다 | NOW | `DONE` / historical | v1.0 baseline |
| R-002 | common engineering, Git/security와 reviewable unit | 실제 seam 없는 추상화·fallback·대형 diff를 억제하고 변경 경계를 검증한다 | NOW | `DONE` / historical | v1.1 baseline |
| R-003 | v1.2 multi-role routing | Terra-main default, 제한된 Luna/Sol stage와 forced routing을 사용했던 이전 baseline | NEXT | `DONE` / superseded | v1.2; v1.3에서 superseded |
| R-004 | v1.3 common/web harness와 README v1.3 | 아래 acceptance criteria와 migration이 모두 충족되고 사람 승인을 받는다 | NOW | `DONE` | accepted and pushed 2026-08-29 |

## R-004 — v1.3 common/web harness와 README v1.3

### Outcome

재사용 가능한 공통 하네스는 사용자의 실제 프로젝트 흐름을 추적하고, 웹 프로젝트만 선택적으로 visual/landing/browser 기준을 추가한다. 구현은 명시적인 verification hook과 실제 evidence로 설명할 수 있어야 한다.

### In scope

- 공통 branch(`main`, `app`, `codex/harness-common-v1-2`)의 정책·문서·role routing·검증 진입점을 하나의 candidate로 정렬한다.
- `web` branch가 common candidate를 포함하고 web-only `DESIGN.md`, `LANDING.md`, browser/screenshot guidance를 overlay로 제공한다.
- README를 v1.3의 사용자 흐름과 5분 시작 순서에 맞춰 갱신한다.
- implementation owner, conditional planner/approver/high diagnosis, no-fallback과 one-writer contract를 기록한다.
- `verify.sh --focused`와 `verify.sh --release`를 명시적인 project/release hook으로 정의한다.
- Notion을 optional manual one-way mirror로 유지하고 connection/property 절차를 example 문서로 분리한다.
- v1.2에서 v1.3으로 옮길 migration과 실제 검증·`NOT_RUN` 의미를 기록한다.
- role 문서와 named config의 drift 검사 및 새 프로젝트용 focused/release hook example을 제공한다.

### Out of scope

- TIEAT 또는 다른 제품의 도메인·API·DB·보안 정책을 공통 템플릿에 복사하는 것.
- 새 업무 규칙, 인증·권한·결제·개인정보 정책 또는 배포 정책을 만드는 것.
- branch history rewrite, force push, 삭제 전파와 실제 Notion 외부 write.
- 모든 작업에 planner·approver·full regression을 강제하는 것.
- usage ratio나 model token 비율을 추정·보고하는 것.

### Acceptance criteria

- [x] common three branches have the same v1.3 tree and `web` is a descendant that adds only its web overlay.
- [x] README v1.3 explains the problem, common/web choice, five-minute start, daily flow, file responsibilities, focused/release verification, optional Notion/roles and v1.2 migration.
- [x] common policy does not require a product-specific color palette, landing narrative, browser tool or TIEAT domain rule.
- [x] `docs/AGENT_ROLES.md` is the exact role/model/effort/sandbox source of truth; Luna is the normal implementation/test owner and Sol roles are conditional read-only roles.
- [x] `STATE`, `REQUIREMENTS`, `SYSTEM_MAP`, `EVIDENCE`, `WORKLOG` and `NOTION.local.example` have non-overlapping responsibilities.
- [x] `verify.sh` never infers a stack or silently runs a broad suite; absent hooks return `NOT_RUN` with exit `2`.
- [x] Notion schema/procedure is maintained in one optional example file and no actual ID is guessed.
- [x] generated build output and common local artifacts are ignored without hiding source files.
- [x] public-safety and commit-scope checks remain available, and no secret or personal path is introduced.
- [x] role/config drift check passes, and project/release hook examples preserve `NOT_RUN` until a project supplies real commands.
- [x] actual focused checks, technical review and human acceptance are recorded before this requirement becomes `DONE`.

### Human decisions recorded

- `main`, `app` and `codex/harness-common-v1-2` are the same pushed v1.3 common tree; `web` retains full design/landing overlay documents as a descendant.
- Notion and technical approval remain optional defaults for future projects.
- The final v1.3 candidate was accepted and pushed after the privacy audit on 2026-08-29.

### Verification plan

| Boundary | Command / evidence | Expected record |
|---|---|---|
| Static/scripts | `bash -n scripts/*.sh`, role drift check, TOML/YAML parse, `git diff --check` | `PASS` with command output |
| Hook contract | `bash scripts/verify.sh --help`; missing focused/release hooks | help `PASS`; absent hook `NOT_RUN` / exit `2` |
| Public/scope | `./scripts/check-public.sh`; staged scope checks before commit | actual result; no unrun check marked `PASS` |
| Common branch | tree/ancestor comparison for common and web | branch facts and any mismatch |
| Web overlay | web-only file diff and browser/screenshot guidance review | common pollution absent; runtime browser check only when a project exists |

## Historical migration notes

### v1.2 → v1.3

| v1.2 behavior | v1.3 behavior |
|---|---|
| Terra-main active default writer | Luna is the normal implementation/test owner for a closed contract |
| Luna as optional stage and Sol as fixed route | planner/approver/high are condition-based roles |
| manifest auto-detection in `verify.sh` | explicit `--focused` and `--release` hooks |
| common design/landing baseline | web-only design/landing/browser overlay |
| Notion details mixed into requirements | one optional `NOTION.local.example.md` contract |
| stage/usage assumptions | actual risk, evidence, `NOT_RUN` and human decisions |

R-003 and earlier records remain provenance. They are not active instructions for a v1.3 project.
