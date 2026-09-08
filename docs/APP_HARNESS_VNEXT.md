# App Harness vNext — Lean Eval-First Plan

> Status: **proposal / not yet active runtime contract**  
> Base: `app` branch v1.4  
> Goal: 앱 개발에서 에이전트가 **작게 구현 → 스스로 증거 기반 평가 → 필요한 경우에만 재작업/상위 모델 검토**를 반복하도록 하되, 하네스 자체가 개발 속도와 토큰을 잡아먹지 않게 한다.

---

## 1. Why change the app harness

현재 v1.4의 강점은 안전한 one-writer, focused verification, human-owned decisions, `PASS | FAIL | NOT_RUN` 구분이다.

앱 프로젝트에서는 여기에 다음이 더 필요하다.

1. **자기평가 중심** — 매 LOW/MEDIUM 작업마다 별도 reviewer를 호출하지 않고 writer가 acceptance와 실제 evidence를 스스로 대조한다.
2. **모바일 vertical slice 우선** — 화면/상태/성능을 작은 실제 사용자 흐름으로 검증한다.
3. **컨텍스트 절약** — 문서를 전부 읽거나 매번 다시 요약하지 않는다.
4. **모델 비용/속도 최적화** — 고성능 모델은 결정·난제에만 사용하고 반복 탐색/분류는 더 가벼운 경로를 선택한다.
5. **짧은 eval loop** — full regression보다 changed-boundary eval을 먼저 돌린다.

하네스의 성공 기준은 문서 수가 아니라 **기능 1개를 올바르게 만드는 데 드는 왕복 횟수, 불필요한 모델 호출, 불필요한 context read가 줄어드는지**다.

---

## 2. vNext operating loop

```text
User request
  ↓
Relevant context only
  ↓
5-line task contract
  ↓
Smallest vertical slice
  ↓
Focused deterministic / visual eval
  ↓
Writer self-grade
  ├─ PASS → report and stop
  ├─ FAIL → one narrow fix → rerun
  └─ BLOCKED / decision missing → human or conditional Sol
```

### Default completion packet

LOW/MEDIUM writer의 최종 내부 체크는 아래 6개면 충분하다.

```text
Goal:
Changed:
Acceptance:
Evidence:
Self-grade: PASS | FAIL | NOT_RUN
Not proven / next risk:
```

별도 장문의 review packet은 MEDIUM/HIGH 또는 사람이 요청한 경우에만 만든다.

---

## 3. Self-evaluation first

### Principle

`자기평가`는 모델이 "잘했다"고 점수를 주는 것이 아니다.

반드시 다음 순서다.

1. acceptance criteria를 먼저 고정
2. 실제 명령/상태/screenshot 결과 수집
3. criteria와 evidence를 항목별 비교
4. 증거가 없으면 `PASS` 금지
5. 실패하면 가장 좁은 변경 한 번
6. 같은 실패가 반복될 때만 escalation

### Grade schema

```json
{
  "eval_id": "APP-...",
  "grade": "PASS|FAIL|NOT_RUN",
  "evidence": ["actual command/result or artifact"],
  "failed_criteria": [],
  "not_proven": []
}
```

자연어 자기칭찬, 추정 점수, "아마 동작"은 evidence가 아니다.

### Reviewer reduction

- LOW: writer self-eval로 종료
- MEDIUM: writer self-eval + 위험 조건이 있을 때만 read-only review
- HIGH: human decision / `sol_high` contract 후 writer 구현
- 배포 전: 명시적 release gate만 별도 review/regression

즉 **모델끼리 서로 검토하는 단계를 기본 파이프라인으로 만들지 않는다.**

---

## 4. App-specific eval layers

앱 하네스는 공통 eval에 아래 계층을 추가하는 방향을 권장한다.

### Layer A — deterministic

- unit / integration
- state transition
- API contract
- idempotency
- offline/failure path

### Layer B — UI / visual

- deterministic fixture
- screenshot
- fixed rubric
- loading / empty / error / success
- 주요 화면에서 CTA와 콘텐츠 우선순위

### Layer C — mobile runtime

- launch smoke
- target device/emulator
- crash-free path
- frame-time/FPS budget
- memory budget
- package size budget
- 권한 거부/네트워크 실패

### Layer D — manual only when necessary

- 햅틱
- 사운드 균형
- 애니메이션 감각
- 발열/배터리 장기 체감

자동화가 약한 것을 억지 점수화하지 않는다.

---

## 5. Token / context economy

### 5.1 Progressive context loading

기본적으로 한 요청에서 아래 순서로 읽는다.

```text
1. user request
2. affected source files
3. related test/eval
4. 필요한 canonical doc의 해당 section만
5. 막힌 경우에만 더 확장
```

금지 기본값:

- 시작마다 `docs/**` 전체 읽기
- 전체 README + STATE + REQUIREMENTS + SYSTEM_MAP + DESIGN 동시 로드
- 이미 확인한 사실을 여러 문서에서 재수집
- 전체 파일을 읽을 필요가 없는데 line-range 없이 반복 fetch

### 5.2 Context pack target

일반 LOW/MEDIUM 작업의 첫 context pack 권장값:

- 관련 파일 **3~5개**
- 핵심 코드/문서 **약 200~300 lines 이내**에서 시작
- 검색 결과는 가장 관련 높은 snippet 우선
- 막힐 때만 확장

이는 hard limit가 아니라 **초기 읽기 예산**이다.

### 5.3 Short canonical state

`STATE.md`는 장기 기록 저장소가 아니다.

권장:

- 현재 active slice
- 현재 blocker
- 최근 실제 evidence pointer
- 다음 human decision

완료된 세부 내역은 WORKLOG/EVIDENCE에 남기고 STATE에서 제거한다.

### 5.4 Diff-first verification

- 전체 프로젝트 재요약보다 `git diff`와 affected files 우선
- unchanged contract는 다시 설명하지 않음
- final answer도 변경/검증/미검증 위주

### 5.5 Token accounting

runtime이 정확한 token count를 제공하지 않으면 숫자를 추정하지 않는다.

대신 다음 proxy를 기록할 수 있다.

- context files opened
- expanded line ranges
- agent calls
- reviewer calls
- eval reruns
- full-suite runs

목표는 `토큰 수치 맞추기`가 아니라 **불필요한 읽기와 호출을 줄이는 것**이다.

---

## 6. Model routing — lean by default

현재 v1.4의 `luna_max` writer / conditional Sol 원칙은 안전한 기본값으로 유지한다.

vNext에서는 **작업 난이도와 반복성에 따라 더 가벼운 모델을 사용할 수 있는 routing slot**을 추가하는 방향을 검토한다.

### Suggested roles

| Work type | Preferred route | Notes |
|---|---|---|
| 단순 repo 탐색, 파일 분류, 로그 요약 | lightweight read-only role | 실제 write owner 아님 |
| 닫힌 LOW/MEDIUM 구현 + focused test | Luna writer | 현재 v1.4 기본 유지 |
| 새 기능 scope / 큰 architecture 선택 | Sol planner | 조건부 |
| HIGH risk / 반복 실패 | Sol high | 조건부 |
| release technical review | Sol approver | 명시적 gate에서만 |

### Astra slot

Astra는 **현재 Codex runtime에서 실제 사용 가능 여부, 정확한 model id, 속도/비용/품질 프로파일을 확인한 뒤** optional slot으로 넣는다. 확인 전에는 config에 존재하지 않는 모델명을 hard-code하지 않는다.

사용 가능하고 benchmark가 통과한다면 우선 후보는 다음처럼 **read-heavy / low-risk** 작업이다.

- repo/file 탐색 후보 생성
- test log 요약
- screenshot rubric 1차 분류
- repetitive fixture generation
- 문서 중복/드리프트 탐지
- 이미 고정된 contract를 짧게 구조화

초기에는 아래 작업의 최종 owner로 사용하지 않는다.

- 보안/권한/결제 결정
- architecture 결정
- migration
- 최종 release approval
- 사람이 정의하지 않은 business rule 생성

### Benchmark gate for Astra

Astra를 실제 routing에 추가하기 전에 최소 eval 세트를 같은 fixture로 비교한다.

```text
A. relevant-file retrieval precision
B. existing-test selection
C. no-scope-expansion
D. correct PASS/FAIL/NOT_RUN grading
E. compact final report
```

Astra가 위 기준을 만족할 때만 fast/read-only route에 활성화한다. 실패하면 Luna/Sol contract를 유지하며 **silent fallback은 하지 않는다.**

---

## 7. Fast development rules

### Do

- 한 번에 한 vertical slice
- compile/run 가능한 상태를 항상 유지
- mock과 real 경계를 명시
- 첫 pass는 가장 단순한 구현
- changed-boundary test 먼저
- visual task는 screenshot fixture 하나부터
- 성능 문제는 profile evidence 후 수정

### Avoid

- 기능 구현 전에 거대한 architecture layer 만들기
- 아직 필요 없는 repository/service/factory 추가
- 모든 기능에 planner → writer → approver 체인 강제
- 모든 변경 후 full regression
- 같은 정보를 REQUIREMENTS/STATE/WORKLOG에 중복 기록
- "미래 확장"만을 위한 wrapper
- 테스트를 많이 만드는 것을 목표로 삼기

---

## 8. Retry / escalation budget

기본 loop:

```text
implement
 → focused eval
 → FAIL
 → narrow fix #1
 → rerun
```

여기서 해결되면 종료한다.

동일 failure가 다시 남는 경우:

```text
narrow fix #2
 → rerun
 → still FAIL
 → stop broadening
 → Sol/high or human decision
```

반복 agent 호출로 토큰을 태우지 않는다.

---

## 9. Evals the harness itself should add

### APP-HARNESS-LOW-01 — self-eval completion

작은 UI copy 변경에서 writer가:

- 관련 파일만 변경
- affected check 실행
- evidence 기반 self-grade
- reviewer 없이 종료

하면 PASS.

### APP-HARNESS-CONTEXT-01 — progressive read

작은 버그 fixture에서:

- 시작부터 전체 docs tree를 읽지 않음
- affected source/test에서 시작
- 필요한 경우에만 canonical section으로 확장

하면 PASS.

### APP-HARNESS-VISUAL-01 — screenshot rubric

fixture UI 변경에서:

- deterministic state 사용
- screenshot artifact 생성
- rubric 항목별 PASS/FAIL
- "예뻐 보인다" 단독 판단 금지

### APP-HARNESS-FAIL-01 — one narrow repair

첫 eval failure 후:

- failure boundary를 고정
- unrelated refactor 없이 최소 수정
- 같은 eval 재실행

### APP-HARNESS-ESCALATE-01 — stop after repeated failure

동일 failure가 두 complete fix/rerun cycle 뒤에도 남으면 patch를 넓히지 않고 evidence와 함께 escalation.

### APP-HARNESS-MODEL-01 — lightweight model gate

Astra 같은 lightweight/fast candidate를 사용할 경우 동일 fixture에서 no-scope-expansion, retrieval, grading을 통과해야 routing에 포함.

---

## 10. Proposed documentation simplification

vNext app 프로젝트에 권장하는 최소 canonical set:

```text
AGENTS.md             행동/권한/검증 원칙
PRODUCT.md            제품 방향
REQUIREMENTS.md       stable acceptance
DESIGN.md             UI/visual contract가 있을 때
STATE.md              현재 slice만
EVALS.md              executable/rubric eval
EVIDENCE.md           실제 결과 pointer
DECISIONS.md          human-owned decisions
```

`SYSTEM_MAP`, `WORKLOG`, `TROUBLESHOOTING`, `PORTFOLIO`는 프로젝트 규모/필요가 생길 때 유지한다. **빈 파일을 채우기 위해 작업하지 않는다.**

---

## 11. Adoption plan

### Phase 1 — docs/eval only

- 이 문서 기준을 실제 app 프로젝트 한 곳에서 시범 적용
- runtime/config model routing은 변경하지 않음
- context-read 수, agent call 수, eval rerun 수 관찰

### Phase 2 — behavior eval

- `APP-HARNESS-LOW-01`
- `APP-HARNESS-CONTEXT-01`
- `APP-HARNESS-FAIL-01`

격리 fixture에서 실행.

### Phase 3 — optional Astra benchmark

runtime availability 확인 후 동일 fixture 비교.

### Phase 4 — config promotion

실제 evidence가 있을 때만 `AGENT_ROLES.md`, `.codex/agents/*`, scripts를 vNext contract로 변경.

---

## 12. Success criteria

vNext가 성공했다는 주장은 아래 실제 프로젝트 evidence가 있을 때만 한다.

- 작은 기능에서 별도 reviewer 호출 비율 감소
- 초기 context read 범위 감소
- focused eval로 대부분의 LOW/MEDIUM 작업이 종료
- 반복 실패 시 무한 수정 loop 방지
- visual app 변경이 screenshot/rubric으로 재현 가능
- full regression은 release/shared-boundary 때만 실행
- 모델 routing이 품질을 떨어뜨리지 않음

구체적인 token 절감률, 속도 개선률은 실제 runtime 측정값 없이 추정하지 않는다.
