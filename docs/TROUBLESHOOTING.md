# Troubleshooting Log

재발 가능하거나 원인 파악에 시간이 든 문제만 남긴다. 단순 오타나 즉시 해결된 일은 `docs/EVIDENCE.md` 실행 로그로 충분하다.

## Entry template

### 증상

- Incident ID: `TS-YYYYMMDD-short-slug`
- Requirement ID:
- Status: `OPEN | RESOLVED | MONITORING`
- Context:
- Reproduction:
- Observed error:
- Root cause:
- Fix:
- Verification:
- Prevention / detection:
- Related flow or contract:
- Notion: `미동기화 | local page URL`

### Custom agent가 `invalid transport`로 무시됨

- Incident ID: `TS-20260805-custom-agent-invalid-transport`
- Requirement ID: `R-002`
- Status: `RESOLVED`
- Context: Luna implementer가 Notion 외부 write를 하지 못하도록 custom agent config에서 inherited MCP를 비활성화했다.
- Reproduction: ephemeral `codex exec --strict-config --sandbox read-only`에서 project `implementer` spawn 요청.
- Observed error: `Ignoring malformed agent role definition ... invalid transport`
- Root cause: custom agent의 `[mcp_servers.notion]` override에 `enabled = false`만 두어 standalone role config deserializer가 transport를 구성할 `url`을 찾지 못했다.
- Fix: 같은 table에 공개 endpoint `url`, `auth`, `required = false`를 명시하고 `enabled = false`를 유지했다.
- Verification: config loader에 malformed warning이 없고 strict-config E2E에서 role `implementer`, runtime model `gpt-5.6-luna`, effort `medium`, spawn completed를 확인했다.
- Prevention / detection: inherited MCP를 custom agent에서 끌 때도 유효한 server transport contract를 완성하고, 문법 검사만이 아니라 실제 role loader/spawn을 실행한다.
- Related flow or contract: `docs/AGENT_ROLES.md`, `.codex/agents/implementer.toml`, Sol owner → Luna implementer handoff.
- Notion: `미동기화`

### Push 직전 미푸시 commit metadata에 개인 identity가 포함됨

- Incident ID: `TS-20260829-push-commit-metadata`
- Requirement ID: `R-004`
- Status: `RESOLVED`
- Context: 파일 내용의 public safety 검사는 통과했지만, 아직 원격에 없는 outgoing commit metadata에는 local Git 사용자의 identity가 있었다.
- Reproduction: `git log origin/main..main --format='%an <%ae>'`와 web outgoing range를 push 전에 확인한다.
- Observed error: candidate file scan만으로는 Git author/committer metadata를 발견하지 못한다.
- Root cause: repository-local Git identity가 개인 계정 값으로 설정돼 있었다.
- Fix: local non-personal identity를 설정하고, 기존 원격 commit을 부모로 유지한 safe tree commit으로 미푸시 common/web history를 재구성했다. remote history rewrite나 force push는 하지 않았다.
- Verification: outgoing metadata가 non-personal identity로만 남고, `check-public.sh`, sensitive filename/content scan, remote preflight와 four-branch non-force push가 `PASS`했다.
- Prevention / detection: push 전 파일·untracked·ignored 경계뿐 아니라 outgoing commit author/committer metadata도 redacted identity 기준으로 검사한다.
- Related flow or contract: `scripts/check-public.sh`, `docs/EVIDENCE.md`, common branch delivery.
- Notion: `미동기화 — NOT_CONNECTED`
