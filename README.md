# Personal Project Harness

AI가 코드를 만드는 데서 끝내지 않고, 사람이 사용자 흐름·데이터 출처·계약·실패 경로를 설명하고 소유하도록 돕는 경량 공통 템플릿이다.

Current template version: **v1.4.0** — lightweight eval engineering

2026-09-03 로컬 `main`·`app`·`web` 반영 완료. 원격 push는 하지 않았으며 GitHub 배포 완료를 뜻하지 않는다.

## What it keeps connected

- 공통 Git·보안 원칙
- 요구사항, 우선순위와 사람의 구현 결정
- 사용자 행동부터 화면까지의 시스템 흐름
- 데이터 출처, API contract와 mock/real 경계
- 테스트가 보장하는 경계와 실제 실행 증거
- 작업일지, 트러블슈팅과 포트폴리오 기록
- common workflow와 선택적인 web overlay의 경계
- 명시적인 focused/release verification과 실제 evidence
- Luna implementation owner와 조건부 Sol review contract
- 선택적인 Notion 수동 mirror

## Structure

```text
AGENTS.md                    공통 작업·Git·보안·사람 소유 원칙
.agents/skills/project-harness/
                             하네스 자체 유지보수 전용 스킬
.codex/config.toml           프로젝트 default와 선택적인 Notion MCP 설정
.codex/agents/*.toml         named role의 ownership·model·sandbox 설정
docs/STATE.md                AI가 유지하는 현재 상태
docs/AGENT_ROLES.md          role별 책임, handoff와 escalation contract
docs/REQUIREMENTS.md         안정적인 요구사항과 acceptance 원장
docs/NOTION.local.example.md 개인 Notion 대상 설정 예시
docs/DESIGN.md               common stub / web branch full visual baseline
docs/LANDING.md              common stub / web branch full landing contract
docs/SYSTEM_MAP.md           활성 흐름, 데이터 계약과 테스트 지도
docs/EVIDENCE.md             필요한 지속 작업의 실제 명령과 결과
docs/EVALS.md                격리된 프로젝트에서 실행하는 작은 행동 eval
docs/DECISIONS.md            사람이 확정한 ADR-lite
docs/WORKLOG.md              작업일지
docs/TROUBLESHOOTING.md      재사용할 문제 해결 기록
docs/PORTFOLIO.md            포트폴리오 후보
scripts/verify.sh            명시적인 focused/release 검증 진입점
scripts/verify.*.example.sh  새 프로젝트용 hook 시작점
scripts/check-role-contract.sh role 문서와 named config drift 검사
scripts/check-public.sh      커밋 후보의 기본 공개 안전 검사
scripts/check-commit-scope.sh staged diff의 review-stop 검사
```

## Choose common or web

| Branch | 로컬 적용 상태와 용도 |
|---|---|
| `main` | v1.4 공통 기준. 새 CLI/API/데이터 프로젝트의 기본 시작점 |
| `app` | `main`과 같은 v1.4 공통 내용. 별도 app 전용 규칙 없음 |
| `web` | v1.4 공통 기준 + 기존 `docs/DESIGN.md`·`docs/LANDING.md` overlay |
| `codex/harness-common-v1-2` | 이전 v1.3 기준을 보존한 이력 브랜치. 새 프로젝트 시작점으로 사용하지 않음 |

화면·랜딩을 만드는 프로젝트만 `web`을 선택한다. 공통 branch에는 특정 색상이나 제품 visual baseline을 강제하지 않는다.
현재 v1.4는 이 로컬 저장소에서 선택할 수 있다. GitHub에서 새로 가져올 경우 별도 push 후 해당 branch에 v1.4가 있는지 확인한다.

## Start in five minutes

1. 현재 프로젝트의 `AGENTS.md`와 필요한 규칙만 병합한다. 빈 문서 전체를 초기화하지 않는다.
2. 목표·비목표·검수 기준·보존 범위를 정한다. 지속되는 요구사항·흐름만 해당 canonical 문서에 기록한다.
3. 프로젝트 hook이 필요하면 `scripts/verify.project.example.sh`를 `scripts/verify.project.sh`로 복사해 변경 경계에 맞는 명령으로 채운다. 명시적인 release gate가 있을 때만 release example과 `--release`를 사용한다.
4. 필요하면 `docs/NOTION.local.example.md`를 복사해 실제 연결을 별도 local file로 설정한다.
5. 아래 요청으로 첫 vertical slice를 시작한다.

```text
현재 요청의 목표·비목표·검수 기준·보존 범위를 정리하고,
가장 작은 변경과 관련 기존 테스트로 완료해줘.
새 업무 규칙·보안·외부 변경 결정은 나에게 남겨줘.
```

## Daily flow

일반 작업은 `요청·관련 코드 → 작은 contract → 단일 writer → affected verification → 결과`로 진행한다. LOW에는 Sol 승인과 문서 closure를 강제하지 않는다. MEDIUM/HIGH의 필요한 technical review·human acceptance와 실제 배포 gate는 유지한다. 다음 기능을 자동으로 시작하지 않는다.

`$project-harness`는 하네스 자체를 고칠 때만 호출한다. 하네스 동작을 바꾼 경우 [경량 eval](docs/EVALS.md)로 실제 diff와 권한 경계를 확인한다. eval은 제품 테스트·독립 HIGH review·배포 승인이나 실행 권한을 대체하지 않는다.

자세한 role·model·effort·sandbox 조건은 [`docs/AGENT_ROLES.md`](docs/AGENT_ROLES.md)에서 확인한다. closed contract의 구현·테스트·focused verification은 `luna_max`가 소유하고, planner·approver·HIGH diagnosis는 조건부다.

사람이 특정 model/effort를 한 번의 유지보수 작업에 직접 지정할 수는 있지만, 이는 `docs/EVIDENCE.md`에 남기는 실행 provenance이며 재사용 템플릿의 기본 role ownership을 바꾸지 않는다. Luna 기본 추론은 항상 `max`이고 지원 surface의 `fast` 설정은 유지한다.

## Optional Notion mirror

로컬 Markdown이 Source of Truth이고 Notion은 사람이 확인하는 수동 단방향 mirror다. `docs/NOTION.local.example.md`에 connection, stable key, property 예시와 sync 절차를 둔다.

실제 연결이 필요할 때만 그 파일을 `docs/NOTION.local.md`로 복사하고 실제 대상·schema를 사람이 확인해 기록한다. 첫 sync는 preview → conflict/schema 확인 → write → read-back → 같은 key 재실행 순서다. ID·OAuth token·개인 연결 상태는 커밋하지 않는다.

Multi-role routing도 선택적이다. 자세한 조건은 `docs/AGENT_ROLES.md`와 `.codex/agents/` 설정을 따르며, 모든 작업에 planner·approver·full regression을 강제하지 않는다.

## Verification

```bash
./scripts/check-public.sh
bash scripts/check-role-contract.sh
bash scripts/check-commit-scope.sh --range HEAD
bash scripts/verify.sh --focused
# release gate가 명시된 경우에만
bash scripts/verify.sh --release
```

`verify.sh`는 manifest를 추측하거나 broad suite를 자동 실행하지 않는다. `--focused`는 `scripts/verify.project.sh`, `--release`는 `scripts/verify.release.sh`만 실행하며 hook이 없으면 `NOT_RUN`과 exit `2`를 반환한다. 실제 명령·결과와 실행하지 않은 검사는 LOW에서는 최종 보고에, 지속 작업에서는 `docs/EVIDENCE.md`에 구분해 기록한다.

`check-public.sh`는 흔한 secret 형식, 개인 홈 경로와 개인 Notion link를 찾는 가벼운 검사이며 전문 secret scanner를 완전히 대체하지 않는다.

## Release history

### v1.4.0 — 2026-09-03 (local applied; not pushed)

- 일반 작업에서 통합 스킬과 전체 문서 선행 읽기를 제거하고 하네스 유지보수로 trigger를 좁힌다.
- LOW는 필수 Sol approval·문서 closure 없이 끝내고, MEDIUM/HIGH·사람 결정·배포 gate를 유지한다.
- Luna `max/fast`와 기존 역할 매핑은 유지한다. 한 작업의 Sol medium 요청은 기본값 변경이 아니다.
- 경량 행동 eval 두 사례로 변경 범위·종료·권한 경계를 확인하고 정적 검사와 실제 행동 증거를 구분한다.
- 사용자 승인 후 공통 변경을 `main`·`app`에 fast-forward하고 `web`에 병합했다. web 전용 디자인 두 파일과 이전 이력 브랜치는 보존했다.
- 행동 eval `2/2 PASS`, role/public/scope 검사 통과. 제품 테스트·배포 검증·속도 개선 수치·Luna 실제 실행 검증은 포함하지 않는다. 실제 결과는 [EVIDENCE](docs/EVIDENCE.md)에 기록했다.

Migration: 기존 `AGENTS.md`, skill/UI metadata, LOW 종료 조건이 바뀐 named-agent 지침과 일반 prompt 호출 예시를 함께 병합한다. `docs/EVALS.md`는 하네스 변경 평가용으로 가져오되 기존 project 문서·Notion 대상·운영 정책은 덮어쓰지 않는다. `web`은 공통 업그레이드를 병합하되 `DESIGN.md`·`LANDING.md` overlay를 유지한다. 새 세션에서 설정을 확인하고 프로젝트에 필요한 focused hook만 초기화한다.

### v1.3.0 — 2026-08-29 (candidate)

- Luna implementation/test ownership과 조건부 Sol planner/approver/HIGH diagnosis를 정리했다.
- common과 web overlay의 책임을 분리하고 common에 제품별 design·landing·browser baseline을 강제하지 않는다.
- manifest 자동 탐색을 제거하고 explicit focused/release verification hook을 사용한다.
- Notion schema와 sync 절차를 `docs/NOTION.local.example.md` 한 곳으로 모으고 usage ratio·강제 stage를 제거한다.
- role 문서와 named config의 drift 검사 및 project/release hook example을 제공한다.
- Java/Next/제품 도메인에 종속된 요구사항은 공통 템플릿에서 제거한다.

Migration from v1.2:

| v1.2 | v1.3 |
|---|---|
| Terra-main active default write owner | `luna_max` sole implementation/test owner |
| Luna optional closed stage | Sol planner/approver/high are condition-based read-only roles |
| `verify.sh` manifest auto-detection | `--focused` / `--release` explicit hooks |
| common visual/landing baseline | web branch overlay; common neutral compatibility stubs |
| Notion property contract mixed into requirements | optional Notion contract in `docs/NOTION.local.example.md` |
| usage ratio and forced stages | actual evidence, risk and human decisions |
| one-off model request | `EVIDENCE` provenance only; default role contract remains unchanged |

### v1.2.0 — 2026-08-10

- Terra-main active default와 multi-stage routing을 사용한 이전 baseline이다. v1.3에서 현재 규칙으로 supersede된다.
- focused-first verification, read-only approval, human acceptance와 repeated-failure escalation의 기록은 migration 참고용으로 보존한다.

### v1.1.0 — 2026-08-05

초기 하네스의 local Source of Truth와 사람 소유 경계를 유지하면서, 프로젝트 운영과 구현 위임에 필요한 공통 contract를 확장했다.

- Engineering defaults: 가장 작은 working E2E, 추측성 추상화 억제, 기존 dependency 우선, 승인된 내부 obsolete path 제거와 공개 계약 migration의 사람 결정 경계를 추가했다.
- Notion project hub: Requirements, Decisions, Work Log, Troubleshooting 네 database blueprint와 `Decision ID` 기반 기술 결정 mirror를 추가했다.
- Landing template: 가치 제안, 실제 flow, 증거, 지원/비지원, 자동화/사람 책임, 데이터·보관, 실패·부분 실패와 support를 연결하는 `docs/LANDING.md`를 추가했다.
- Agent routing: v1.2.0에서 교체된 predecessor two-role routing을 도입했다.
- Verification: predecessor role configuration을 당시 runtime에서 확인했다.
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
- focused verification의 실제 명령·결과와 `NOT_RUN` 사유가 기록된다.
- LOW는 검증·결과 보고로 끝내고, 그 밖의 작업은 필요한 technical review와 사람의 acceptance 전까지 `ACTIVE`를 유지한다.
- 실행한 검증과 남은 미확인 사항이 구분된다.

공통 prompt는 `PROMPTS.md`에 있고, web-only prompt와 browser guidance는 `web` branch overlay에 둔다.
