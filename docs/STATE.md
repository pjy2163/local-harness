# Project State

AI가 현재 요청과 저장소를 읽고 이 문서를 유지한다. 확인한 사실과 가정을 섞지 않으며, 사람의 결정을 임의로 `ACCEPTED`로 바꾸지 않는다.

## Snapshot

| Field | Current value |
|---|---|
| Project outcome | 사람이 흐름·계약·운영 경계를 소유하는 재사용 가능한 프로젝트 하네스 |
| Primary user | AI와 함께 개인 프로젝트를 설계·구현·검증하는 사람 |
| Active mode | `정리` |
| Active requirement | v1.4 lightweight eval — 사용자 승인된 로컬 기준; R-004는 이전 v1.3 baseline |
| Active user flow | 작은 contract → 단일 writer → affected evidence → LOW 보고 / 필요한 고위험 review |
| Current work | v1.4를 로컬 main/app/web에 반영하고 README에 적용 상태·업그레이드 방법을 기록 |
| Status | `DONE` — 사용자 승인 및 로컬 통합 완료; 원격 push 제외 |
| Next action | GitHub 반영은 별도 push 요청 시 진행. 로컬 새 프로젝트는 main 또는 web에서 시작 |
| Last updated | `2026-09-03` |

## Current vertical slice

현재 v1.4의 검수·로컬 통합 결과는 `docs/EVIDENCE.md`를 따른다. R-004와 v1.3 push 기록은 과거 이력이며 v1.4의 원격 배포 승인이 아니다.

- User action: template owner가 common 또는 web variant를 선택하고 closed contract를 시작한다.
- Visible result: 유지보수 전용 skill, LOW의 가벼운 종료와 두 행동 eval이 공통 하네스에 연결된다. Luna max와 고위험 경계는 유지한다.
- Start boundary: `.codex/config.toml`, `.codex/agents/`, root `AGENTS.md`, role docs와 `scripts/verify.sh`.
- End boundary: 사용자 승인 → 로컬 commit/merge → 공통 파일 일치·web overlay 보존 확인 → README 기록.
- In scope: 승인된 v1.4 하네스, 최소 문서 갱신과 로컬 main/app/web 통합.
- Out of scope: TIEAT 제품, web 디자인 변경, 모델 기본값 변경, Notion external write, 원격 push·배포와 history rewrite.
- Done when: 승인된 로컬 통합과 관련 검사·문서 갱신이 끝난다. 원격 push는 별도 요청이다.

## Data and contract status

| Item | Source of Truth | State | Producer → Consumer | Contract location | Verified by |
|---|---|---|---|---|---|
| Approved baseline | 사용자 승인된 v1.4 local baseline | `REAL` | Human/AI → main/app/web | `AGENTS.md`, role docs, skill, `docs/EVALS.md` | static checks·behavior evals 2/2·local integration `PASS`; push `NOT_RUN` |
| Harness setup flow | local Markdown | `REAL` | User request → project template | `AGENTS.md`, skill, `docs/SYSTEM_MAP.md` | reference check `PASS` |
| Notion mirror | local Markdown이 SoT; remote는 선택적 mirror | `UNKNOWN` | local Markdown → Notion | `docs/NOTION.local.example.md` | `NOT_CONNECTED`; external write `NOT_RUN` |
| Landing content | project facts / web overlay contract | `UNKNOWN` per project | Requirements·flow·evidence → landing UI | web branch `docs/LANDING.md` | browser/render `NOT_RUN` |
| Agent routing | project config + `docs/AGENT_ROLES.md` | `REAL` | Human closed contract → implementation owner → conditional Sol → Human | `.codex/config.toml`, `.codex/agents/*.toml` | role/config syntax·drift check `PASS`; runtime role discovery `NOT_RUN` |

## Active work

| ID | Work | Why now | Status | Evidence |
|---|---|---|---|---|
| R-001 | 공통 엔지니어링·Decisions mirror·landing template | 반복되는 프로젝트 setup과 신뢰 경계를 공통화 | `DONE` | `docs/EVIDENCE.md` 2026-08-05 |
| R-002 | v1.1 predecessor two-role routing | 책임 맥락과 구현 소음을 분리하고 단계별 비용·깊이를 제어 | `DONE` / v1.2에서 superseded | `docs/EVIDENCE.md` 2026-08-05 17:06 KST |
| R-003 | Terra-main·Luna·Sol multi-stage routing | v1.2 historical baseline; v1.3에서 superseded | `DONE` / historical, superseded | `docs/EVIDENCE.md` 2026-08-10; human accepted |
| R-004 | v1.3 common/web harness와 README v1.3 | common/web overlay, privacy audit와 remote delivery를 닫음 | `DONE` | `docs/EVIDENCE.md`; user accepted and pushed |
| v1.4 | 경량 eval 하네스와 로컬 branch 통합 | 새 프로젝트의 최소 하네스 기준 제공 | `DONE` / local-only | `docs/EVIDENCE.md`; user accepted; push `NOT_RUN` |

## Risks, assumptions and unknowns

| Type | Item | Impact | How to resolve | Owner |
|---|---|---|---|---|
| Unknown | 프로젝트별 audience, 실제 기능·증거와 운영 정책 | landing copy와 UI를 아직 구현할 수 없음 | web overlay 선택 시 실제 사실로 초기화 | Human |
| External state | Notion target과 schema가 연결되지 않음 | 기술 결정은 local-only | 외부 write 요청 시 schema preview 후 사람이 승인 | Human + AI |
| Reference gap | web 프로젝트의 visual reference가 아직 없음 | 특정 시각·콘텐츠 세부는 반영하지 않음 | 정확한 URL/screenshot으로 web override 작성 | Human |
| Runtime | named role config는 새 trusted session에서만 role discovery를 검증할 수 있음 | v1.3 runtime spawn은 `NOT_RUN` | 다음 trusted session에서 필요할 때 focused role discovery 실행 | Human + AI |
| Acceptance | v1.4 로컬 통합·문서 갱신을 사용자가 승인함 | 외부 배포까지 승인된 것은 아님 | 다음 외부 변경은 별도 요청 | Human |
| Branch/remote | v1.4 local main/app/web 반영 완료, push하지 않음 | GitHub에서 새로 가져오면 v1.4가 없을 수 있음 | 명시적 push 요청 시 원격 상태 확인 후 진행 | Human + AI |

## Human decisions needed

- Notion mirror target과 schema를 실제로 연결할지
- 첫 적용 프로젝트의 audience, 제공/비지원 범위, 데이터·privacy·support 사실

## Next queue

### Value now

- 첫 적용 프로젝트에서 실제 focused/release hook과 제품 흐름을 초기화한다.

### Integration risk

- explicit focused/release hook이 broad suite를 암묵적으로 실행하지 않는지와 web overlay가 common 정책을 오염시키지 않는지 확인한다.

### Later improvement

- 사용량 비율 대신 실제 review round-trip과 반복 failure evidence를 보고 role routing을 사람이 재결정한다.
