# Prompt Examples

아래 문장은 명령 형식이 아니라 출발점이다. 필요한 맥락과 원하는 결과를 평소 말하듯 덧붙인다.

## Start or continue

```text
$project-harness 현재 저장소와 docs/STATE.md를 읽고 이 요청의 사용자 가치를 한 문장으로 잡아줘.
가장 작은 End-to-End 단위로 진행하고, 실제 검증 결과와 다음 행동까지 상태에 반영해줘.
```

## Trace before changing

```text
$project-harness [기능 이름]을 수정하기 전에 사용자 행동부터 화면 렌더링까지 실제 코드로 추적해줘.
모르는 부분은 추측과 사실을 구분하고, docs/SYSTEM_MAP.md의 Sequence Diagram과 데이터 계약을 갱신해줘.
아직 코드는 바꾸지 마.
```

## Capture and prioritize requirements

```text
$project-harness 이 요청을 기존 요구사항과 비교하고, 없으면 새 R-### 초안을 만들어줘.
사용자·문제·기대 결과·acceptance criteria·의존성을 정리하고 NOW/NEXT/LATER 우선순위를 제안해줘.
내가 결정해야 하는 priority나 업무 규칙만 따로 표시해줘.
```

## Create a Notion project hub

```text
$project-harness 승인된 parent page 아래에 프로젝트 hub 구성을 preview해줘.
Requirements, Decisions, Work Log, Troubleshooting 네 database가 이미 있는지와 property contract를 먼저 확인하고,
중복 없이 필요한 대상만 만든 뒤 read-back해줘. 실제 ID와 sync 결과는 docs/NOTION.local.md에만 기록해줘.
```

## Sync requirements, decisions and work log to Notion

```text
$project-harness Notion 연결 설정과 property contract를 먼저 확인해줘.
연결되어 있으면 변경될 요구사항·기술 결정과 새 작업일지를 preview하고, 내가 요청한 범위만 동기화해줘.
연결되지 않았거나 database ID가 없으면 값을 추측하지 말고 필요한 연결 정보만 알려줘.
```

## Build a feature

```text
$project-harness [사용자]가 [행동]해서 [결과]를 얻는 가장 얇은 흐름을 구현해줘.
실제 데이터 출처, 바뀌는 contract, mock 잔존 여부를 확인하고 관련 경계 테스트를 실행해줘.
중요한 업무 규칙이나 호환성을 깨는 선택만 내게 물어봐.
```

## Use the owner / implementer split

```text
$project-harness 이 요청의 문제, 책임, 요구사항, acceptance와 중요한 결정은 primary owner가 정리해줘.
구현 가능한 경계가 잡히면 docs/AGENT_ROLES.md 형식으로 custom implementer에게 handoff하고,
implementer가 반환한 변경과 검증을 owner가 contract·acceptance 기준으로 다시 검토해줘.
결정이 필요한 항목은 Luna가 선택하지 말고 Sol owner를 통해 나에게 돌려줘.
```

## Establish a project design direction

```text
$project-harness docs/DESIGN.md의 공통 baseline에서 시작해 이 프로젝트의 visual override만 정리해줘.
사용자와 핵심 화면, accent, typography, density, UI states와 접근성 기준을 제안하고
구현 후 어떤 viewport와 screenshot으로 검증할지도 적어줘.
```

## Draft a trustworthy landing page

```text
$project-harness docs/DESIGN.md와 docs/LANDING.md에서 시작해 [프로젝트] landing을 설계해줘.
audience·핵심 약속·실제 3단계 흐름·증거를 먼저 정리하고, 지원/비지원 범위, 자동화/사람 책임,
데이터 출처·신선도·보관, 실패·부분 실패와 beta/support 경계를 확인된 사실로 보여줘.
mock·planned·real을 구분하고 CTA 상태와 mobile/keyboard 검증 방법까지 포함해줘.
```

## Debug

```text
$project-harness [증상]을 재현하고 오류가 전달되는 경로를 따라 원인을 찾아 최소 수정해줘.
재현 입력, 원인, 수정, 재검증을 남기고 재발 가치가 있으면 TROUBLESHOOTING.md에 정리해줘.
```

## Verify understanding

```text
$project-harness [기능]에 대해 구현은 멈추고 독립적으로 검증해줘.
Sequence Diagram의 각 hop, 데이터 출처, 계약, mock/real 상태와 실패 경로를 실제 명령으로 확인하고
각 테스트가 보장하는 것과 보장하지 않는 것을 보여줘.
```

## Prepare a review or portfolio entry

```text
$project-harness 지금 milestone을 사용자 문제, 내가 내린 결정, 시스템 흐름, 검증 증거,
트러블슈팅과 trade-off 중심으로 정리해줘. 확인되지 않은 성과는 제외해줘.
```

## Ask AI for a verification method, not an answer

```text
내 예상은 [예상 동작]이야. 답을 바로 말하지 말고 이 가설을 확인할 파일, 로그, 요청과 테스트 순서를 제안해줘.
내가 실행한 결과를 주면 예상과 비교해줘.
```
