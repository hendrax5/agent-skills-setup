---
name: autopilot-ui-fix
description: Audit and overhaul an existing frontend UI in one execution to eliminate AI slop, establish a DESIGN.md direction, apply React/Next.js best practices, verify in a real browser, and run code review.
disable-model-invocation: true
---

# Autopilot UI Fix

Take an existing project whose UI feels generic or "AI slop" and run a full **audit → design direction → refactor → browser QA → review** pipeline in one execution using fresh subagents per phase.

## Autonomous Decision Rule

- Do not stop to ask `During` vs `After` mode or routine styling questions.
- Use `antislop` with explicit `session override: after` in Phase 1 (audit), and `session override: during` in Phase 2 (implementation).
- If the user specified a visual style/reference in their prompt, follow it; otherwise derive a sharp, domain-appropriate aesthetic direction in `DESIGN.md` (avoiding generic dark slate card grids, meaningless gradients, and template clichés).

## Execution Pipeline

### Phase 0: Git Safety Baseline
1. Inspect `git status` and `git log --oneline -5`.
2. Ensure untracked/uncommitted existing work is not lost (if the repo has no commits yet or dirty state and no secrets like `.env` are staged, create a clean baseline commit or note the exact starting state; never commit `.env` or credentials).
- **Done when:** A clean comparison baseline exists for diffing and review.

### Phase 1: Slop Audit & Aesthetic Direction (Subagent 1 — Design & Audit)
Dispatch a fresh `self` subagent to:
1. Read `frontend/` (layout, global CSS, shell/navigation, core pages, `package.json`) and any `GLOSSARY.md` / `spec.md`.
2. Run a read-only audit using `antislop` (`session override: after`, loading `antislop-ui`, `antislop-human`, `antislop-layoutmobile`, `antislop-copywriting`), `web-design-guidelines`, and `vercel-react-best-practices`. Write numbered prioritized findings (`HIGH`, `MEDIUM`, `LOW`) to `anti-slop/audit-001-YYYY-MM-DD.md` (incrementing number if prior audits exist).
3. Invoke `frontend-design` to write `DESIGN.md` at the repo root defining concrete visual identity, palette tokens, typography (including `tabular-nums` / monospace rules for technical data where appropriate), layout density, component hierarchy, and anti-patterns to eliminate.
- **Done when:** Both the audit report and `DESIGN.md` are written on disk.

### Phase 2: Systematic UI Overhaul (Subagent 2 — Frontend Implementer)
Dispatch a fresh `self` subagent to:
1. Read `DESIGN.md` and the Phase 1 audit report. Apply `antislop` with `session override: during`.
2. Implement the design system (`globals.css`, typography, layout shell, navigation, primary views, tables, drawers/modals, and forms), resolving all `HIGH` and `MEDIUM` audit findings (such as unnecessary component remounting on live updates, poor information hierarchy, low-contrast labels, or mobile overflow).
3. Follow `vercel-composition-patterns` and `vercel-react-best-practices` while preserving all existing API contracts, auth/RBAC guards, and test behaviors.
4. Update and run frontend unit tests, `typecheck`, `lint`, and production `build`.
- **Done when:** All `HIGH`/`MEDIUM` findings are addressed and `test`, `typecheck`, `lint`, and `build` pass.

### Phase 3: Real Browser QA & Dual-Axis Review (Subagent 3 — QA & Reviewer)
Dispatch a fresh `self` subagent to:
1. Run the app locally (or test rendered routes) via `webapp-testing` (Playwright) or the `browser` subagent across both desktop and mobile viewports, verifying zero console/hydration errors, zero horizontal overflow, and clean visual polish. Fix any regressions found.
2. Run `code-review` (Standards + Spec/Audit compliance) against the Phase 0 baseline, plus `web-design-guidelines` verification.
3. Re-run the full frontend check suite after the final edit (`verification-before-completion`).
4. Report concisely to the user: key visual/structural changes made, links to `DESIGN.md` and the audit report, and exact commands/results observed.
