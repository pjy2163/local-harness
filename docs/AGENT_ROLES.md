# Agent Role and Model Routing

이 문서는 프로젝트의 책임·결정 맥락은 강한 주 에이전트에 보존하고, 승인된 범위의 구현 소음은 가벼운 구현 에이전트로 분리하기 위한 contract다. 공식 모델 이름은 `gpt-5.6-sol`과 `gpt-5.6-luna`다.

## Role map

| Role | Codex configuration | Owns | Must not delegate away |
|---|---|---|---|
| Primary owner | project default `gpt-5.6-sol`, reasoning `high` | 문제 이해, 요구사항·priority 제안, 책임 경계, 기획, 중요한 기술 결정, handoff 승인, 통합 검토, 인간 질문과 최종 결과 | 인간 소유 결정의 식별, 구현 결과의 acceptance 판정, 외부 write·배포 경계 |
| Implementer | custom agent `implementer`, `gpt-5.6-luna`, reasoning `medium` | 승인된 범위의 구체화, 코드·UI·설정 변경, ordinary implementation choice, 관련 테스트와 증거 요약 | 문제·priority·acceptance 재정의, 새 업무 규칙, 중요한 architecture/contract 결정, ADR 승인, 외부 write·배포 |

프로젝트 설정은 [`.codex/config.toml`](../.codex/config.toml), 구현자 설정은 [`.codex/agents/implementer.toml`](../.codex/agents/implementer.toml)에 둔다. trusted project에서 새 Codex session을 시작할 때 적용된다.

## Workflow

```text
Human request
  → Sol/high owner: 문제·범위·책임·결정·acceptance 정리
  → bounded handoff
  → Luna/medium implementer: 구체화·구현·관련 검증
  → evidence handback
  → Sol/high owner: contract·acceptance·위험 통합 검토
  → Human: 필요한 결정과 최종 결과
```

- 의미 있는 구현·UI 구체화·설정 변경은 owner가 경계를 정한 뒤 `implementer`에 맡긴다.
- 한 줄짜리 기계적 수정이나 현재 session에서 custom agent를 사용할 수 없는 경우에도 역할 경계를 생략했다고 숨기지 않는다. 모델 대체가 필요하면 사용자에게 알리고 진행 범위를 확인한다.
- write-heavy 구현자는 기본적으로 한 번에 하나만 사용한다. 서로 독립적인 read-only 조사·검증은 사용자가 병렬화를 요청한 경우 별도 agent로 나눌 수 있다.
- 구현 중 결정이 발견되면 implementer가 선택하지 않고 owner에게 되돌린다. owner도 인간 소유 항목은 임의 확정하지 않는다.

## Bounded handoff template

```text
Requirement ID:
User-visible result:
Implementation task:
Allowed files / system boundary:
Invariants and contracts to preserve:
Acceptance criteria to satisfy:
Required checks / evidence:
Known unknowns:
Explicitly out of scope:
Return format: changes, flow/contract, verification, gaps, decision requests
```

handoff에 핵심 값이 없으면 implementer는 저장소에서 확인 가능한 사실만 보완한다. 문제, 새 업무 규칙, 호환성을 깨는 계약처럼 결과를 바꾸는 값은 추측하지 않는다.

## Routing rules

### Keep with the Sol/high owner

- 사용자 문제와 성공 기준 해석
- NOW/NEXT/LATER와 구현 범위 제안
- 사람·AI·시스템의 책임 배분
- Source of Truth와 실제 데이터 출처 판단
- 새 업무 규칙, 중요한 architecture trade-off와 위험 수용
- 공개 API·저장 데이터 migration, 보안·권한·비용·배포 결정
- implementer 결과의 acceptance, 회귀 위험과 남은 인간 결정 검토

### Delegate to the Luna/medium implementer

- 승인된 flow 안의 코드·UI·configuration 작성
- 명확한 contract에 따른 schema/type 연결
- loading/empty/error/success/partial 상태 구체화
- 범위 안의 작은 refactor와 obsolete internal path 제거
- 관련 unit/contract/integration/E2E/failure 검사 실행
- 변경 파일, 실제 결과와 검증 gap 요약

### Return to owner when

- acceptance criteria끼리 충돌하거나 현재 구현과 모순된다.
- 새 business rule이나 데이터 Source of Truth가 필요하다.
- 공개 contract 파괴, migration, 보안·권한·비용 또는 외부 write가 필요하다.
- 가장 작은 구현이 중요한 architecture 선택에 따라 달라진다.
- 테스트가 실패했고 원인이 승인 범위를 벗어난다.

## Runtime and fallback

- 이 설정은 project-local config를 읽는 trusted Codex app/CLI/IDE의 새 session에 적용된다.
- primary model은 `.codex/config.toml`, implementer model은 custom agent file이 각각 고정한다. prompt의 명시적 runtime override가 있으면 그 값이 우선할 수 있다.
- 현재 client나 account에서 `gpt-5.6-luna` 또는 custom agent를 사용할 수 없으면 Sol이 조용히 구현 역할까지 흡수하지 않는다. 사용할 수 없는 설정과 비용·품질 영향을 보고하고, 사용자가 `gpt-5.6-terra` 등 대체를 선택하게 한다.
- subagent는 parent의 live permission/sandbox 경계를 상속하며, implementer 설정은 Notion MCP를 비활성화해 외부 기록을 쓰지 못하게 한다.

## Verification checklist

- [x] project config가 primary `gpt-5.6-sol` + `high`를 지정한다.
- [x] implementer agent가 `gpt-5.6-luna` + `medium`을 지정한다.
- [x] implementer의 금지 결정과 owner escalation 조건이 명시된다.
- [x] bounded handoff에 requirement, 결과, 경계, contract, acceptance와 검증이 있다.
- [x] 구현 handback을 owner가 contract와 acceptance criteria로 다시 검토한다.
- [x] 새 ephemeral read-only session에서 role discovery와 실제 `gpt-5.6-luna` / `medium` spawn을 확인했다.
