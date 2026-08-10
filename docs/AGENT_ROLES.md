# Agent Role and Model Routing

v1.2는 기존의 두 역할 위임 모델을 교체한다. Terra-main이 일반 구현의 단일 write owner이고, Luna와 Sol은 계약상 제한된 stage만 맡는다.

## Role map

| Role | Configuration | Responsibility | Never does |
|---|---|---|---|
| Terra-main | project default `gpt-5.6-terra`, `max` | `LOW/MEDIUM` contract·handoff 조율, production/test/focused verification/fix/final regression | 새 인간 소유 rule·security·compatibility 결정을 임의 확정 |
| Luna | `luna_max`, `gpt-5.6-luna`, `max`, `fast` where supported | 닫힌 matrix·반복 assertion·좁은 stage 또는 독립 read-only verification | Terra-main과 같은 worktree에서 병렬 write, 열린 판단 |
| `sol_approver` | `gpt-5.6-sol`, `medium`, read-only | final evidence·contract·Luna findings 기반 `LOW/MEDIUM` approval | product/config/test write 또는 broad rerun |
| `sol_high` | `gpt-5.6-sol`, `high` | `HIGH` 판단 또는 두 fix→affected-test cycle 뒤 root-cause diagnosis/contract | 구현 또는 broad regression |

프로젝트 default는 [`.codex/config.toml`](../.codex/config.toml), named role 설정은 [`.codex/agents/`](../.codex/agents/)에 둔다. trusted project의 새 session에서 적용한다.

## Workflow

```text
Human request
  → Terra-main: LOW/MEDIUM task contract와 single writer 지정
  → Luna: 적용 시 닫힌 stage 또는 독립 read-only verification
  → sol_approver: evidence-based, read-only final approval
  → Terra-main: review packet
  → Human: acceptance
```

## Task contract

```text
Outcome:
In scope / out of scope:
Fixed rules and acceptance:
Affected boundaries and risk:
Focused verification command:
Escalation condition:
```

- `HIGH` 위험 또는 새 business, architecture, security, authorization, money, concurrency, compatibility 결정은 구현 전에 `sol_high` 또는 사람에게 올린다.
- 같은 worktree에는 한 write owner만 둔다. Luna가 write stage를 맡으면 명시적으로 그 stage의 sole owner가 되고 Terra-main과 병렬로 쓰지 않는다.
- focused verification을 먼저 실행한다. final candidate의 full regression은 한 번만 실행하고, 후보가 바뀐 경우에만 affected check와 full regression을 다시 실행한다.
- 최초 failure 재현은 retry가 아니다. 같은 failure가 두 complete `fix → affected-test rerun` cycle 뒤에도 남으면 `sol_high`에 failure evidence, attempted delta와 narrowest unresolved boundary를 반환한다.

## Approval and runtime

- `LOW/MEDIUM` final approval은 Terra-main contract·self-verification·final evidence와 적용 가능한 Luna findings를 `sol_approver`가 read-only로 검토해 만든다. finding은 `BLOCKER | MUST | SHOULD | LEARNING`으로 돌려준다.
- final order는 `Terra-main → Luna (적용 시) → sol_approver → review packet → human acceptance`다. 승인 전에는 `ACTIVE`, 승인 뒤에만 evidence·worklog·optional mirror를 batch sync한다.
- requested model이 surface에 없으면 더 높은 capability tier로만 대체하고 handoff에 기록한다. `sol_high` 역할은 자동 하향하지 않는다.
- staging gate는 `git diff --cached --check`, `bash scripts/check-commit-scope.sh --staged`, `git diff --cached --stat`, `git diff --cached`다. `600` non-generated text changed lines 또는 `12` non-generated text files는 bypassable normal path가 아닌 review stop이다.
