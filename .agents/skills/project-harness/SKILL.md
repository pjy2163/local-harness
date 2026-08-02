---
name: project-harness
description: 프로젝트의 현재 상태를 AI가 유지하면서 요구사항·우선순위·Notion 동기화 경계, 공통 디자인과 프로젝트별 visual override, 사용자 흐름, 데이터 출처, API 계약, mock/real 경계, 테스트 증거와 사람 결정을 연결해 작업한다. 새 프로젝트 시작, 요구사항·UI 디자인 정리, 기존 기능 추적, 기능 구현, 디버깅, 검증, 작업일지·트러블슈팅·포트폴리오 정리가 필요할 때 사용한다.
---

# Run the project harness

## Establish current state

1. 루트 `AGENTS.md`를 따른다.
2. `docs/STATE.md`를 읽고, 범위·priority가 관련되면 `docs/REQUIREMENTS.md`, UI·visual 결과가 관련되면 `docs/DESIGN.md`, 기능 흐름이 관련되면 `docs/SYSTEM_MAP.md`를 읽는다.
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

Notion 연결을 요청받으면 `docs/REQUIREMENTS.md`의 property contract와 Git에서 제외되는 `docs/NOTION.local.md`를 먼저 확인한다. 로컬 설정 파일이 없으면 `docs/NOTION.local.example.md`를 안내하고, 연결 전에는 database/page ID를 만들지 않는다. 기본은 로컬에서 Notion으로의 수동 sync이며, 요구사항은 `Requirement ID`, 작업일지는 `Local Entry ID`, 트러블슈팅은 `Incident ID`를 안정적인 키로 사용한다. 양방향 sync, 자동 실행, 삭제 전파와 Source of Truth 변경은 사람에게 결정받는다.

## Apply the design baseline

- UI 작업 전 `docs/DESIGN.md`의 common baseline과 프로젝트 override를 구분한다.
- 프로젝트별 accent, typography, density와 핵심 화면을 정하되 별도 지시가 없으면 white/cool-neutral baseline을 사용한다.
- loading, empty, error, success, partial과 disabled 상태를 핵심 흐름에 포함한다.
- 구현 후 실제 브라우저 또는 screenshot으로 hierarchy, spacing, responsive behavior와 accessibility를 확인한다.
- reference의 브랜드 asset이나 페이지를 그대로 복제하지 않는다.

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
