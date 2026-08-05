# Personal Project Harness

AI가 코드를 만드는 데서 끝내지 않고, 사람이 사용자 흐름·데이터 출처·계약·실패 경로를 설명하고 소유하도록 돕는 경량 공통 템플릿이다.

Current template version: **v1.1.0**

## What it keeps connected

- 공통 Git·보안 원칙
- 요구사항, 우선순위와 사람의 구현 결정
- 사용자 행동부터 화면까지의 시스템 흐름
- 데이터 출처, API contract와 mock/real 경계
- 테스트가 보장하는 경계와 실제 실행 증거
- 작업일지, 트러블슈팅과 포트폴리오 기록
- white/cool-neutral 공통 디자인과 프로젝트별 override
- 가치 제안·증거·운영 경계를 연결하는 공통 landing template
- Sol/high owner와 Luna/medium implementer 사이의 책임·handoff contract
- 선택적인 Notion 수동 mirror

## Structure

```text
AGENTS.md                    공통 작업·Git·보안·사람 소유 원칙
.agents/skills/project-harness/
                             요청에 맞춰 다음 행동을 고르는 통합 스킬
.codex/config.toml           Sol/high primary와 프로젝트 전용 Notion MCP 설정
.codex/agents/implementer.toml
                             Luna/medium 구현 전용 custom agent
docs/STATE.md                AI가 유지하는 현재 상태
docs/AGENT_ROLES.md          모델별 책임, handoff와 escalation contract
docs/REQUIREMENTS.md         요구사항 원장과 Notion property contract
docs/NOTION.local.example.md 개인 Notion 대상 설정 예시
docs/DESIGN.md               공통 visual baseline
docs/LANDING.md              공통 landing 정보 구조와 운영 경계
docs/SYSTEM_MAP.md           활성 흐름, 데이터 계약과 테스트 지도
docs/EVIDENCE.md             실제 명령과 결과
docs/DECISIONS.md            사람이 확정한 ADR-lite
docs/WORKLOG.md              작업일지
docs/TROUBLESHOOTING.md      재사용할 문제 해결 기록
docs/PORTFOLIO.md            포트폴리오 후보
scripts/verify.sh            프로젝트 검증 진입점
scripts/check-public.sh      커밋 후보의 기본 공개 안전 검사
```

## Start a project

1. 기존 프로젝트의 규칙과 문서를 확인하고 파일을 덮어쓰기보다 병합한다.
2. `docs/STATE.md`와 `docs/REQUIREMENTS.md`를 실제 프로젝트 사실로 초기화한다.
3. trusted project에서 새 Codex session을 열어 `.codex/config.toml`과 `implementer` custom agent를 로드한다.
4. UI 작업이면 `docs/DESIGN.md`의 공통 기준에서 프로젝트별 선택만 override한다.
5. landing 작업이면 `docs/LANDING.md`의 약속·작동 흐름·증거·운영 경계를 실제 사실로 초기화한다.
6. 자동 탐지할 수 없는 검증 명령은 `scripts/verify.project.sh`에 둔다.
7. 다음처럼 첫 요청을 시작한다.

```text
$project-harness 현재 저장소와 내 요청을 기준으로 상태를 잡고,
가장 작은 가치 있는 End-to-End 단위를 진행해줘.
중요한 구현 범위와 업무 결정은 내가 선택할 수 있게 남겨줘.
```

Sol/high primary가 문제·범위·책임·기획과 결정을 유지하고, 승인된 구현·구체화만 Luna/medium `implementer`에 bounded handoff한다. 완료 후 다음 요구사항을 자동으로 구현하지 않으며 고정된 병렬 agent 수나 작업 카드를 전제하지 않는다.

## Optional Notion mirror

로컬 Markdown이 Source of Truth이고 Notion은 사람이 확인하는 수동 단방향 mirror다. 요구사항, 기술 결정, 작업일지와 트러블슈팅은 각각 `Requirement ID`, `Decision ID`, `Local Entry ID`, `Incident ID`를 안정 키로 사용한다.

1. `docs/NOTION.local.example.md`를 `docs/NOTION.local.md`로 복사한다.
2. 승인한 parent page와 Requirements, Decisions, Work Log, Troubleshooting 네 database의 실제 ID·property를 로컬 파일에 기록한다.
3. 프로젝트를 trusted 상태로 연 뒤 `.codex/config.toml`의 Notion MCP에 OAuth로 로그인한다.
4. 첫 sync는 preview → schema 확인 → write → read-back → 같은 키 재실행 순서로 검증한다.

`docs/NOTION.local.md`와 OAuth token은 Git에 포함되지 않는다. `.codex/config.toml`에는 공개 endpoint와 승인 정책만 둔다.

## Verification

```bash
./scripts/check-public.sh
./scripts/verify.sh
```

`check-public.sh`는 커밋 후보 파일에서 흔한 secret 형식, 개인 홈 경로와 개인 Notion page 링크를 찾는 가벼운 검사다. 전문 secret scanner를 완전히 대체하지는 않는다.

`verify.sh`는 프로젝트 manifest와 기존 script를 찾아 관련 검사를 실행한다. 지원할 검증을 찾지 못하면 성공으로 가장하지 않고 exit code `2`를 반환한다.

## Release history

### v1.1.0 — 2026-08-05

초기 하네스의 local Source of Truth와 사람 소유 경계를 유지하면서, 프로젝트 운영과 구현 위임에 필요한 공통 contract를 확장했다.

- Engineering defaults: 가장 작은 working E2E, 추측성 추상화 억제, 기존 dependency 우선, 승인된 내부 obsolete path 제거와 공개 계약 migration의 사람 결정 경계를 추가했다.
- Notion project hub: Requirements, Decisions, Work Log, Troubleshooting 네 database blueprint와 `Decision ID` 기반 기술 결정 mirror를 추가했다.
- Landing template: 가치 제안, 실제 flow, 증거, 지원/비지원, 자동화/사람 책임, 데이터·보관, 실패·부분 실패와 support를 연결하는 `docs/LANDING.md`를 추가했다.
- Agent routing: 책임·기획·중요한 결정과 최종 acceptance는 Sol/high primary가 소유하고, 승인된 구현·구체화는 Luna/medium `implementer`가 수행하도록 분리했다.
- Verification: Codex config loader, local model catalog와 ephemeral strict-config spawn으로 `implementer`의 실제 `gpt-5.6-luna` / `medium` 실행을 확인했다.
- Public boundary: 실제 Notion page/database ID, OAuth token과 개인 연결 상태는 계속 `docs/NOTION.local.md`에만 두고 Git에서 제외한다.

Upgrade notes:

- model routing은 trusted project에서 새 Codex session을 시작할 때 적용된다.
- 기존 세 Notion database를 자동으로 수정하거나 재생성하지 않는다. Decisions database는 외부 write가 요청된 경우에만 preview → create → read-back한다.
- 기존 프로젝트에 적용할 때 파일을 덮어쓰기보다 현재 `AGENTS.md`, config와 project docs에 필요한 contract만 병합한다.

### v1.0.0 — 2026-08-02

- 적응형 project loop, 요구사항·상태·결정·시스템 맵·검증 증거와 작업 기록의 초기 구조를 만들었다.
- white/cool-neutral design baseline, 수동 local→Notion mirror와 공개 안전 검사를 제공했다.
- 프로젝트별 실제 사실과 실행 명령으로 초기화하는 재사용 하네스의 기준선을 마련했다.

## Definition of done

- 사용자 행동부터 결과 화면까지 흐름을 설명할 수 있다.
- 실제 데이터 출처와 형태가 바뀌는 위치를 안다.
- Backend와 Frontend가 각각 보장하는 것이 구분된다.
- 실패 응답이 만들어지고 표시되는 경로가 확인된다.
- 관련 테스트가 무엇을 보장하고 보장하지 않는지 기록된다.
- 실행한 검증과 남은 미확인 사항이 구분된다.

구체적인 프롬프트 예시는 `PROMPTS.md`에 있다.
