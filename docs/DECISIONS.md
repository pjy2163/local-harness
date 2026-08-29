# Decision Log

중요한 선택만 기록한다. AI는 초안과 대안을 제안할 수 있지만 `ACCEPTED`는 사람의 결정을 근거로 한다.

## Index

| ID | Decision | Status | Date |
|---|---|---|---|
| ADR-001 | 하나의 적응형 루프와 동적 상태를 사용한다 | `ACCEPTED` | template baseline |
| ADR-002 | Notion은 로컬 원장의 수동 mirror로 시작한다 | `ACCEPTED` | template baseline |
| ADR-003 | 초기 공통 UI는 white/cool-neutral baseline에서 시작한다 | `SUPERSEDED` | template history |
| ADR-004 | 단순한 working layer와 명시적인 호환성 경계를 기본으로 한다 | `ACCEPTED` | 2026-08-05 |
| ADR-005 | 기술 결정을 네 번째 Notion mirror database로 둔다 | `ACCEPTED` | 2026-08-05 |
| ADR-006 | web overlay landing에 운영 경계를 포함한 content contract를 사용한다 | `ACCEPTED` | 2026-08-05 |
| ADR-007 | Sol owner와 Luna implementer로 책임과 실행을 분리한다 | `SUPERSEDED` | 2026-08-05 |
| ADR-008 | Terra-main·Luna·Sol multi-stage routing과 commit-scope gate를 사용한다 | `SUPERSEDED` | 2026-08-10 |
| ADR-009 | v1.3 common policy와 선택적 web overlay를 사용한다 | `PROPOSED` | 2026-08-29 |

## ADR-001: 고정 단계 대신 적응형 프로젝트 루프

- Status: `ACCEPTED`
- Context: 특정 과제의 고정 단계, 시간표와 의무 agent 구성을 공통 템플릿에 넣으면 일반 프로젝트 요청에 과한 정지와 중복 문서를 만든다.
- Decision: 공통 Git·보안·인간 소유 원칙은 `AGENTS.md`에 고정하고, 프로젝트 상태는 `docs/STATE.md`에서 AI가 갱신한다. 실행 절차는 하나의 `project-harness` 스킬이 요청에 따라 조절한다.
- Why: 안전 경계는 유지하면서 프로젝트 종류, 시간과 프롬프트에 맞게 가장 작은 End-to-End 흐름을 선택하기 위해서다.
- Alternatives: Frame/Build/Verify 스킬과 고정 작업 카드를 유지하고 각 프로젝트에서 값을 바꾼다.
- Why excluded: 동일한 상태를 여러 파일에 반복하고, 작은 요청도 단계 전환과 승인을 요구하며, AI 기능이 없는 프로젝트에도 잘못된 제약을 준다.
- Risks: AI가 상태 문서를 과도하게 갱신하거나 확인되지 않은 판단을 사실처럼 남길 수 있다.
- Verification: 문서별 갱신 조건, 사실/가정 구분, 인간 소유 결정 상태와 읽기 전용 forward test로 확인한다.
- Human confirmation: 프로젝트 종류에 맞게 유연한 공통 하네스와 사람의 구현 결정권을 유지한다.

## ADR-002: Notion은 수동 단방향 mirror로 시작

- Status: `ACCEPTED`
- Context: 프로젝트 기록을 Notion과 연결하되 충돌 처리와 자동화 복잡도를 최소화해야 한다.
- Decision: 로컬 Markdown을 Source of Truth로 유지하고 승인된 기록을 각각의 안정 ID로 수동 단방향 sync한다. 실제 Notion 대상과 sync 상태는 Git에서 제외되는 `docs/NOTION.local.md`에 둔다.
- Why: 로컬 코드·검증 증거와 요구사항의 연결을 보존하면서 외부 문서 충돌과 의도하지 않은 삭제를 피하기 위해서다.
- Alternatives: Notion canonical 또는 자동 양방향 sync.
- Why excluded: 초기 프로젝트에서 충돌 해결, 삭제 전파, 권한과 자동 실행 상태가 추가돼 하네스가 과도하게 복잡해진다.
- Risks: Notion에서 직접 수정한 내용이 로컬로 자동 반영되지 않는다.
- Verification: 프로젝트마다 preview, schema read-back, write/read-back과 같은 키 재실행으로 확인한다.
- Human confirmation: Notion은 사람이 확인하는 기록으로 사용하고, 구현 범위와 외부 쓰기는 사람이 결정한다.

## ADR-003: White/cool-neutral 초기 디자인 baseline

- Status: `SUPERSEDED`
- Superseded for the common branch by ADR-009; retained as a possible web-overlay reference.
- Context: 프로젝트마다 세부 디자인은 달라지지만 세련되고 깔끔한 공통 출발점이 필요하다.
- Decision: pure white 중심, cool gray 계층, 넉넉한 자간, 낮은 elevation과 제한된 accent를 공통 baseline으로 사용한다. beige·cream 계열은 제외하고 프로젝트별 brand 선택은 override한다.
- Why: AI가 매 프로젝트에서 임의의 스타일을 새로 만들지 않으면서도 브랜드별 유연성을 유지하기 위해서다.
- Alternatives: Aqua Voice token 전체 복제 또는 프로젝트마다 완전 자유 설계.
- Why excluded: 복제는 특정 브랜드와 폰트에 과도하게 종속되고, 완전 자유 설계는 일관된 품질 기준이 없다.
- Risks: white/minimal 스타일이 정보 밀도가 높은 제품에서 지나치게 비어 보일 수 있다.
- Verification: 실제 viewport screenshot에서 hierarchy, density, UI states, contrast와 responsive behavior를 검토한다.
- Human confirmation: Zelt·Aqua Voice를 참고한 white 중심, beige 제외, 넉넉한 자간과 프로젝트별 변형을 공통 기준으로 사용한다.

## ADR-004: 단순한 working layer와 명시적인 호환성 경계

- Status: `ACCEPTED`
- Requirement ID: `R-001`
- Context: 추측성 추상화, 임시 fallback과 중복 구현은 작은 프로젝트의 설명 가능성과 장기 유지 비용을 악화시킨다. 반대로 모든 호환성과 migration을 무조건 제거하면 공개 계약과 저장 데이터의 소유 경계를 침범할 수 있다.
- Decision: 현재 요구사항을 완전히 충족하는 가장 단순한 End-to-End 흐름에서 시작하고 capability를 작동하는 제품 위에 한 겹씩 추가한다. 기존 dependency의 문서와 types를 먼저 확인하고, 전체 복잡도를 낮추는 유지보수 library를 재사용한다. 승인된 내부 obsolete path는 fallback 없이 제거하되 공개 API·저장 데이터·외부 소비자 계약 파괴와 migration은 사람이 영향·전환·rollback을 결정한다.
- Why: 단순성과 장기 구조를 얻으면서도 사용자 데이터와 외부 계약의 안전 경계를 보존하기 위해서다.
- Alternatives: 낡은 경로를 무기한 유지하거나, 모든 기존 경로와 migration을 문맥 없이 즉시 제거한다.
- Why excluded: 전자는 복잡도를 누적하고 후자는 호환성·데이터 손실 위험과 인간 소유 결정을 무시한다.
- Risks: 내부/외부 계약의 구분이 불명확하면 제거 범위가 흔들릴 수 있다.
- Verification: 실제 소비자와 데이터 출처를 추적하고, 제거 전 관련 contract/failure test와 rollback 요구를 확인한다.
- Human confirmation: 2026-08-05 첨부 원칙을 하네스에 추가하라는 사용자 요청과 기존 ownership boundary를 함께 적용한다.

## ADR-005: 기술 결정을 네 번째 Notion mirror database로 관리

- Status: `ACCEPTED`
- Requirement ID: `R-001`
- Context: 로컬에는 ADR-lite가 있지만 Notion project hub에는 요구사항·작업일지·트러블슈팅만 있어 사람이 기술 선택과 대안을 한곳에서 확인하기 어렵다.
- Decision: `docs/DECISIONS.md`를 Source of Truth로 유지하고 `Decision ID`를 안정 키로 쓰는 Decisions database를 수동 `local → Notion` mirror에 추가한다. AI는 `PROPOSED` 초안을 만들 수 있지만 사람의 근거 없이 `ACCEPTED`로 바꾸지 않는다.
- Why: 요구사항, 구현 기록, 장애와 기술 선택을 같은 project hub에서 연결하되 로컬 코드 맥락과 인간 결정권을 유지하기 위해서다.
- Alternatives: Work Log 본문에 결정을 섞거나 Notion을 결정의 Source of Truth로 바꾼다.
- Why excluded: 안정 키와 상태 이력이 사라지거나 양방향 충돌·권한 복잡도가 생긴다.
- Risks: 같은 결정이 로컬과 Notion에서 다르게 수정될 수 있다.
- Verification: schema 비교, `Decision ID` upsert, write/read-back과 같은 키 재실행으로 중복과 상태를 확인한다.
- Human confirmation: 2026-08-05 Notion page 생성 시 기술 결정 database를 추가해 달라는 사용자 요청.

## ADR-006: 운영 경계를 포함한 web overlay landing content contract

- Status: `ACCEPTED`
- Requirement ID: `R-001`
- Context: visual baseline만으로는 프로젝트 landing이 무엇을 약속하고 어디까지 운영하는지 일관되게 설명하기 어렵다.
- Decision: 특정 reference의 브랜드를 복제하지 않고 promise, working flow, proof, operating boundary, capability state, FAQ와 CTA를 연결하는 `docs/LANDING.md`를 공통 템플릿으로 사용한다. 지원/비지원, 자동화/사람 책임, 데이터, 실패, privacy/retention, availability와 support는 프로젝트 사실로 초기화한다.
- Why: 세련된 화면뿐 아니라 사용자가 서비스의 실제 범위와 위험을 이해하고 행동할 수 있는 landing을 반복 가능하게 만들기 위해서다.
- Alternatives: 프로젝트마다 자유 형식으로 작성하거나 운영 경계를 약관/FAQ에만 둔다.
- Why excluded: 핵심 신뢰 정보가 누락되거나 실제 기능과 marketing claim이 분리된다.
- Risks: 모든 행을 기계적으로 노출하면 작은 landing이 무거워질 수 있다.
- Verification: 해당 없는 항목은 제거하되 중요한 미확인은 표시하고, 실제 flow/evidence와 content를 대조한 뒤 mobile·desktop·keyboard로 렌더링을 확인한다.
- Human confirmation: 2026-08-05 en:ground처럼 운영 경계 등을 공통화할 landing template 요청.

이 결정의 현재 적용 범위는 `web` branch overlay다. Common branch는 특정 visual 또는 landing baseline을 강제하지 않는다.

## ADR-007: Sol owner와 Luna implementer 역할 분리

- Status: `SUPERSEDED`
- Requirement ID: `R-002`
- Superseded by: `ADR-008` (2026-08-10). 아래 detail은 v1.1 기록으로 보존한다.
- Context: 구현 로그와 세부 수정이 주 thread의 요구사항·책임·결정 맥락을 흐릴 수 있고, 모든 작업에 같은 모델 깊이를 쓰면 비용과 속도를 조절하기 어렵다.
- Decision: trusted project의 primary를 `gpt-5.6-sol` + `high`로 두어 문제·책임·기획·중요한 결정과 최종 acceptance를 소유하게 한다. 승인된 구현·구체화는 `gpt-5.6-luna` + `medium` custom `implementer`에 bounded handoff하고, Sol owner가 handback의 contract·검증과 남은 결정을 통합 검토한다.
- Why: 인간 결정과 프로젝트 책임 맥락은 깊은 reasoning thread에 보존하면서, 명확하고 반복 가능한 구현은 빠른 모델로 분리하기 위해서다.
- Alternatives: 단일 Sol agent가 전 과정을 수행하거나 모든 subagent의 global default를 Luna로 바꾼다.
- Why excluded: 전자는 구현 소음과 비용을 집중시키고, 후자는 reviewer·decision 역할까지 Luna로 낮출 수 있다.
- Risks: handoff가 불완전하면 Luna가 잘못된 범위를 구현하거나 결정이 반복 왕복될 수 있다. project config는 이미 시작된 session에 소급 적용되지 않을 수 있다.
- Verification: TOML parsing, strict project config, local model catalog의 slug/effort, 새 session의 custom role discovery와 실제 spawn metadata를 순서대로 확인한다.
- Human confirmation: 2026-08-05 구현·구체화는 Luna medium, 책임·결정·기획은 Sol high로 분리하라는 사용자 요청.

## ADR-008: Terra-main·Luna·Sol multi-stage routing과 commit-scope gate

- Status: `SUPERSEDED`
- Requirement ID: `R-003`
- Context: v1.1 two-role routing은 일반 구현 ownership과 independent approval, HIGH/repeated-failure escalation을 충분히 구분하지 못했다.
- Decision: Terra-main (`gpt-5.6-terra` / `max`)이 `LOW/MEDIUM` contract와 일반 production/test/focused verification/final regression의 single write owner다. Luna (`gpt-5.6-luna` / `max`, supported surface `fast`)는 닫힌 stage 또는 independent read-only verification만 맡고, `sol_approver` (`gpt-5.6-sol` / `medium`)는 read-only final approval, `sol_high` (`gpt-5.6-sol` / `high`)는 defined HIGH/repeated-failure diagnosis·contract만 맡는다. staged diff는 `600` non-generated text changed lines 또는 `12` non-generated text files에서 review stop을 낸다.
- Why: 구현 책임은 한 곳에 두면서 좁은 병렬·review 역할과 escalation 증거를 명시하기 위해서다.
- Alternatives: v1.1 two-role routing을 유지하거나 하나의 Sol role이 모든 작업을 수행한다.
- Why excluded: 전자는 approval/escalation 경계가 부족하고, 후자는 닫힌 반복 작업과 독립 review의 비용·검증 이점을 잃는다.
- Risks: named-role runtime discovery와 실제 product handoff 품질은 아직 검증되지 않았다.
- Verification: shell/public/static/staged-scope checks, Luna re-review `PASS`, `sol_approver` final approval `APPROVED`; runtime discovery와 template product verification은 `NOT_RUN`이다.
- Human confirmation: 2026-08-10 사용자가 v1.2 candidate를 명시적으로 승인했다.
- Superseded by ADR-009 for the v1.3 active contract; retained as v1.2 provenance.

## ADR-009: v1.3 common policy와 선택적 web overlay

- Status: `PROPOSED`
- Requirement ID: `R-004`
- Context: v1.2 템플릿은 Terra-main active routing, 고정된 multi-stage 흐름, manifest 자동 검증과 common visual/landing 문서를 한 저장소에 묶었다. 실제 프로젝트 사용에서는 작은 변경에도 planner·approver·full suite가 반복되고, 제품별 문서와 공통 정책이 섞이며, 실행하지 않은 검증을 성공처럼 해석할 위험이 있었다.
- Decision: common branch는 사람이 확정한 closed contract의 implementation/test/focused evidence를 한 implementation owner가 소유한다. planner·technical approver·HIGH/repeated-failure diagnosis는 조건부 read-only 역할로 둔다. `verify.sh`는 `--focused`와 `--release` hook만 명시적으로 실행한다. visual, landing, browser 기준은 `web` branch overlay로 이동하고 Notion schema/procedure는 optional example 문서 한 곳에 둔다. usage ratio와 자동 model/effort fallback은 기록하지 않는다.
- Why: 가장 작은 working flow와 실제 evidence에 집중하면서도 사람의 업무 규칙·외부 write·중요한 위험 결정을 보존하고, common template가 제품에 과적합되지 않게 하기 위해서다.
- Alternatives: v1.2 multi-stage를 유지하거나 모든 project stack을 `verify.sh`가 자동 탐지하게 둔다.
- Why excluded: 역할 강제와 broad 자동 실행이 작은 작업의 latency·중복·검증 의미를 악화시키며, stack 자동 탐지는 프로젝트별 명령과 실패 경계를 숨긴다.
- Risks: 사람이 focused hook과 release gate를 올바르게 정의해야 하며, web overlay 선택을 누락하면 UI 검증이 약해질 수 있다.
- Verification: role/config syntax, explicit hook behavior, public/scope checks, common/web tree comparison과 README migration review. 실제 project runtime·browser·Notion write는 프로젝트에서 별도로 검증한다.
- Human confirmation: `PENDING` — v1.3 candidate review packet 뒤 사람이 승인한다.

## ADR template

### ADR-000: 제목

- Status: `PROPOSED`
- Requirement ID:
- Context:
- Decision:
- Why:
- Alternatives:
- Why excluded:
- Risks:
- Verification:
- Human confirmation:
