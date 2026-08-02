# Project State

AI가 현재 요청과 저장소를 읽고 이 문서를 유지한다. 확인한 사실과 가정을 섞지 않으며, 사람의 결정을 임의로 `ACCEPTED`로 바꾸지 않는다.

## Snapshot

| Field | Current value |
|---|---|
| Project outcome | `미정 — 첫 프로젝트에서 사람과 정의` |
| Primary user | `미정` |
| Active mode | `이해/설계` |
| Active requirement | `없음` |
| Active user flow | `미확인` |
| Current work | 공통 템플릿을 프로젝트 사실로 초기화 |
| Status | `BACKLOG` |
| Next action | 사람이 비즈니스 목표와 첫 구현 후보를 제시하면 가장 얇은 E2E 범위를 초안으로 만든다 |
| Last updated | `미정` |

## Current vertical slice

- User action: `미정`
- Visible result: `미정`
- Start boundary: `미확인`
- End boundary: `미확인`
- In scope: `사람 승인 전 미정`
- Out of scope: `사람 승인 전 미정`
- Done when: `acceptance criteria 승인 후 기록`

## Data and contract status

| Item | Source of Truth | State | Producer → Consumer | Contract location | Verified by |
|---|---|---|---|---|---|
| Active requirement | `docs/REQUIREMENTS.md` | `UNKNOWN` | Human/AI → 구현·검증 | `docs/REQUIREMENTS.md` | `NOT_RUN` |
| Active flow | 실제 제품 코드 | `UNKNOWN` | User action → visible result | `docs/SYSTEM_MAP.md` | `NOT_RUN` |
| Notion mirror | `docs/NOTION.local.md`가 있을 때만 사용 | `UNKNOWN` | local Markdown → Notion | `docs/REQUIREMENTS.md` | `NOT_RUN` |

## Active work

| ID | Work | Why now | Status | Evidence |
|---|---|---|---|---|
| - | 아직 승인된 작업 없음 | 첫 프로젝트 맥락 필요 | `BACKLOG` | - |

## Risks, assumptions and unknowns

| Type | Item | Impact | How to resolve | Owner |
|---|---|---|---|---|
| Unknown | 사용자, 비즈니스 목표와 Source of Truth | 구현 범위를 정할 수 없음 | 첫 요구사항 대화에서 확인 | Human |

## Human decisions needed

- 해결할 사용자 문제와 첫 구현 요구사항
- 초기 priority와 acceptance criteria

## Next queue

### Value now

- 첫 프로젝트의 비즈니스 목표와 가장 얇은 사용자 흐름을 정의한다.

### Integration risk

- 실제 데이터 출처와 기존 계약은 저장소 조사 전까지 `미확인`으로 유지한다.

### Later improvement

- 실제 사용에서 반복되는 규칙만 공통 하네스로 승격한다.
