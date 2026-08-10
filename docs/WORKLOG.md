# Work Log

의미 있는 작업 단위가 끝났을 때 최신 항목을 위에 추가한다. 파일 목록보다 사용자 가치, 흐름과 배운 점을 중심으로 쓴다.

## Entry template

### YYYY-MM-DD — 작업 제목

- Local Entry ID: `YYYY-MM-DD/short-slug`
- Requirement ID:
- User value:
- What changed:
- Flow / contract affected:
- Verification:
- What I learned or can now explain:
- Remaining:
- Notion: `미동기화 | local page URL`

### 2026-08-10 — v1.2 multi-stage routing과 commit-scope gate

- Local Entry ID: `2026-08-10/harness-v1-2-routing`
- Requirement ID: `R-003`
- User value: 일반 구현의 단일 write owner와 독립 검토·HIGH escalation 경계가 공통 하네스에서 명확해졌다.
- What changed: Terra-main default, 제한된 Luna·Sol role configs, focused-first review loop와 staged commit-scope gate를 추가하고 v1.1 two-role routing을 supersede했다.
- Flow / contract affected: 사용자 요청 → Terra-main contract/implementation → Luna (적용 시) → `sol_approver` → human acceptance; `sol_high`는 defined HIGH/repeated-failure escalation만 맡는다.
- Verification: static/public/scope checks `PASS`; direct script invocation failure를 README Bash command으로 수정 후 Luna re-review `PASS`; `sol_approver` final approval `APPROVED`.
- Model provenance: Terra-main `gpt-5.6-terra` / `max` single write; Luna `gpt-5.6-luna` / `max` / supported `fast` independent review; `sol_approver` `gpt-5.6-sol` / `medium` read-only approval; main model/effort `미확인`.
- Remaining: named-role runtime discovery `NOT_RUN`; template product verification은 product manifest가 없어 `NOT_RUN`.
- Notion: `미동기화 — external sync not requested`

### 2026-08-05 — Sol owner / Luna implementer 역할 라우팅

- Local Entry ID: `2026-08-05/sol-luna-agent-routing`
- Requirement ID: `R-002`
- User value: 책임·결정·기획은 깊은 owner context에 남기고, 승인된 구현·구체화는 빠른 별도 모델로 수행할 수 있다.
- What changed: project primary를 Sol/high로 설정하고 Luna/medium `implementer` custom agent, 책임표, bounded handoff와 escalation 규칙을 추가했다.
- Flow / contract affected: 사용자 요청→Sol framing→Luna implementation/evidence→Sol acceptance의 agent 경계가 생겼다.
- Verification: Codex config loader와 local model catalog `PASS`; ephemeral strict-config session에서 runtime `gpt-5.6-luna` / `medium` / `implementer`, spawn completed 확인.
- What I learned or can now explain: Codex는 한 thread의 단계별 model switch가 아니라 project default와 custom subagent config로 역할별 모델을 분리한다.
- Remaining: 실제 feature handoff에서 code quality, latency와 decision round-trip 관찰.
- Notion: `미동기화`

### 2026-08-05 — 엔지니어링·기술 결정·운영 경계 템플릿 확장

- Local Entry ID: `2026-08-05/harness-decisions-landing`
- Requirement ID: `R-001`
- User value: 새 프로젝트가 단순한 구현 원칙, 네 DB Notion hub와 신뢰 가능한 landing 구조를 같은 하네스에서 시작할 수 있다.
- What changed: 이미지의 원칙을 소유·호환성 안전 경계에 맞춰 `AGENTS.md`와 skill에 반영하고, Decisions property contract/project hub blueprint와 `docs/LANDING.md`를 추가했다.
- Flow / contract affected: local Markdown→Notion 안정 키가 `Decision ID`까지 확장됐고, project facts→landing copy/UI 변환 contract가 생겼다.
- Verification: 공개 안전, shell syntax, docs reference, 네 DB/stable key와 landing 필수 section 검사 `PASS`.
- What I learned or can now explain: obsolete 내부 경로 제거와 공개 계약 migration을 구분하는 이유, 기술 결정을 local SoT로 유지하며 Notion에 mirror하는 방식, 운영 경계를 marketing claim과 연결하는 방식을 설명할 수 있다.
- Remaining: 현재 Notion의 Decisions DB 생성·read-back과 실제 프로젝트 landing render는 요청 시 별도 실행한다.
- Notion: `미동기화 — Decisions database NOT_CONFIGURED`
