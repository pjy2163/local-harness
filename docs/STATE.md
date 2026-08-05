# Project State

AI가 현재 요청과 저장소를 읽고 이 문서를 유지한다. 확인한 사실과 가정을 섞지 않으며, 사람의 결정을 임의로 `ACCEPTED`로 바꾸지 않는다.

## Snapshot

| Field | Current value |
|---|---|
| Project outcome | 사람이 흐름·계약·운영 경계를 소유하는 재사용 가능한 프로젝트 하네스 |
| Primary user | AI와 함께 개인 프로젝트를 설계·구현·검증하는 사람 |
| Active mode | `정리` |
| Active requirement | `R-002` |
| Active user flow | Sol/high owner framing → Luna/medium implementation → Sol integration review |
| Current work | Sol/high owner와 Luna/medium implementer 역할 분리·실제 spawn 검증 완료 |
| Status | `DONE` |
| Next action | 다음 의미 있는 구현 요청부터 Sol owner가 bounded handoff를 만들고 `implementer` 결과를 통합 검토한다 |
| Last updated | `2026-08-05` |

## Current vertical slice

- User action: 구현·구체화는 Luna medium, 책임·결정·기획은 Sol high로 역할 분리를 요청한다.
- Visible result: 새 trusted session에서 Sol owner가 bounded handoff를 만들고 Luna implementer가 승인 범위만 구현한다.
- Start boundary: `.codex/config.toml`, root `AGENTS.md`와 `project-harness` routing.
- End boundary: `.codex/agents/implementer.toml` handback → Sol owner의 acceptance·상태·결정 통합.
- In scope: `R-002`의 model defaults, custom agent, 책임·handoff·escalation contract와 local validation.
- Out of scope: 현재 열린 session의 model 재시작, 자동 병렬 fan-out, external write와 deployment.
- Done when: `R-002` acceptance criteria와 local config/model 검사가 통과한다.

## Data and contract status

| Item | Source of Truth | State | Producer → Consumer | Contract location | Verified by |
|---|---|---|---|---|---|
| Active requirement | `docs/REQUIREMENTS.md` | `REAL` | Human/AI → 구현·검증 | `docs/REQUIREMENTS.md` | contract check `PASS` |
| Harness setup flow | local Markdown | `REAL` | User request → project template | `AGENTS.md`, skill, `docs/SYSTEM_MAP.md` | reference check `PASS` |
| Notion mirror | local Markdown이 SoT; remote는 선택적 mirror | `MIXED` | local Markdown → Notion | `docs/REQUIREMENTS.md` | 기존 3 DB `SYNCED`, Decisions `NOT_CONFIGURED` |
| Landing content | 프로젝트 facts / `docs/LANDING.md` contract | `UNKNOWN` per project | Requirements·flow·evidence → landing UI | `docs/LANDING.md` | template contract `PASS`, render `NOT_RUN` |
| Agent routing | project config + `docs/AGENT_ROLES.md` | `REAL` | Sol owner → Luna implementer → Sol review | `.codex/config.toml`, `.codex/agents/implementer.toml` | loader/catalog/spawn `PASS` |

## Active work

| ID | Work | Why now | Status | Evidence |
|---|---|---|---|---|
| R-001 | 공통 엔지니어링·Decisions mirror·landing template | 반복되는 프로젝트 setup과 신뢰 경계를 공통화 | `DONE` | `docs/EVIDENCE.md` 2026-08-05 |
| R-002 | Sol owner / Luna implementer 역할 분리 | 책임 맥락과 구현 소음을 분리하고 단계별 비용·깊이를 제어 | `DONE` | `docs/EVIDENCE.md` 2026-08-05 17:06 KST |

## Risks, assumptions and unknowns

| Type | Item | Impact | How to resolve | Owner |
|---|---|---|---|---|
| Unknown | 프로젝트별 audience, 실제 기능·증거와 운영 정책 | landing copy와 UI를 아직 구현할 수 없음 | 해당 프로젝트 시작 시 `docs/LANDING.md` 초기화 | Human |
| External state | 현재 Notion hub의 Decisions DB가 없음 | 기술 결정은 아직 local-only | 외부 write 요청 시 schema preview 후 Decisions만 생성 | Human + AI |
| Reference gap | en:ground의 공개 페이지를 특정하지 못함 | 특정 시각·콘텐츠 세부는 반영하지 않음 | 필요하면 정확한 URL/screenshot으로 project override 작성 | Human |
| Runtime | project config는 이미 열린 session에 소급 적용되지 않음 | 이 대화의 root model은 바뀌지 않음 | 다음 일반 작업은 새 trusted session에서 시작 | Human + AI |

## Human decisions needed

- 현재 연결된 Notion hub에 Decisions DB를 실제로 생성할지
- 첫 적용 프로젝트의 audience, 제공/비지원 범위, 데이터·privacy·support 사실

## Next queue

### Value now

- 다음 의미 있는 구현에서 실제 requirement를 bounded handoff로 전달하고 latency·품질을 관찰한다.

### Integration risk

- handoff가 불완전하거나 구현 중 업무 결정이 생길 때 Luna가 임의 선택하지 않고 Sol로 반환하는지 확인한다.

### Later improvement

- 실제 작업의 latency·token 사용과 decision round-trip을 보고 Luna/Terra routing을 조정한다.
