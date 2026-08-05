# Common Landing Page Template

프로젝트 랜딩을 만들 때 공통 정보 구조와 운영 경계를 유지하기 위한 템플릿이다. 특정 브랜드나 en:ground의 화면을 복제하지 않고, 약속→작동 방식→증거→운영 경계→행동의 신뢰 흐름만 재사용한다. 대괄호 값은 실제 프로젝트 사실로 교체하고, 확인하지 못한 내용은 `미확인` 또는 `계획`으로 표시한다.

## Landing brief

| Field | Project value |
|---|---|
| Primary user | `[누구]` |
| Situation / problem | `[언제 어떤 문제가 생기는가]` |
| Core promise | `[사용자가 얻는 관찰 가능한 결과]` |
| Primary CTA | `[행동] → [결과]` |
| Secondary CTA | `[필요할 때만]` |
| Product state | `CONCEPT | PRIVATE_BETA | PUBLIC_BETA | LIVE` |
| Real evidence available | `[실제 화면, 실행 결과, 사례, 수치 또는 없음]` |
| Project visual override | `docs/DESIGN.md 또는 프로젝트별 문서` |
| Last fact check | `[YYYY-MM-DD / owner]` |

## Page narrative

### 1. Navigation

- Product or project name
- 최대 3–5개의 실제 section link
- Primary CTA 하나
- status, docs 또는 login은 제품에 실제로 있을 때만 노출

### 2. Hero — promise and qualification

- Eyebrow: `[누구를 위한 어떤 범주인가]`
- Headline: `[핵심 결과를 한 문장으로]`
- Supporting copy: `[문제, 작동 방식과 중요한 제한을 2–3문장으로]`
- Primary CTA: `[행동형 label]`
- CTA expectation: `[클릭 후 위치, 필요한 시간/조건과 비용 여부]`
- Trust qualifier: `[beta, 지역, 지원 데이터 등 결과에 영향을 주는 핵심 경계]`

### 3. Working flow — input to visible result

세 단계 안팎으로 실제 사용자 흐름을 설명한다.

| Step | User does | System does | Visible result | Failure / recovery |
|---|---|---|---|---|
| 1 | `[입력/연결/선택]` | `[실제 처리]` | `[첫 피드백]` | `[오류와 복구]` |
| 2 | `[행동]` | `[실제 처리]` | `[중간 결과]` | `[부분 실패]` |
| 3 | `[확인/내보내기]` | `[저장/전달]` | `[최종 결과]` | `[재시도/지원]` |

flow는 `docs/SYSTEM_MAP.md`의 실제 경계와 모순되면 안 된다. 아직 mock인 단계는 `MOCK`, 계획만 있는 단계는 `PLANNED`로 표시한다.

### 4. Product proof

우선순위는 실제 제품 화면·실행 가능한 demo → 검증된 사례 → 재현 가능한 수치 → 설명 순서다.

- Evidence: `[무엇을 어떤 입력과 날짜로 확인했는가]`
- Source: `[docs/EVIDENCE.md 항목, 공개 가능한 사례 또는 없음]`
- Claim boundary: `[이 증거가 보장하지 않는 것]`

고객 로고, 성과 수치, testimonial과 보안·규정 준수 문구는 사용 권한과 근거가 있을 때만 사용한다.

### 5. Operating boundary

운영 경계는 약관 뒤에 숨기지 않고 핵심 기능 설명 가까이에 둔다. 해당 없는 행은 삭제하고 중요한 누락은 `미확인`으로 남긴다.

| Boundary | What we provide | What we do not provide | User / human responsibility | Evidence or owner |
|---|---|---|---|---|
| Supported scope | `[지원 기능·입력·지역·환경]` | `[비지원 범위]` | `[사전 조건]` | `[요구사항/owner]` |
| Automation | `[자동 처리와 보장]` | `[자동 판단하지 않는 것]` | `[검토·승인 지점]` | `[결정/flow]` |
| Data | `[출처, 사용 목적, 신선도]` | `[수집하지 않거나 보장하지 않는 데이터]` | `[연결·정확성 책임]` | `[Source of Truth]` |
| Failure | `[오류, partial, 재시도, 보존 동작]` | `[복구 불가/미지원]` | `[복구 행동]` | `[테스트/runbook]` |
| Privacy / retention | `[저장 위치·기간·삭제 경로]` | `[금지 데이터/미지원 요청]` | `[동의·권한 관리]` | `[policy/owner]` |
| Availability / change | `[운영 시간, beta/SLA, 변경 공지]` | `[보장하지 않는 가용성]` | `[백업 절차]` | `[status/support]` |
| Support | `[채널과 응답 범위]` | `[지원 제외]` | `[필요한 재현 정보]` | `[contact/owner]` |

운영 경계 요약 문장 템플릿:

> `[제품]`은 `[지원 결과]`를 제공한다. `[중요한 판단/승인/원본 정확성]`은 사람이 책임지며, `[주요 비지원 범위]`는 현재 지원하지 않는다. 문제가 생기면 `[보존·재시도·지원 동작]`으로 처리한다.

### 6. Capability and limits

기능 목록은 많은 카드보다 사용자 결과 단위로 묶는다.

| Outcome | Available now | Limit / prerequisite | State |
|---|---|---|---|
| `[사용자 결과]` | `[기능]` | `[제약]` | `REAL | MIXED | MOCK | PLANNED` |

`PLANNED`는 기본 CTA의 근거로 사용하지 않는다.

### 7. FAQ

다음 질문 중 실제 사용자 선택에 영향을 주는 것만 답한다.

- 누구에게 맞고 누구에게 맞지 않는가?
- 어떤 데이터가 필요하고 어디에 저장되는가?
- 자동화 결과를 사람이 검토해야 하는가?
- 실패하거나 일부 데이터가 없으면 어떻게 되는가?
- 가격, beta, 지원 지역과 해지/삭제 조건은 무엇인가?
- 도움을 요청하거나 변경 사항을 확인할 곳은 어디인가?

### 8. Final CTA and footer

- Hero와 같은 primary action을 반복하고 클릭 후 결과를 다시 설명한다.
- 개인정보, 약관, status, support와 contact link는 실제 문서/채널이 있을 때 연결한다.
- project state와 맞지 않는 signup, download, login link를 placeholder로 배포하지 않는다.

## Interaction states

CTA, form 또는 demo가 있으면 최소 상태를 정의한다.

| State | Required behavior |
|---|---|
| Loading | 중복 제출을 막고 진행 중임을 알린다 |
| Empty | 필요한 입력과 example을 제시한다 |
| Error | 원인, 보존된 입력과 복구 행동을 보여준다 |
| Success | 완료 결과와 다음 단계를 보여준다 |
| Partial | 사용 가능한 결과와 실패한 부분을 구분한다 |
| Disabled | 비활성 이유와 활성화 조건을 설명한다 |

## Project copy worksheet

```text
Audience:
Problem in their words:
Promise:
Primary CTA and post-click result:
Three-step working flow:
Proof and its limit:
Supported / unsupported:
Automation / human review:
Data source / freshness / retention:
Failure / partial / recovery:
Availability / beta / support:
Top three FAQs:
Intentional deviation from this template:
```

## Release checklist

- [ ] 첫 화면의 audience, outcome과 primary CTA가 하나씩 분명하다.
- [ ] CTA 뒤의 실제 결과와 비용·로그인·beta 같은 조건이 설명된다.
- [ ] 작동 흐름이 `docs/SYSTEM_MAP.md`의 실제 구현과 일치한다.
- [ ] mock, planned와 real capability가 구분된다.
- [ ] 증거와 claim의 한계가 `docs/EVIDENCE.md` 또는 공개 가능한 출처와 연결된다.
- [ ] 지원/비지원, 자동화/사람 책임, 데이터, 실패와 privacy 경계가 사실에 맞다.
- [ ] loading, error, success, partial과 disabled 중 관련 상태를 실제로 확인했다.
- [ ] 320px mobile, desktop, keyboard focus, contrast와 reduced motion을 확인했다.
- [ ] 링크, contact, 정책, status와 CTA에 placeholder가 남지 않았다.
- [ ] 외부 asset, 로고, quote와 font의 사용 권한을 확인했다.
