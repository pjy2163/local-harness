# System Map

한 번에 가장 중요한 사용자 흐름 하나를 실제 코드 기준으로 추적한다. 구현이 없는 hop은 만들지 말고 `해당 없음`, 확인하지 못한 hop은 `미확인`으로 적는다.

## Active flow

- Flow name: Sol owner framing → Luna implementation → Sol integration review
- User goal: 책임·결정 맥락은 강한 owner가 유지하고 승인된 구현은 더 빠른 모델로 분리한다.
- Entry point: root `AGENTS.md`, `$project-harness` 요청과 `docs/STATE.md`
- Visible result: 승인된 범위의 구현과 검증 evidence, Sol이 통합 판정한 결과와 인간 결정 요청
- Last checked against repository: `2026-08-05 / 8952d49 + working tree`

```mermaid
sequenceDiagram
    actor U as User
    participant O as Sol/high Owner
    participant I as Luna/medium Implementer
    participant L as Local Markdown (SoT)
    participant N as Notion (optional mirror)
    participant P as Product Landing (optional)

    U->>O: 프로젝트 목표 / 요청
    O->>L: 상태·요구사항·결정·flow 읽기
    O->>L: 문제·책임·범위·acceptance 정리
    alt 의미 있는 구현·구체화
        O->>I: bounded handoff
        I->>L: 승인된 code/UI/config 변경과 검사
        I-->>O: changes·contract·evidence·decision requests
        O->>L: acceptance·상태·결정 통합
    end
    alt Notion sync가 명시적으로 요청되고 대상이 확인됨
        O-->>U: 대상·schema·생성/수정 preview
        O->>N: stable ID로 create/upsert
        N-->>O: schema와 record read-back
        O->>L: local sync log 갱신
    end
    alt landing 구현이 요청됨
        O->>L: 약속·증거·운영 경계 확정
        O->>I: landing implementation handoff
        I->>P: 가장 작은 작동 flow와 UI 구현
        P-->>U: 검증 가능한 page와 CTA 결과
    else template만 요청됨
        O-->>U: 재사용 가능한 local contract
    end
```

프로젝트에 없는 participant는 제거하고 실제 symbol과 실패 흐름으로 바꾼다.

## Hop-by-hop trace

| Hop | File / symbol | Input → Output | Responsibility | Failure path | Verified? |
|---|---|---|---|---|---|
| User action | 사용자 요청 | 목표·reference → 요청 범위 | 문제·외부 write 범위 결정 | 중요한 프로젝트 사실 미확인 | `PASS` |
| Harness routing | `.agents/skills/project-harness/SKILL.md` | 요청 + local state → 다음 행동 | 관련 문서 읽기·최소 변경·검증 | 연결/결정 미확인 시 local-only | `PASS` |
| Owner framing | `.codex/config.toml`, `docs/AGENT_ROLES.md` | 사용자 요청 → bounded handoff | 책임·기획·결정·acceptance 유지 | 인간 소유 결정이면 사용자에게 반환 | config loader `PASS` |
| Implementation | `.codex/agents/implementer.toml` | bounded handoff → code/UI/config + evidence | 승인 범위 구현과 관련 검사 | 새 결정·계약 충돌이면 owner에게 반환 | Luna/medium spawn `PASS` |
| Local Source of Truth | `AGENTS.md`, `docs/*.md` | 확인된 사실 → stable local contract | 요구사항·결정·흐름·증거 보존 | 추측은 미확인으로 유지 | `PASS` |
| Notion mirror | `docs/REQUIREMENTS.md`, `docs/NOTION.local.md` | stable IDs → remote records | 수동 local→Notion preview/write/read-back | 미연결/schema mismatch면 write 중지 | Decisions `NOT_CONFIGURED` |
| Landing transform/render | `docs/DESIGN.md`, `docs/LANDING.md` | project facts → copy/UI/states | 약속·증거·운영 경계를 화면으로 변환 | 실제 project가 없으므로 해당 없음 | `NOT_RUN` |

## Contract and data lineage

| Boundary | Contract / schema | Source of Truth | Transformation | Consumer | Mock/Real |
|---|---|---|---|---|---|
| Request → active work | `R-###`, status vocabulary | `docs/REQUIREMENTS.md` | 현재 상태만 `docs/STATE.md`에 투영 | skill / implementation | `REAL` |
| Local decision → Notion | `ADR-###` / Decisions property contract | `docs/DECISIONS.md` | stable key upsert와 page body mapping | Notion Decisions DB | remote `NOT_CONFIGURED` |
| Project facts → landing | Landing brief / operating boundary / state contract | 실제 requirements·system map·evidence | copy와 UI section으로 선별 | prospective user | per project `UNKNOWN` |
| Owner → implementer → owner | bounded handoff / evidence handback | `docs/AGENT_ROLES.md` | Sol/high framing → Luna/medium execution → Sol review | project result / Human | configuration E2E `PASS` |

### Mock boundary

- Selection mechanism: `docs/LANDING.md`에서 capability를 `REAL | MIXED | MOCK | PLANNED`로 표시한다.
- Production guard: `MOCK`과 `PLANNED`를 실제 제공 claim이나 primary CTA 근거로 사용하지 않는다.
- Shared contract test: 프로젝트 구현 시 `docs/SYSTEM_MAP.md` flow와 landing working flow를 대조한다.
- Remaining mock or fixture: 공통 하네스 자체에는 제품 mock이 없다.

## Responsibility split

- Backend guarantees: 공통 하네스에는 해당 없음. 프로젝트별 실제 endpoint에서 기록한다.
- Frontend decides: 공통 landing은 정보 우선순위와 상태 표현을 정하고, 업무 보장을 새로 만들지 않는다.
- Sol/high owner guarantees: 요구사항·책임·결정 경계, handoff 완결성, 결과의 acceptance와 인간 질문.
- Luna/medium implementer guarantees: 승인 범위의 구체화·구현·관련 검사와 증거 handback; 중요한 결정을 만들지 않음.
- Human decides: 문제, 우선순위, Source of Truth, 업무 규칙, 중요한 계약과 위험 수용.
- AI may propose: 현재 상태, 다음 vertical slice, 검증 방법, ADR 초안과 기록 후보.
- AI must not decide: 인간 소유 결정을 승인 상태로 확정하거나 검증하지 않은 성공을 주장하는 것.

## Test map

| Test | Boundary it proves | What it does not prove | Command / file | Status |
|---|---|---|---|---|
| Unit | shell script syntax | script의 runtime 의미 | `bash -n scripts/check-public.sh scripts/verify.sh` | `PASS` |
| Contract | 네 Notion DB·안정 키와 landing 필수 section | 실제 Notion schema / 렌더링 | 2026-08-05 contract check | `PASS` |
| Integration | 공개 가능한 파일과 docs reference | 외부 Notion 연결 | `./scripts/check-public.sh` + reference check | `PASS` |
| Configuration E2E | custom role discovery와 runtime model/effort | 실제 제품 구현 품질 | ephemeral `codex exec --strict-config --sandbox read-only` | `PASS` |
| E2E | 프로젝트별 사용자 행동부터 landing 결과 | 현재 제품 구현 없음 | 프로젝트에서 추가 | `NOT_RUN` |
| Failure | schema mismatch, missing facts와 partial capability 규칙 | 실제 remote error | 문서 contract review | `HUMAN_CHECK` |

## Ownership check

- [x] 하네스 진입점과 첫 routing 문서가 확인됐다.
- [x] local Markdown Source of Truth와 optional Notion mirror가 구분됐다.
- [x] stable ID와 landing copy로 형태가 바뀌는 위치가 확인됐다.
- [x] landing UI가 업무 보장을 새로 만들지 않는다는 책임이 구분됐다.
- [ ] 실제 프로젝트의 실패 응답 생성·표시 경로는 프로젝트 구현 시 확인한다.
