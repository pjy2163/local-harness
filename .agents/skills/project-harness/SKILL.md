---
name: project-harness
description: 프로젝트의 현재 상태를 AI가 유지하면서 요구사항·우선순위·Notion 동기화 경계, 공통 디자인과 프로젝트별 visual override, 사용자 흐름, 데이터 출처, API 계약, mock/real 경계, 테스트 증거와 사람 결정을 연결해 작업한다. 새 프로젝트 시작, 요구사항·UI 디자인 정리, 기존 기능 추적, 기능 구현, 디버깅, 검증, 작업일지·트러블슈팅·포트폴리오 정리가 필요할 때 사용한다.
---

# Run the project harness

## Establish current state

1. 루트 `AGENTS.md`를 따른다.
2. `docs/STATE.md`를 읽고, 범위·priority가 관련되면 `docs/REQUIREMENTS.md`, UI·visual 결과가 관련되면 `docs/DESIGN.md`, landing·운영 경계가 관련되면 `docs/LANDING.md`, 기능 흐름이 관련되면 `docs/SYSTEM_MAP.md`, 구현 위임·모델 역할이 관련되면 `docs/AGENT_ROLES.md`를 읽는다.
3. 사용자 요청과 저장소 증거로 작업 방식을 `이해/설계`, `구현`, `디버그`, `검증`, `정리` 중 하나로 정한다.
4. 현재 사용자 가치, 가장 작은 vertical slice, 상태와 다음 행동을 `docs/STATE.md`에 갱신한다.
5. 모르는 값은 만들지 말고 `가정` 또는 `미확인`으로 표시한다.

고정된 단계 수, 타임박스, AI 기능 개수 또는 승인 게이트를 추가하지 않는다. 사용자가 지정한 제약은 그대로 따른다.

## Maintain requirements

- 요청을 기존 `R-###` 요구사항에 연결하고 없으면 `DRAFT` 초안을 만든다.
- 사용자, 문제, 기대 결과, acceptance criteria, priority, 의존성과 출처를 필요한 만큼만 기록한다.
- AI가 priority와 acceptance criteria를 제안하되 사람의 명시적 결정을 임의로 만들지 않는다.
- `docs/STATE.md`에는 활성 요구사항 ID와 실행 상태만 두고 상세 내용을 중복하지 않는다.
- 구현 완료는 acceptance criteria와 실제 `docs/EVIDENCE.md`를 비교해 판정한다.

Notion 연결을 요청받으면 `docs/REQUIREMENTS.md`의 property contract와 Git에서 제외되는 `docs/NOTION.local.md`를 먼저 확인한다. 로컬 설정 파일이 없으면 `docs/NOTION.local.example.md`를 안내하고, 연결 전에는 database/page ID를 만들지 않는다. 기본은 로컬에서 Notion으로의 수동 sync이며, 요구사항은 `Requirement ID`, 기술 결정은 `Decision ID`, 작업일지는 `Local Entry ID`, 트러블슈팅은 `Incident ID`를 안정적인 키로 사용한다. 양방향 sync, 자동 실행, 삭제 전파와 Source of Truth 변경은 사람에게 결정받는다.

중요한 기술 선택은 `docs/DECISIONS.md`에 먼저 초안으로 남긴다. AI는 대안과 근거를 제안할 수 있지만 사람의 확인 없이 `ACCEPTED`로 만들지 않는다. Notion에는 로컬 결정을 같은 `Decision ID`로 mirror하고, Notion에서 만든 상태를 로컬 결정처럼 역수입하지 않는다.

## Apply the design baseline

- UI 작업 전 `docs/DESIGN.md`의 common baseline과 프로젝트 override를 구분한다.
- 프로젝트별 accent, typography, density와 핵심 화면을 정하되 별도 지시가 없으면 white/cool-neutral baseline을 사용한다.
- loading, empty, error, success, partial과 disabled 상태를 핵심 흐름에 포함한다.
- 구현 후 실제 브라우저 또는 screenshot으로 hierarchy, spacing, responsive behavior와 accessibility를 확인한다.
- reference의 브랜드 asset이나 페이지를 그대로 복제하지 않는다.

landing page를 만들거나 바꿀 때는 `docs/LANDING.md`에서 해당 프로젝트에 필요한 항목만 초기화한다. 가치 제안과 실제 흐름 뒤에 지원 범위, 자동화/사람 책임, 데이터 출처·신선도, 실패 동작, 개인정보·보관과 지원 채널을 보여준다. 확인되지 않은 기능·지표·고객 로고는 쓰지 않고, CTA의 loading/error/success와 모바일·keyboard 흐름을 실제 렌더링으로 검증한다.

## Apply the engineering defaults

- 승인된 현재 요구사항을 완전히 충족하는 가장 단순한 구현을 선택하고 실제 교체점이 없는 추측성 추상화·설정·간접 계층은 추가하지 않는다.
- 작동하는 가장 작은 End-to-End 흐름에서 시작해 capability를 한 겹씩 추가한다.
- 새 코드나 package 전에 현재 dependency의 문서·types·지원 범위를 확인하고, 유지보수되는 library가 전체 복잡도나 신뢰성 비용을 낮출 때 재사용한다.
- 승인된 요구사항이 내부 경로를 대체하면 obsolete path와 불필요한 fallback을 제거한다. 공개 API·저장 데이터·외부 소비자 계약 파괴와 migration은 사람의 결정 전에는 실행하지 않는다.
- 임시 stopgap을 기본 해법으로 남기지 않는다. 승인된 긴급 우회만 owner와 제거 조건을 함께 기록한다.

## Trace the affected flow

의미 있는 기능 또는 데이터 변경 전에는 필요한 범위만 실제 코드로 추적한다.

```text
사용자 행동 → Frontend → API → Backend → Service → Data source
           ← 렌더링 ← 변환 ← Response ← 도메인 결과 ← 원본 데이터
```

- 각 hop의 파일과 symbol, 입력·출력, 책임과 실패 경로를 찾는다.
- 데이터 형태가 바뀌는 위치와 실제 Source of Truth를 확인한다.
- 없는 계층은 `해당 없음`, 실행으로 확인하지 않은 내용은 `미확인`으로 둔다.
- 흐름, contract, 데이터 출처 또는 mock 상태가 바뀌면 `docs/SYSTEM_MAP.md`를 갱신한다.
- 읽기·설명 요청에서는 제품 코드를 수정하지 않는다.

## Choose and execute the next action

- 지금 가치, 통합 위험, 나중 개선을 구분한다.
- 현재 요청을 만족하는 가장 작은 End-to-End 단위를 선택한다.
- 기존 계약과 패턴을 우선 사용한다. 새로운 계층이나 추상화는 실제 교체점 또는 중복 책임이 있을 때만 만든다.
- Mock과 Real이 공존하면 같은 consumer-facing contract를 사용하고 선택 방식, production guard와 contract test를 확인한다.
- 기존 인간 결정 안의 구현, 작은 리팩터링, 테스트와 문서 동기화는 계속 진행한다.
- 승인된 요구사항과 범위 안에서만 구현한다. 완료 후 다음 요구사항을 자동으로 시작하지 않고 사람이 구현 대상을 선택하게 한다.
- 문제·Source of Truth·새 업무 규칙·호환성을 깨는 계약·중요한 아키텍처·보안/권한·되돌리기 어려운 외부 변경이 필요하면 정확한 결정만 사람에게 요청한다.

## Route implementation by role

- primary `gpt-5.6-sol` + `high` agent가 문제, 요구사항, priority 제안, 책임, 기획, 중요한 결정, acceptance와 인간 질문을 소유한다.
- 의미 있는 구현·UI 구체화·configuration 변경은 `docs/AGENT_ROLES.md`의 handoff가 준비된 뒤 custom `implementer` agent에 위임한다. 이 agent는 `gpt-5.6-luna` + `medium`으로 실행한다.
- handoff에는 Requirement ID, 사용자에게 보이는 결과, 허용 경계, 보존할 contract, acceptance criteria, 관련 검사와 out-of-scope를 포함한다.
- implementer는 범위 안에서 코드와 테스트를 수행하고 결정이 필요한 지점을 owner에게 반환한다. primary는 결과를 독립적으로 검토하고 acceptance·상태·외부 기록을 책임진다.
- agent/model을 현재 runtime에서 사용할 수 없으면 대체 model로 조용히 진행하지 않고 availability와 대안을 사람에게 알린다.

## Verify by boundary

변경한 경계에 비례해 Unit, Contract, Integration, E2E, Failure 검사를 선택한다.

1. 먼저 기존 실패를 재현하거나 기대 결과를 명시한다.
2. 관련 검증 명령을 실제로 실행한다.
3. 각 검사가 보장하는 것과 보장하지 않는 것을 구분한다.
4. 실행 결과를 `docs/EVIDENCE.md`에 추가한다. 실행하지 않은 검사는 `PASS`로 쓰지 않는다.
5. 실패하면 원인을 좁혀 최소 수정하고 관련 검사와 필요한 회귀 검사를 재실행한다.

독립 검증이나 읽기 전용 리뷰를 요청받으면 제품 소스를 수정하지 않고 실패 재현과 근거만 보고한다.

## Keep external memory useful

루트 `AGENTS.md`의 Documentation policy에 해당할 때만 문서를 갱신한다.

- 모든 의미 있는 작업: `docs/STATE.md`
- 요구사항·priority·Notion property contract 변경: `docs/REQUIREMENTS.md`
- 실제 Notion 대상·연결·sync 결과 변경: `docs/NOTION.local.md` (Git 제외)
- 공통 design baseline 변경: `docs/DESIGN.md`
- landing 정보 구조·운영 경계 변경: `docs/LANDING.md`
- model routing·역할·handoff 변경: `docs/AGENT_ROLES.md`
- 실행 증거: `docs/EVIDENCE.md`
- 흐름·contract 변경: `docs/SYSTEM_MAP.md`
- 인간이 확정한 중요한 선택: `docs/DECISIONS.md`
- 완료된 작업 단위: `docs/WORKLOG.md`
- 재사용 가치가 있는 장애 해결: `docs/TROUBLESHOOTING.md`
- 사용자 가치가 입증된 milestone: `docs/PORTFOLIO.md`

문서를 채우기 위해 사실을 반복하거나 빈 섹션을 늘리지 않는다.

## Finish with ownership

결과 보고에는 필요한 항목만 포함한다.

- 사용자가 얻는 결과와 실제 변경
- 활성 요구사항과 충족한 acceptance criteria
- 사용자 행동부터 결과까지의 흐름 요약
- 실제 데이터 출처와 바뀐 contract
- 실행한 검증, 보장 범위와 남은 미확인
- 사람이 이해하거나 결정해야 하는 항목
- 다음으로 가장 가치 있는 한 단계
