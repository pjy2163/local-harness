# Project State

AI가 현재 요청과 저장소를 읽고 이 문서를 유지한다. 확인한 사실과 가정을 섞지 않으며, 사람의 결정을 임의로 `ACCEPTED`로 바꾸지 않는다.

## Snapshot

| Field | Current value |
|---|---|
| Project outcome | 사람이 흐름·계약·운영 경계를 소유하는 재사용 가능한 프로젝트 하네스 |
| Primary user | AI와 함께 개인 프로젝트를 설계·구현·검증하는 사람 |
| Active mode | `구현·검증` |
| Active requirement | v1.4 lightweight eval candidate; R-004는 승인된 기존 baseline |
| Active user flow | 작은 contract → 단일 writer → affected evidence → LOW 보고 / 필요한 고위험 review |
| Current work | 유지보수 전용 skill·LOW 종료 경량화와 행동 eval 두 사례를 공통 candidate에 반영 |
| Status | `ACTIVE` — static checks and behavior evals 2/2 PASS; user acceptance pending |
| Next action | 사용자 검토 뒤 commit/push와 common/web 반영 여부를 결정한다. 현재는 로컬 candidate |
| Last updated | `2026-09-03` |

## Current vertical slice

현재 v1.4의 범위·검수 결과는 `docs/EVIDENCE.md`의 candidate 항목을 따른다. 아래 R-004 설명과 완료 이력은 v1.3 baseline이며 이번 candidate의 PASS 또는 배포 승인이 아니다.

- User action: template owner가 common 또는 web variant를 선택하고 closed contract를 시작한다.
- Visible result: 단일 implementation writer, 조건부 Sol review와 explicit verification 경계가 문서·config에 연결된다.
- Start boundary: `.codex/config.toml`, `.codex/agents/`, root `AGENTS.md`, role docs와 `scripts/verify.sh`.
- End boundary: evidence → review packet → human acceptance.
- In scope: role routing, docs, README, common/web branches와 verification hooks.
- Out of scope: TIEAT product code, Notion external write, deployment와 history rewrite.
- Done when: `R-004` acceptance, focused evidence, technical review, human acceptance와 push가 끝난다.

## Data and contract status

| Item | Source of Truth | State | Producer → Consumer | Contract location | Verified by |
|---|---|---|---|---|---|
| Approved baseline | `R-004` accepted v1.3 baseline | `REAL` | Human/AI → v1.3 common baseline | `AGENTS.md`, role docs, skill | focused checks, Sol approval, human acceptance and non-force push `PASS` |
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

## Risks, assumptions and unknowns

| Type | Item | Impact | How to resolve | Owner |
|---|---|---|---|---|
| Unknown | 프로젝트별 audience, 실제 기능·증거와 운영 정책 | landing copy와 UI를 아직 구현할 수 없음 | web overlay 선택 시 실제 사실로 초기화 | Human |
| External state | Notion target과 schema가 연결되지 않음 | 기술 결정은 local-only | 외부 write 요청 시 schema preview 후 사람이 승인 | Human + AI |
| Reference gap | web 프로젝트의 visual reference가 아직 없음 | 특정 시각·콘텐츠 세부는 반영하지 않음 | 정확한 URL/screenshot으로 web override 작성 | Human |
| Runtime | named role config는 새 trusted session에서만 role discovery를 검증할 수 있음 | v1.3 runtime spawn은 `NOT_RUN` | 다음 trusted session에서 필요할 때 focused role discovery 실행 | Human + AI |
| Acceptance | v1.3 문서·README와 web overlay의 사람 승인이 완료됨 | future changes require a new review unit | 다음 요구사항에서 별도 acceptance | Human |
| Branch/remote | local common/web branch 정렬과 GitHub non-force push가 완료됨 | future remote changes are outside this unit | 새 변경만 명시적으로 push | Human + AI |

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
