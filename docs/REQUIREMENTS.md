# Requirements and Notion Contract

이 문서는 안정적인 요구사항 원장이다. `docs/STATE.md`는 현재 실행 상태만 유지하고, 구현·검증·작업일지는 `Requirement ID`로 이 문서와 연결한다.

## Vocabulary

- Priority: `NOW | NEXT | LATER`
- Status: `DRAFT | READY | ACTIVE | BLOCKED | DONE | REMOVED`
- Sync: `NOT_CONNECTED | READY | RUNNING | SYNCED | PARTIAL | FAILED`

`NOW`는 현재 가치, `NEXT`는 다음 가치 또는 통합 위험, `LATER`는 현재 결과를 막지 않는 개선이다. 사람은 최종 priority와 acceptance criteria를 결정하고 AI는 후보와 상태를 관리한다.

## Requirement index

| ID | Requirement / expected outcome | Acceptance summary | Priority | Status | Depends on | Source | Updated | Notion |
|---|---|---|---|---|---|---|---|---|
| - | 첫 프로젝트에서 작성 | - | - | - | - | - | - | `미연결` |

## Requirement detail template

### R-000 — 요구사항 제목

- User/problem:
- Expected outcome:
- In scope:
- Out of scope:
- Acceptance criteria:
  - [ ] 관찰하거나 실행해 판정할 수 있는 기준
- Dependencies:
- Source:
- Human confirmation:

## Notion boundary

- Source of Truth: local Markdown
- Default sync: manual `local → Notion`
- Remote target and sync state: Git에서 제외되는 `docs/NOTION.local.md`
- Public setup template: `docs/NOTION.local.example.md`
- Stable keys: `Requirement ID`, `Local Entry ID`, `Incident ID`
- Not included without human approval: 양방향 sync, 자동 실행, 삭제 전파와 Source of Truth 변경

Notion 대상 ID는 credential은 아니지만 개인 workspace 구조를 드러낼 수 있으므로 공통 공개 템플릿에 커밋하지 않는다. OAuth token과 API secret은 어떤 문서에도 기록하지 않는다.

## Notion property contract

### Requirements database

| Notion property | Type | Local field | Required |
|---|---|---|---|
| Requirement | Title | Requirement / expected outcome | Yes |
| Requirement ID | Rich text | ID | Yes, unique |
| Priority | Select | `NOW | NEXT | LATER` | Yes |
| Status | Select | Requirement status | Yes |
| Acceptance | Rich text | Acceptance criteria | Yes |
| Dependencies | Rich text | Depends on | No |
| Source | URL or Rich text | Source | No |
| Last updated | Date | Last local update | Yes |

### Work Log database

| Notion property | Type | Local field | Required |
|---|---|---|---|
| Summary | Title | Work log heading | Yes |
| Local Entry ID | Rich text | `YYYY-MM-DD/slug` | Yes, unique |
| Requirement ID | Rich text | Related requirement | Yes |
| User value | Rich text | User value | Yes |
| Verification | Rich text | Verification | No |
| Remaining | Rich text | Remaining | No |
| Date | Date | Entry date | Yes |

`What changed`, `Flow / contract affected`, `What I learned or can now explain`과 상세 내용은 Notion page body에 같은 순서로 넣는다.

### Troubleshooting database

| Notion property | Type | Local field | Required |
|---|---|---|---|
| Symptom | Title | Entry heading | Yes |
| Incident ID | Rich text | `TS-YYYYMMDD-short-slug` | Yes, unique |
| Requirement ID | Rich text | Related requirement | Yes |
| Status | Select | `OPEN | RESOLVED | MONITORING` | Yes |
| Root Cause | Rich text | Root cause | Yes |
| Verification | Rich text | Verification | No |
| Date | Date | Incident date | Yes |

`Context`, `Reproduction`, `Observed error`, `Fix`, `Prevention / detection`, `Related flow or contract`는 Notion page body에 같은 순서로 넣는다.

## Sync procedure

1. `docs/NOTION.local.md`에서 연결과 세 database ID를 확인한다.
2. 실제 property 이름과 type을 contract와 비교한다. 다르면 쓰지 않고 `BLOCKED`로 보고한다.
3. 변경될 요구사항 upsert, 작업일지와 트러블슈팅 sync를 preview한다.
4. 사용자가 요청한 범위만 쓰고 Notion에서 삭제하지 않는다.
5. write 뒤 read-back하고 같은 안정 키로 재실행해 중복 여부를 확인한다.
6. 실제 결과는 `docs/NOTION.local.md`와 `docs/EVIDENCE.md`에 기록한다.
