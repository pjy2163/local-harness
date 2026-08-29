# Agent Role and Model Routing (v1.3)

This file is the exact source of truth for agent `role`, `model`, `effort`,
`sandbox`, ownership, and invocation conditions. Runtime configuration under
`.codex/` must conform to this contract; it does not create an alternate
ownership or fallback rule.

## Fixed contract

- Human decision owners choose the user problem, priority, approved scope,
  Source of Truth, business rules, compatibility boundaries, architecture,
  security, authorization, money, concurrency, and deployment decisions.
- `luna_max` implements a closed `LOW/MEDIUM` contract inside those decisions.
  It is the sole write owner for production code, tests, focused verification,
  fixes, and the documentation sync required by that contract.
- A worktree has one write owner at a time. Agents must not write concurrently
  in the same worktree.
- No automatic model or effort fallback is allowed. If the requested role or
  exact setting is unavailable, record `NOT_RUN` and return the decision.
- Do not estimate or report usage ratios. Do not force planner, approver, or
  full-regression stages for work whose conditions do not call for them.
- A new business, domain, security, authorization, money, concurrency, or
  compatibility decision returns to the human decision owner or the
  appropriate Sol role; it is not invented inside implementation.

## Per-task model selection

A human may explicitly select a model and effort for one maintenance task. The
requested and actual setting, result, and any limitation belong in
`docs/EVIDENCE.md`; they do not silently rewrite this reusable role map. For
the v1.3 maintenance request, `gpt-5.6-sol / medium` was the requested task
model. The default v1.3 contract remains `luna_max` as the implementation/test
owner, with Sol roles read-only and conditional.

## Role map

| Role | Model / effort | Sandbox | Ownership and output | Invoke only when |
|---|---|---|---|---|
| `luna_max` | `gpt-5.6-luna` / `max` / `fast` | `workspace-write` | Sole write owner for a closed `LOW/MEDIUM` contract: production code, tests, focused verification, fixes, and required documentation sync. | Existing human decisions close the rules and scope. |
| `sol_planner` | `gpt-5.6-sol` / `max` | `read-only` | Returns only outcome, in/out of scope, acceptance, risk, focused verification, and human decisions needed. | A new feature or unclear scope needs a bounded contract. |
| `sol_approver` | `gpt-5.6-sol` / `medium` | `read-only` | Performs only the configured gate or necessary technical approval after `LOW/MEDIUM` evidence. Returns read-only findings. | Final evidence exists and the configured/needed approval condition applies. |
| `sol_high` | `gpt-5.6-sol` / `xhigh` | `read-only` | Returns diagnosis and a bounded contract only; it does not implement or test. | A `HIGH`-risk judgment is required, or the same failure remains after two complete `fix → affected-test rerun` cycles. |

All Sol roles are read-only: they do not modify or execute production code,
tests, migrations, configuration, or documentation. Sol does not replace the
human decision owner, and Luna does not approve a new human-owned rule.

## Human and Luna boundary

The human decision owner owns:

- the problem, priority, acceptance intent, and approved in/out of scope;
- business/domain rules and the Source of Truth;
- compatibility, architecture, security, authorization, money, concurrency,
  and irreversible external-state decisions; and
- whether an unresolved decision is accepted, changed, or deferred.

Within a closed contract, `luna_max` owns:

- the task contract wording and repeatable success/failure preflight matrix;
- the smallest vertical implementation and its production tests;
- focused verification, failure isolation, minimum fixes, and reruns; and
- the evidence and required documentation sync for the approved unit.

Luna must stop at a missing decision, unclear boundary, environment/permission
decision, or new protected rule and return evidence without expanding scope.

## Routing and handoff

```text
Human-approved closed LOW/MEDIUM contract
  → luna_max: contract, preflight, implementation, focused verification, fix
  → sol_approver: only when configured or technically required
  → Luna review packet → human acceptance

New feature or unclear scope
  → sol_planner: read-only contract
  → human decision owner closes the decisions
  → luna_max: implementation and verification

HIGH-risk judgment or repeated failure
  → sol_high: read-only diagnosis/contract
  → human/Sol decision closes the boundary
  → luna_max: implementation and verification
```

The planner is not mandatory for a closed contract. The approver is not
mandatory for every task. Human acceptance is not replaced by either role.

## Task contract

Every Luna write unit stays inside this bounded contract:

```text
Outcome:
In scope / out of scope:
Fixed human decisions and rules:
Acceptance:
Affected boundaries and risk:
Repeatable success preflight:
Repeatable failure/boundary preflight:
Focused verification command:
Escalation condition:
```

Focused verification covers the changed boundary and its meaningful failure
case. Full regression is run only when an explicit gate, shared boundary,
regression finding, or human request requires it; it is never a default stage.

The repository-level role/config consistency check is
`bash scripts/check-role-contract.sh`. It is a static drift detector, not a
runtime role-discovery or permission proof.

## Failure and escalation

- The first failure reproduction is evidence, not a retry.
- After each complete `fix → affected-test rerun` cycle, Luna keeps the delta
  inside the contract and records the result.
- If the same failure survives two complete cycles, Luna does not widen the
  patch. It sends the failure evidence, attempted deltas, and narrowest
  unresolved boundary to `sol_high`.
- `sol_high` returns diagnosis/contract only; Luna remains the implementation
  and test owner after the boundary is decided.
- Sol findings are classified as `BLOCKER`, `MUST`, `SHOULD`, or `LEARNING`.

## Superseded history

Earlier v1.2 material described Terra-main as the active default write owner
and used older routing details. That history is retained only as provenance;
it is superseded and is not an active role, model, or ownership rule. The v1.3
contract above is authoritative.
