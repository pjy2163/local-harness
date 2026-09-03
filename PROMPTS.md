# Prompt Examples

아래 문장은 출발점이다. 실제 사용자, 범위, 제약과 원하는 결과를 덧붙인다. 공통 prompt에는 제품별 design·landing·browser 규칙을 넣지 않는다.

## Start or continue

```text
관련 코드를 읽고 목표·비목표·검수 기준·보존 범위를 짧게 정리해줘.
가장 작은 변경과 관련 기존 테스트로 완료하고 실제 결과·미확인을 보고해줘.
LOW이면 별도 Sol 승인과 문서 closure는 하지 마.
```

## Define a contract

```text
이 요청을 기존 REQUIREMENTS와 비교해줘.
Outcome, in/out of scope, fixed human decisions, acceptance, affected boundaries,
risk, success/failure preflight, focused verification과 escalation condition을 정리해줘.
새 업무 규칙이나 호환성 결정은 내가 선택할 수 있게 남겨줘.
```

## Trace before changing

```text
[기능]을 수정하기 전에 사용자 행동 → 상태/API → service/data → response/rendering을
실제 코드로 추적해줘. Source of Truth, contract와 실패 경로를 구분하고 SYSTEM_MAP을 필요한 만큼 갱신해줘.
아직 코드는 바꾸지 마.
```

## Build a feature

```text
[사용자]가 [행동]해서 [결과]를 얻는 가장 얇은 흐름을 구현해줘.
현재 결정 밖의 업무·보안·호환성 규칙은 만들지 말고, changed boundary의 성공·실패 검증만 실행해줘.
```

## Debug

```text
[증상]을 재현하고 입력부터 오류 표시까지 경계를 따라 원인을 격리해줘.
최소 수정 후 affected test를 재실행하고, 같은 failure가 두 fix→rerun cycle 뒤에도 남으면 patch를 넓히지 말고 escalation해줘.
```

## Review

```text
이 변경을 read-only로 검토해줘.
contract·diff·실제 evidence를 기준으로 BLOCKER/MUST/SHOULD/LEARNING과
보장하지 않는 범위를 짧게 정리해줘. 소스나 테스트는 수정하지 마.
```

## Verify and deliver

```text
changed boundary의 focused verification을 실행해줘.
bash scripts/verify.sh --focused를 우선 사용하고, 명시적 release gate가 있을 때만 --release를 사용해줘.
명령·결과·NOT_RUN 사유를 보고해줘. LOW는 보고로 끝내고,
그 밖의 작업은 필요한 review·user acceptance와 지속 evidence를 유지해줘.
```

Notion은 연결이 확인되고 외부 write가 명시적으로 승인된 경우에만 `docs/NOTION.local.example.md`의 preview → schema/conflict check → write → read-back 절차를 사용한다. Web-only design, landing과 browser prompt는 `web` branch overlay에서 관리한다.

## Maintain or evaluate the harness

```text
$project-harness 이번 하네스 변경만 최소 적용해줘.
Luna max와 기존 안전 경계를 유지하고, docs/EVALS.md의 관련 사례만 격리된 프로젝트에서 실행해줘.
정적 검사와 실제 행동 eval 결과를 구분해서 보고해줘.
```
