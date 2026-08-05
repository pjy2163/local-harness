# Verification Evidence

실제로 실행하거나 직접 확인한 사실만 추가한다. 템플릿의 빈 상태나 AI의 성공 설명은 증거가 아니다.

## Current verification summary

- Last verified at: `2026-08-05 17:15 KST`
- Revision or working tree: `8952d49 + working tree`
- Overall: `PASS` for local template, agent configuration and role spawn
- Unverified claims: 실제 Notion Decisions DB 생성/schema/read-back, 특정 프로젝트 landing 렌더링과 CTA 동작, 실제 feature handoff의 품질·latency

## Execution log

| Time | User flow or boundary | Command / input | Expected | Actual | Status |
|---|---|---|---|---|---|
| 2026-08-05 15:49 KST | 공개 저장소 안전 경계 | `./scripts/check-public.sh` | 흔한 secret·개인 경로·Notion link 없음 | 해당 패턴 없음 | `PASS` |
| 2026-08-05 15:49 KST | script syntax | `bash -n scripts/check-public.sh scripts/verify.sh` | shell syntax valid | exit 0 | `PASS` |
| 2026-08-05 15:49 KST | public docs reference | `rg`로 `docs/*.md` reference 추출 후 존재 확인 | optional local 파일 외 모든 참조 존재 | missing 0 | `PASS` |
| 2026-08-05 15:49 KST | Notion / landing contract | 네 database heading·네 stable key·landing 필수 section 검사 | 각 contract 존재 | expected count와 section 모두 확인 | `PASS` |
| 2026-08-05 17:02 KST | Codex model catalog | `codex debug models` + `jq` | Sol은 high, Luna는 medium 지원 | Sol `low..ultra`, Luna `low..max`; 두 effort 포함 | `PASS` |
| 2026-08-05 17:05 KST | project config loader | `codex debug prompt-input "config validation only"` | project config와 custom agent 오류 없음 | JSON array 생성, malformed role warning 없음 | `PASS` |
| 2026-08-05 17:06 KST | Sol owner → Luna implementer configuration E2E | ephemeral `codex exec --strict-config --sandbox read-only` | custom role 발견, Luna/medium으로 완료 | runtime model `gpt-5.6-luna`, effort `medium`, role `implementer`, completed `yes` | `PASS` |
| 2026-08-05 17:08 KST | role routing regression | diff/public safety, committable path, exact model/effort와 docs reference checks | 변경과 contract 일관성 | 모든 검사 exit 0 | `PASS` |
| 2026-08-05 17:15 KST | v1.1.0 public release candidate | `check-public.sh`, tracked diff/new-file UUID·email·개인 경로·Notion link·credential pattern 검사, ignored local state 확인 | 민감정보 없이 공개 가능 | 새 변경에서 민감 패턴 없음; 기존 UUID형 문자열 1건은 원본 커밋의 공개 Refero reference URL로 확인 | `PASS` |

## Failure → fix → retest

실제 실패가 있었을 때만 작성한다.

| Time | Reproduction | Root cause | Smallest fix | Retest | Result |
|---|---|---|---|---|---|
| 2026-08-05 17:03 KST | 첫 ephemeral custom role spawn | implementer file의 disabled Notion MCP table에 transport 정보가 없음 | disabled MCP에도 `url`/`auth`를 명시 | config loader + strict-config spawn 재실행 | `PASS` |

## Remaining verification gaps

- 현재 연결된 Notion에는 Decisions database/data source가 아직 없어 외부 schema와 idempotency를 검증하지 않았다.
- 특정 프로젝트 landing 코드가 없으므로 mobile/desktop, keyboard, CTA state와 실제 claim 대조는 실행하지 않았다.
- `scripts/verify.sh`의 제품별 검사 경계는 이 template을 적용할 프로젝트에서 정한다.
- 실제 feature를 Luna에 handoff했을 때의 code quality, latency와 decision round-trip은 다음 구현에서 측정한다.
