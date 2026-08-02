# Personal Project Harness

AI가 코드를 만드는 데서 끝내지 않고, 사람이 사용자 흐름·데이터 출처·계약·실패 경로를 설명하고 소유하도록 돕는 경량 공통 템플릿이다.

## What it keeps connected

- 공통 Git·보안 원칙
- 요구사항, 우선순위와 사람의 구현 결정
- 사용자 행동부터 화면까지의 시스템 흐름
- 데이터 출처, API contract와 mock/real 경계
- 테스트가 보장하는 경계와 실제 실행 증거
- 작업일지, 트러블슈팅과 포트폴리오 기록
- white/cool-neutral 공통 디자인과 프로젝트별 override
- 선택적인 Notion 수동 mirror

## Structure

```text
AGENTS.md                    공통 작업·Git·보안·사람 소유 원칙
.agents/skills/project-harness/
                             요청에 맞춰 다음 행동을 고르는 통합 스킬
.codex/config.toml           공개 가능한 프로젝트 전용 Notion MCP 설정
docs/STATE.md                AI가 유지하는 현재 상태
docs/REQUIREMENTS.md         요구사항 원장과 Notion property contract
docs/NOTION.local.example.md 개인 Notion 대상 설정 예시
docs/DESIGN.md               공통 visual baseline
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
3. UI 작업이면 `docs/DESIGN.md`의 공통 기준에서 프로젝트별 선택만 override한다.
4. 자동 탐지할 수 없는 검증 명령은 `scripts/verify.project.sh`에 둔다.
5. 다음처럼 첫 요청을 시작한다.

```text
$project-harness 현재 저장소와 내 요청을 기준으로 상태를 잡고,
가장 작은 가치 있는 End-to-End 단위를 진행해줘.
중요한 구현 범위와 업무 결정은 내가 선택할 수 있게 남겨줘.
```

AI는 승인된 요구사항 범위 안에서 구현·검증·기록을 이어가지만, 완료 후 다음 요구사항을 자동으로 구현하지 않는다. 특정 회사, 과제 시간표, 고정 작업 카드나 의무 agent 구성을 전제하지 않는다.

## Optional Notion mirror

로컬 Markdown이 Source of Truth이고 Notion은 사람이 확인하는 수동 단방향 mirror다. 요구사항, 작업일지와 트러블슈팅은 각각 `Requirement ID`, `Local Entry ID`, `Incident ID`를 안정 키로 사용한다.

1. `docs/NOTION.local.example.md`를 `docs/NOTION.local.md`로 복사한다.
2. 승인한 parent page와 세 database의 실제 ID·property를 로컬 파일에 기록한다.
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

## Definition of done

- 사용자 행동부터 결과 화면까지 흐름을 설명할 수 있다.
- 실제 데이터 출처와 형태가 바뀌는 위치를 안다.
- Backend와 Frontend가 각각 보장하는 것이 구분된다.
- 실패 응답이 만들어지고 표시되는 경로가 확인된다.
- 관련 테스트가 무엇을 보장하고 보장하지 않는지 기록된다.
- 실행한 검증과 남은 미확인 사항이 구분된다.

구체적인 프롬프트 예시는 `PROMPTS.md`에 있다.
