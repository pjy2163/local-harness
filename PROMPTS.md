# Prompt Examples

아래 문장은 출발점이다. 실제 사용자, 범위, 제약과 원하는 결과를 덧붙인다. 공통 prompt에는 제품별 design·landing·browser 규칙을 넣지 않는다.

## Start or continue

```text
$project-harness 현재 저장소와 docs/STATE.md를 읽고 이 요청의 사용자 가치를 한 문장으로 잡아줘.
가장 작은 End-to-End 단위와 필요한 focused 검증을 진행하고,
실제 결과·미확인·다음 행동을 상태에 반영해줘.
```

## Define a contract

```text
$project-harness 이 요청을 기존 REQUIREMENTS와 비교해줘.
Outcome, in/out of scope, fixed human decisions, acceptance, affected boundaries,
risk, success/failure preflight, focused verification과 escalation condition을 정리해줘.
새 업무 규칙이나 호환성 결정은 내가 선택할 수 있게 남겨줘.
```

## Trace before changing

```text
$project-harness [기능]을 수정하기 전에 사용자 행동 → 상태/API → service/data → response/rendering을
실제 코드로 추적해줘. Source of Truth, contract와 실패 경로를 구분하고 SYSTEM_MAP을 필요한 만큼 갱신해줘.
아직 코드는 바꾸지 마.
```

## Build a feature

```text
$project-harness [사용자]가 [행동]해서 [결과]를 얻는 가장 얇은 흐름을 구현해줘.
현재 결정 밖의 업무·보안·호환성 규칙은 만들지 말고, changed boundary의 성공·실패 검증만 실행해줘.
```

## Debug

```text
$project-harness [증상]을 재현하고 입력부터 오류 표시까지 경계를 따라 원인을 격리해줘.
최소 수정 후 affected test를 재실행하고, 같은 failure가 두 fix→rerun cycle 뒤에도 남으면 patch를 넓히지 말고 escalation해줘.
```

## Review

```text
$project-harness 이 변경을 read-only로 검토해줘.
contract·diff·실제 evidence를 기준으로 BLOCKER/MUST/SHOULD/LEARNING과
보장하지 않는 범위를 짧게 정리해줘. 소스나 테스트는 수정하지 마.
```

## Verify and deliver

```text
$project-harness changed boundary의 focused verification을 실행해줘.
bash scripts/verify.sh --focused를 우선 사용하고, 명시적 release gate가 있을 때만 --release를 사용해줘.
명령·결과·NOT_RUN 사유를 EVIDENCE에 남기고, user acceptance 전에는 WORKLOG closure나 DONE을 쓰지 마.
```

Notion은 연결이 확인되고 외부 write가 명시적으로 승인된 경우에만 `docs/NOTION.local.example.md`의 preview → schema/conflict check → write → read-back 절차를 사용한다. Web-only design, landing과 browser prompt는 `web` branch overlay에서 관리한다.
