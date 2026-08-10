# Project State

AI가 현재 요청과 저장소를 읽고 이 문서를 유지한다. 확인한 사실과 가정을 섞지 않으며, 사람의 결정을 임의로 `ACCEPTED`로 바꾸지 않는다.

## Snapshot

| Field | Current value |
|---|---|
| Project outcome | 사람이 흐름·계약·운영 경계를 소유하는 재사용 가능한 프로젝트 하네스 |
| Primary user | AI와 함께 개인 프로젝트를 설계·구현·검증하는 사람 |
| Active mode | `정리` |
| Active requirement | `R-003` — v1.2 common baseline |
| Active user flow | Terra-main contract → Luna (적용 시) → `sol_approver` → review packet → human acceptance |
| Current work | Terra-main single-writer와 제한된 Luna/Sol stage contract의 v1.2 baseline이 human acceptance를 받음 |
| Status | `DONE` |
| Next action | 다음 승인된 requirement에서 v1.2 contract를 적용한다. Notion sync는 별도 external-write 요청 때만 검토한다 |
| Last updated | `2026-08-10` |

## Current vertical slice

- User action: 공통 하네스에 Terra-main·Luna·명시적 Sol 역할과 review-stop commit gate를 적용한다.
- Visible result: Terra-main이 일반 구현을 single write owner로 조율하고, Luna/Sol stage와 human acceptance 경계가 문서·config에 일관되게 적용된다.
- Start boundary: `.codex/config.toml`, root `AGENTS.md`와 `project-harness` routing.
- End boundary: named role configs → `sol_approver` review → recorded human acceptance.
- In scope: default model, named role configs, task contract·handoff·escalation, commit-scope script와 local validation.
- Out of scope: `docs/DESIGN.md`, product-specific scripts, external write, deployment와 현재 열린 session의 model 재시작.
- Done when: `R-003`의 focused local checks, independent technical review와 human acceptance가 끝난다.

## Data and contract status

| Item | Source of Truth | State | Producer → Consumer | Contract location | Verified by |
|---|---|---|---|---|---|
| Approved baseline | `R-003` + human acceptance | `REAL` | Human/AI → common baseline | `AGENTS.md`, role docs, skill | local evidence 2026-08-10 |
| Harness setup flow | local Markdown | `REAL` | User request → project template | `AGENTS.md`, skill, `docs/SYSTEM_MAP.md` | reference check `PASS` |
| Notion mirror | local Markdown이 SoT; remote는 선택적 mirror | `MIXED` | local Markdown → Notion | `docs/REQUIREMENTS.md` | 기존 3 DB `SYNCED`, Decisions `NOT_CONFIGURED` |
| Landing content | 프로젝트 facts / `docs/LANDING.md` contract | `UNKNOWN` per project | Requirements·flow·evidence → landing UI | `docs/LANDING.md` | template contract `PASS`, render `NOT_RUN` |
| Agent routing | project config + `docs/AGENT_ROLES.md` | `REAL` | Terra-main → Luna (적용 시) → `sol_approver` → Human | `.codex/config.toml`, `.codex/agents/*.toml` | working-tree contract checks `PASS`; runtime role discovery `NOT_RUN` |

## Active work

| ID | Work | Why now | Status | Evidence |
|---|---|---|---|---|
| R-001 | 공통 엔지니어링·Decisions mirror·landing template | 반복되는 프로젝트 setup과 신뢰 경계를 공통화 | `DONE` | `docs/EVIDENCE.md` 2026-08-05 |
| R-002 | v1.1 predecessor two-role routing | 책임 맥락과 구현 소음을 분리하고 단계별 비용·깊이를 제어 | `DONE` / v1.2에서 superseded | `docs/EVIDENCE.md` 2026-08-05 17:06 KST |
| R-003 | Terra-main·Luna·Sol multi-stage routing | common baseline의 active routing을 current contract로 교체 | `DONE` | `docs/EVIDENCE.md` 2026-08-10; human accepted |

## Risks, assumptions and unknowns

| Type | Item | Impact | How to resolve | Owner |
|---|---|---|---|---|
| Unknown | 프로젝트별 audience, 실제 기능·증거와 운영 정책 | landing copy와 UI를 아직 구현할 수 없음 | 해당 프로젝트 시작 시 `docs/LANDING.md` 초기화 | Human |
| External state | 현재 Notion hub의 Decisions DB가 없음 | 기술 결정은 아직 local-only | 외부 write 요청 시 schema preview 후 Decisions만 생성 | Human + AI |
| Reference gap | en:ground의 공개 페이지를 특정하지 못함 | 특정 시각·콘텐츠 세부는 반영하지 않음 | 필요하면 정확한 URL/screenshot으로 project override 작성 | Human |
| Runtime | named role config는 새 trusted session에서만 role discovery를 검증할 수 있음 | v1.2 runtime spawn은 `NOT_RUN` | 다음 trusted session에서 필요할 때 focused role discovery 실행 | Human + AI |

## Human decisions needed

- 현재 연결된 Notion hub에 Decisions DB를 실제로 생성할지
- 첫 적용 프로젝트의 audience, 제공/비지원 범위, 데이터·privacy·support 사실

## Next queue

### Value now

- 다음 승인된 requirement에서 v1.2 contract를 적용한다.

### Integration risk

- Luna closed write stage가 Terra-main과 같은 worktree에서 병렬로 쓰지 않고, `sol_high` escalation이 두 complete failure cycle 뒤에만 발생하는지 확인한다.

### Later improvement

- 실제 작업의 latency·token 사용과 decision round-trip을 보고 role routing을 조정한다.
