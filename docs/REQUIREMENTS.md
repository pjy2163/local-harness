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
| R-001 | 공통 하네스에 단순성 원칙, 기술 결정 mirror와 운영 경계 landing template을 제공한다 | 안전한 구현 기본값, 4개 Notion DB 계약, 재사용 landing 구조 | `NOW` | `DONE` | - | 사용자 요청 | 2026-08-05 | Decisions `미동기화` |
| R-002 | 책임·기획·결정과 구현을 모델별 역할로 분리한다 | v1.1 two-role contract; `R-003`에서 superseded | `NOW` | `DONE` | R-001 | 사용자 요청 | 2026-08-10 | `미동기화` |
| R-003 | Terra-main·Luna·Sol multi-stage routing과 commit-scope gate를 제공한다 | fixed roles, single writer, focused-first review와 `600` text lines / `12` text files review stop | `NOW` | `DONE` | R-002 | 2026-08-10 사용자 승인 | 2026-08-10 | `미동기화` |

## Requirement details

### R-001 — 공통 엔지니어링·기술 결정·랜딩 템플릿

- User/problem: 프로젝트마다 단순한 구현 원칙, 기술 결정 기록과 운영 경계를 포함한 랜딩 구조를 다시 정의해야 한다.
- Expected outcome: 새 프로젝트가 같은 엔지니어링 기본값과 로컬→Notion 기록 계약을 사용하고, en:ground처럼 신뢰와 운영 경계를 설명하는 랜딩을 프로젝트 사실로 빠르게 초기화할 수 있다.
- In scope: 이미지에서 재사용 가치가 있는 엔지니어링 원칙의 안전한 반영, Decisions database 계약, Notion project hub blueprint, landing content/operation boundary template과 관련 안내.
- Out of scope: 실제 개인 Notion workspace 생성·쓰기, 특정 프로젝트 랜딩 구현, 외부 브랜드 asset 복제, 자동/양방향 sync.
- Acceptance criteria:
  - [x] 단순성, working vertical slice, 책임 분리, dependency 재사용과 장기 유지 원칙이 기존 소유·호환성 경계와 충돌 없이 문서화된다.
  - [x] `docs/DECISIONS.md`와 Notion Decisions database가 `Decision ID`를 안정 키로 연결된다.
  - [x] Notion project hub를 만들 때 네 database와 각 Source of Truth를 확인할 수 있는 setup blueprint가 있다.
  - [x] landing template이 가치 제안, 실제 흐름, 증거, 운영 경계, 상태/실패와 CTA 검증을 포함한다.
  - [x] 공개 안전 검사와 문서 참조 검사가 통과한다.
- Dependencies: 실제 Notion 생성 시 승인된 parent page와 database/data source ID가 필요하다.
- Source: 2026-08-05 사용자 요청과 첨부 `AGENTS.md` 원칙 이미지.
- Human confirmation: 이 요청 범위는 명시적으로 요청됨. 외부 Notion write와 프로젝트별 브랜드/운영 사실은 별도 확인이 필요함.

### R-002 — Sol owner / Luna implementer 역할 분리

- Historical status: `DONE`; 2026-08-10에 `R-003`으로 superseded. 아래 detail은 v1.1 기록으로 보존한다.

- User/problem: 구현 소음이 책임·결정·기획 맥락과 섞이지 않으면서도 역할별 비용과 추론 깊이를 제어하고 싶다.
- Expected outcome: primary Sol/high가 문제·책임·기획·중요한 결정과 최종 acceptance를 소유하고, 승인된 구현·구체화만 Luna/medium custom agent가 수행한다.
- In scope: project model defaults, custom implementer agent, bounded handoff·escalation contract, harness routing과 검증.
- Out of scope: 자동 병렬 fan-out, 사람 결정을 agent가 승인하는 것, 현재 session의 강제 model 교체, external write와 deployment 위임.
- Acceptance criteria:
  - [x] trusted project의 primary default가 `gpt-5.6-sol` + `high`다.
  - [x] `implementer` custom agent가 `gpt-5.6-luna` + `medium`, workspace-write, Notion disabled로 정의된다.
  - [x] owner/implementer의 책임, bounded handoff 입력, handback 결과와 decision escalation이 문서화된다.
  - [x] project-harness가 의미 있는 구현을 implementer에 위임하고 owner가 결과를 다시 검토하도록 안내한다.
  - [x] Codex config loader, strict-config E2E와 local model catalog에서 설정 값이 확인된다.
- Dependencies: trusted project와 custom subagent를 지원하는 새 Codex session. model/account availability는 runtime에 따라 달라질 수 있다.
- Source: 2026-08-05 사용자 요청. 모델·custom agent 설정 형식은 2026-08-05 조회한 공식 Codex manual의 Subagents / Config 문서.
- Human confirmation: 구현·구체화는 Luna medium, 책임·결정·기획은 Sol high로 분리하라는 명시적 요청.

### R-003 — Terra-main·Luna·Sol multi-stage routing과 commit-scope gate

- User/problem: 일반 구현의 write ownership, 닫힌 작업과 technical approval의 경계를 일관되게 유지하면서 reviewable commit 범위를 강제해야 한다.
- Expected outcome: Terra-main이 `LOW/MEDIUM` single write owner가 되고, Luna·`sol_approver`·`sol_high`가 제한된 handoff만 수행하며 staged review-stop gate가 적용된다.
- In scope: common role/config/skill guidance, named agent configs, active flow/state, `scripts/check-commit-scope.sh`와 관련 README/PROMPTS.
- Out of scope: product-specific verification, role runtime discovery, `docs/DESIGN.md`, Notion schema·external sync, deployment.
- Acceptance criteria:
  - [x] Terra-main, Luna, `sol_approver`, `sol_high`의 model/effort·write/read-only·escalation 경계가 일치한다.
  - [x] focused-first verification, final full regression once, two complete failure-cycle escalation과 human acceptance flow가 문서화된다.
  - [x] staged gate가 `600` non-generated text changed lines 또는 `12` non-generated text files에서 review stop을 낸다.
  - [x] local static checks와 independent Luna re-review, `sol_approver` approval 및 human acceptance가 기록된다.
- Dependencies: named-role runtime discovery와 product verification은 적용 프로젝트의 trusted session/manifest가 필요하다.
- Source: 2026-08-10 사용자 요청과 v1.2 candidate의 explicit approval.
- Human confirmation: 2026-08-10 사용자가 v1.2 candidate를 명시적으로 승인했다.

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
- Stable keys: `Requirement ID`, `Decision ID`, `Local Entry ID`, `Incident ID`
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

### Decisions database

| Notion property | Type | Local field | Required |
|---|---|---|---|
| Decision | Title | Decision heading | Yes |
| Decision ID | Rich text | `ADR-###` | Yes, unique |
| Status | Select | `PROPOSED | ACCEPTED | REJECTED | SUPERSEDED` | Yes |
| Requirement ID | Rich text | Related requirement | No |
| Context | Rich text | Context summary | Yes |
| Decision Summary | Rich text | Decision | Yes |
| Risk | Rich text | Risks | No |
| Verification | Rich text | Verification | No |
| Date | Date | Decision or proposal date | No for legacy baseline, required for new entries |

`Why`, `Alternatives`, `Why excluded`, `Risks`, `Verification`, `Human confirmation`과 상세 내용은 Notion page body에 같은 순서로 넣는다. `ACCEPTED`는 `Human confirmation` 근거가 있는 로컬 항목만 동기화한다.

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

1. `docs/NOTION.local.md`에서 연결과 네 database ID를 확인한다.
2. 실제 property 이름과 type을 contract와 비교한다. 다르면 쓰지 않고 `BLOCKED`로 보고한다.
3. 변경될 요구사항·기술 결정 upsert, 작업일지와 트러블슈팅 sync를 preview한다.
4. 사용자가 요청한 범위만 쓰고 Notion에서 삭제하지 않는다.
5. write 뒤 read-back하고 같은 안정 키로 재실행해 중복 여부를 확인한다.
6. 실제 결과는 `docs/NOTION.local.md`와 `docs/EVIDENCE.md`에 기록한다.

## Notion project hub setup blueprint

새 프로젝트의 parent page를 만들 때 다음 구조를 기본값으로 사용한다. 실제 page/database ID와 property 이름은 생성 또는 read-back 뒤 `docs/NOTION.local.md`에 기록한다.

1. Page title: 프로젝트 이름
2. Intro: 사용자 문제, 현재 outcome, local Markdown이 Source of Truth라는 안내
3. Current status: `docs/STATE.md`의 현재 목표·활성 요구사항·마지막 검증 요약
4. Operating boundary: `docs/LANDING.md`에서 확정된 지원 범위와 책임·데이터·실패 경계
5. Linked databases/data sources:
   - Requirements — `docs/REQUIREMENTS.md`
   - Decisions — `docs/DECISIONS.md`
   - Work Log — `docs/WORKLOG.md`
   - Troubleshooting — `docs/TROUBLESHOOTING.md`
6. Project links: 저장소, 배포, 디자인, runbook 등 실제로 확인된 링크만 사용
7. Sync note: manual `local → Notion`, last sync와 충돌/실패 상태

외부 생성 전 parent page, 생성할 네 database, 예상 property와 생성·수정 건수를 preview한다. 기존 database를 발견하면 새로 만들지 말고 schema와 안정 키를 먼저 비교한다.
