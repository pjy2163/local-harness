---
name: project-harness
description: 요청을 현재 상태·요구사항·사용자 흐름·데이터 출처·검증 증거와 연결하고, 가장 작은 변경을 안전하게 완료한다.
---

# Run the project harness

## Establish current state

1. 루트 `AGENTS.md`를 읽는다.
2. `docs/STATE.md`를 먼저 읽고, 필요할 때 `REQUIREMENTS.md`, `DESIGN.md`, `SYSTEM_MAP.md`, `TROUBLESHOOTING.md`, `EVIDENCE.md`, `AGENT_ROLES.md`를 연다.
3. Notion이 실제로 연결된 경우에만 ignored `docs/NOTION.local.md`를 읽고, 그렇지 않으면 `docs/NOTION.local.example.md`를 참고한다.
4. 요청을 `이해/설계`, `구현`, `디버그`, `검토`, `검증`, `정리` 중 하나로 분류한다.
5. 확인한 사실·가정·추론·미확인을 구분하고 현재 목표·활성 unit·다음 행동을 `docs/STATE.md`에 유지한다.

빈 값은 추측으로 채우지 않는다. 확인하지 못한 값은 `가정` 또는 `미확인`으로 남긴다.

## Route by intent

| Intent | Read first | Action |
|---|---|---|
| implementation | `STATE → REQUIREMENTS → SYSTEM_MAP` | closed contract → smallest vertical slice → focused verification |
| debug | `STATE → TROUBLESHOOTING → affected flow` | reproduce → isolate boundary → narrow fix → rerun |
| review | `STATE → contract/diff` | read-only findings with evidence |
| UI | `STATE → DESIGN → SYSTEM_MAP` | states/responsive scope → browser or screenshot check |
| verification | `STATE → EVIDENCE → affected files` | run the narrow command → record PASS/FAIL/NOT_RUN |
| delivery | `STATE → EVIDENCE → WORKLOG/NOTION.local` | review packet → user acceptance → closure batch |

고정된 단계 수나 모든 요청에 적용되는 승인 게이트를 추가하지 않는다. 사용자가 지정한 제약은 그대로 따른다.

## Maintain requirements

- 요청을 기존 `R-###` 요구사항에 연결하고 없으면 `DRAFT` 초안을 만든다.
- 사용자, 문제, 기대 결과, acceptance criteria, priority, 의존성과 출처를 필요한 만큼만 기록한다.
- AI가 priority와 acceptance criteria를 제안하되 사람의 명시적 결정을 임의로 만들지 않는다.
- `docs/STATE.md`에는 활성 요구사항 ID와 실행 상태만 두고 상세 내용을 중복하지 않는다.
- 구현 완료는 acceptance criteria와 실제 `docs/EVIDENCE.md`를 비교해 판정한다.

Notion은 선택적 수동 단방향 mirror다. 로컬 Markdown이 Source of Truth이고, 실제 연결이 없으면 `docs/NOTION.local.example.md`만 참고한다. 실제 대상·schema·stable key를 추측하지 않으며, preview·conflict check·write·read-back 없이 외부에 쓰지 않는다. 상세 connection과 property contract는 `docs/NOTION.local.example.md` 한 곳에 둔다.

중요한 기술 선택은 `docs/DECISIONS.md`에 먼저 초안으로 남긴다. AI는 대안과 근거를 제안할 수 있지만 사람의 확인 없이 `ACCEPTED`로 만들지 않는다. Notion에는 로컬 결정을 같은 `Decision ID`로 mirror하고, Notion에서 만든 상태를 로컬 결정처럼 역수입하지 않는다.

## Apply the design boundary

- UI 작업은 상태·반응형 범위·접근성을 먼저 정하고 실제 브라우저 또는 screenshot으로 확인한다.
- 공통 branch는 특정 색상, typography, landing narrative 또는 browser tool을 강제하지 않는다.
- `web` branch의 `DESIGN.md`, `LANDING.md`, browser/screenshot guidance는 web overlay로만 적용한다.
- 프로젝트별 landing은 실제 기능·증거·운영 경계로 초기화한다. mock·planned·미검증 기능을 delivered claim으로 쓰지 않는다.

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

- `luna_max`는 기존 사람 결정 안의 닫힌 `LOW/MEDIUM` contract에서 production code, tests, focused verification, fixes, evidence와 필요한 문서 sync의 유일한 write owner다.
- `sol_planner`는 새 기능 또는 불명확한 scope에서만 bounded contract를 작성하는 read-only 역할이다.
- `sol_approver`는 evidence 이후 configured 또는 기술적으로 필요한 `LOW/MEDIUM` approval만 read-only로 수행한다. 코드·설정·테스트를 수정하거나 실행하지 않는다.
- `sol_high`는 `HIGH` risk 판단 또는 같은 failure가 두 complete `fix → affected-test rerun` cycle 뒤에도 남은 경우에만 diagnosis/contract를 반환한다.
- 정확한 model·effort·sandbox는 [`docs/AGENT_ROLES.md`](../../docs/AGENT_ROLES.md)와 `.codex/agents/`에 둔다. 자동 fallback과 usage ratio 산정은 금지한다.
- 요청 role 또는 setting을 사용할 수 없으면 `NOT_RUN`으로 기록하고 work를 `ACTIVE`로 유지한다. 같은 worktree에 두 writer를 두지 않는다.
- handoff에는 outcome, in/out of scope, fixed rules, acceptance, affected boundaries, risk, focused verification command와 escalation condition을 포함한다. 새 human-owned decision은 임의로 채우지 않는다.
- final order는 `implementation owner → conditional Sol review → review packet → human acceptance`다. planner·approver·full regression을 모든 작업에 강제하지 않는다.

## Keep commits reviewable

- 하나의 commit은 하나의 사용자 행동·업무 규칙 또는 기술 경계다. non-generated text가 `600` changed lines 또는 `12` non-generated text files를 넘으면 split 또는 human review가 필요한 review stop이다.
- staging 직전 `git diff --cached --check`, `bash scripts/check-commit-scope.sh --staged`, `git diff --cached --stat`, `git diff --cached`를 실행한다. `--allow-large --reason "..."`은 기술적 사유만 기록하며 user agreement를 대신하지 않는다.

## Verify by boundary

변경한 경계에 비례해 Unit, Contract, Integration, E2E, Failure 검사를 선택한다.

1. `LOW`는 affected unit·static check, `MEDIUM`은 affected unit·contract·관련 integration, `HIGH`는 success/failure·authorization·transaction/concurrency·actual adapter check를 기본으로 한다.
2. 먼저 기대 결과 또는 기존 failure를 명시하고 focused check를 실행한다. 각 검사가 보장하는 것과 보장하지 않는 것을 구분한다.
3. `bash scripts/verify.sh --focused`는 프로젝트가 제공하는 `scripts/verify.project.sh`만 실행하고, `--release`는 명시적인 release hook만 실행한다. hook이 없으면 `NOT_RUN`이다.
4. full regression은 release gate, shared boundary, regression finding 또는 human request가 있을 때만 실행하며 같은 성공본을 역할별로 반복하지 않는다.
5. 최초 재현은 retry가 아니다. 같은 failure가 두 complete `fix → affected-test rerun` cycle 뒤에도 남으면 patch를 넓히지 않고 `sol_high`에 evidence·attempted delta·narrowest boundary를 올린다.
6. 실제 명령 직후 결과를 `docs/EVIDENCE.md`에 기록한다. 실행하지 않은 검사는 `PASS`로 쓰지 않는다.

독립 검증이나 읽기 전용 리뷰를 요청받으면 제품 소스를 수정하지 않고 실패 재현과 근거만 보고한다.

## Keep external memory useful

루트 `AGENTS.md`의 Documentation policy에 해당할 때만 문서를 갱신한다.

- `STATE`: 현재 목표·활성 unit·blocker·next action
- `REQUIREMENTS`: stable intent·acceptance·priority·human decision
- `SYSTEM_MAP`: 현재 사용자 흐름·계층·Source of Truth·실패 경로
- `EVIDENCE`: 실제 명령·결과·보장 범위·`NOT_RUN` 사유
- `AGENT_ROLES`: role·model·effort·sandbox·ownership contract
- `DECISIONS`: 사람이 확인한 선택과 대안
- `WORKLOG`: 사용자 승인 뒤 accepted unit의 목적·흐름·검증 요약
- `TROUBLESHOOTING`/`LEARNING`: 재사용 가치가 있는 장애·현재 선택과 연결된 학습
- `NOTION.local.md`: 실제 연결·대상·sync 결과만 기록하는 ignored 파일

Evidence는 명령 직후 사용자·Sol review 전에 기록하고, `WORKLOG`와 optional mirror는 사용자 acceptance 뒤 closure batch에서 갱신한다. 문서를 채우기 위해 사실을 반복하거나 빈 섹션을 늘리지 않는다.

## Finish with ownership

결과 보고에는 사용자-visible result, 활성 requirement, flow와 data source, 변경 contract, 실제 검증과 미확인, 사람의 남은 결정, 다음 한 단계를 포함한다. Required verification·technical review·human acceptance 전에는 work를 `ACTIVE`로 유지한다.
