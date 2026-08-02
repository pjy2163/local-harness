# Decision Log

중요한 선택만 기록한다. AI는 초안과 대안을 제안할 수 있지만 `ACCEPTED`는 사람의 결정을 근거로 한다.

## Index

| ID | Decision | Status | Date |
|---|---|---|---|
| ADR-001 | 하나의 적응형 루프와 동적 상태를 사용한다 | `ACCEPTED` | template baseline |
| ADR-002 | Notion은 로컬 원장의 수동 mirror로 시작한다 | `ACCEPTED` | template baseline |
| ADR-003 | 공통 UI는 white/cool-neutral baseline에서 시작한다 | `ACCEPTED` | template baseline |

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
- Context: 요구사항, 작업일지와 트러블슈팅을 Notion과 연결하되 충돌 처리와 자동화 복잡도를 최소화해야 한다.
- Decision: 로컬 Markdown을 Source of Truth로 유지하고 세 기록을 각각의 안정 ID로 수동 단방향 sync한다. 실제 Notion 대상과 sync 상태는 Git에서 제외되는 `docs/NOTION.local.md`에 둔다.
- Why: 로컬 코드·검증 증거와 요구사항의 연결을 보존하면서 외부 문서 충돌과 의도하지 않은 삭제를 피하기 위해서다.
- Alternatives: Notion canonical 또는 자동 양방향 sync.
- Why excluded: 초기 프로젝트에서 충돌 해결, 삭제 전파, 권한과 자동 실행 상태가 추가돼 하네스가 과도하게 복잡해진다.
- Risks: Notion에서 직접 수정한 내용이 로컬로 자동 반영되지 않는다.
- Verification: 프로젝트마다 preview, schema read-back, write/read-back과 같은 키 재실행으로 확인한다.
- Human confirmation: Notion은 사람이 확인하는 기록으로 사용하고, 구현 범위와 외부 쓰기는 사람이 결정한다.

## ADR-003: White/cool-neutral 공통 디자인 baseline

- Status: `ACCEPTED`
- Context: 프로젝트마다 세부 디자인은 달라지지만 세련되고 깔끔한 공통 출발점이 필요하다.
- Decision: pure white 중심, cool gray 계층, 넉넉한 자간, 낮은 elevation과 제한된 accent를 공통 baseline으로 사용한다. beige·cream 계열은 제외하고 프로젝트별 brand 선택은 override한다.
- Why: AI가 매 프로젝트에서 임의의 스타일을 새로 만들지 않으면서도 브랜드별 유연성을 유지하기 위해서다.
- Alternatives: Aqua Voice token 전체 복제 또는 프로젝트마다 완전 자유 설계.
- Why excluded: 복제는 특정 브랜드와 폰트에 과도하게 종속되고, 완전 자유 설계는 일관된 품질 기준이 없다.
- Risks: white/minimal 스타일이 정보 밀도가 높은 제품에서 지나치게 비어 보일 수 있다.
- Verification: 실제 viewport screenshot에서 hierarchy, density, UI states, contrast와 responsive behavior를 검토한다.
- Human confirmation: Zelt·Aqua Voice를 참고한 white 중심, beige 제외, 넉넉한 자간과 프로젝트별 변형을 공통 기준으로 사용한다.

## ADR template

### ADR-000: 제목

- Status: `PROPOSED`
- Context:
- Decision:
- Why:
- Alternatives:
- Why excluded:
- Risks:
- Verification:
- Human confirmation:
