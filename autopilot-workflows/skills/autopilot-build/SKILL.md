---
name: autopilot-build
description: Run a complete end-to-end project or feature build in one execution (architecture, GLOSSARY/ADR, DESIGN.md, spec, vertical-slice tickets, TDD implementation, Playwright/browser QA, and two-axis code review).
disable-model-invocation: true
---

# Autopilot Build

Orchestrate a full **0 → finish** (or new-feature) pipeline from a single user prompt without stopping to interview the user at every step. Preserve context hygiene by dispatching fresh subagents (`invoke_subagent` with `type_name: "self"`) per phase and communicating via file pointers on disk.

## Autonomous Decision Rule

- **Do not pause to interview the user** for routine technical, stack, or aesthetic choices unless there is an irreversible destructive action or missing external secret/credential only the user possesses.
- For unspecified choices, pick the cleanest industry-standard option for the project's scale, record the rationale in `docs/adr/` (if significant) and `DESIGN.md` (if UI), and proceed.

## Execution Pipeline

### Phase 0: Workspace & Tracker Preflight
1. Ensure the target directory is initialized with Git (`git init` if not a repo) and check `git status`.
2. If `.scratch/` or `docs/agents/issue-tracker.md` does not exist, initialize a local-markdown tracker structure (`AGENTS.md`, `docs/agents/issue-tracker.md`, `docs/agents/domain.md`, `docs/agents/triage-labels.md`).
- **Done when:** Git repo exists and tracker conventions are ready on disk.

### Phase 1: Architecture, Domain Modeling & Spec/Tickets (Subagent — Architect)
Dispatch one fresh `self` subagent to:
1. Explore the repo (if existing code is present), `GLOSSARY.md`, and `docs/adr/`.
2. Resolve key architectural decisions autonomously; update `GLOSSARY.md` and write `docs/adr/NNNN-*.md` where genuinely hard-to-reverse trade-offs exist.
3. If the project includes a Web UI, invoke `frontend-design` and `antislop` (explicitly using `session override: during`) to establish an intentional, non-generic `DESIGN.md` at the repo root before any UI code is written.
4. Write `.scratch/<feature-slug>/spec.md` and break it into vertical tracer-bullet tickets under `.scratch/<feature-slug>/issues/01..NN.md` with clear `Blocked by:` edges and acceptance criteria.
- **Done when:** `GLOSSARY.md`, `DESIGN.md` (if UI), `spec.md`, and all numbered ticket files exist on disk and are self-contained.

### Phase 2: Frontier-Driven TDD Implementation (Fresh Subagents per Frontier)
1. Inspect `.scratch/<feature-slug>/issues/` and group unblocked tickets into execution waves.
2. For each ticket in the ready frontier, dispatch a fresh `self` subagent (run independent tickets in parallel using `workspace: "share"` when editing separate areas, or sequentially if they touch shared foundation files; merge/land cleanly).
3. Each implementer subagent must:
   - Read `GLOSSARY.md`, `docs/adr/`, `DESIGN.md` (if UI), and only its assigned ticket + `spec.md`.
   - Drive implementation via `tdd` (red-green-refactor).
   - For frontend/UI tickets, enforce: `antislop` (`session override: during`), `antislop-ui`, `antislop-human`, `antislop-layoutmobile`, `vercel-react-best-practices`, and `vercel-composition-patterns`.
   - Run relevant tests/typechecks before reporting done and mark the ticket's acceptance criteria / status.
- **Done when:** All tickets are implemented and every ticket's test suite passes.

### Phase 3: Full Verification & Live Browser QA (Subagent — QA)
Dispatch a fresh `self` subagent to:
1. Run the full test suite, typecheck, and linter across backend and frontend.
2. If the project has a Web UI, run a real browser check (`webapp-testing` Playwright script or the `browser` subagent against a local dev/preview server) across desktop and mobile viewports to verify rendered layout, key user flows, and zero console/runtime errors.
3. Fix any runtime or layout failures discovered before moving on.
- **Done when:** Full tests, typechecks, production build, and live UI verification pass after the final edit.

### Phase 4: Dual-Axis Code Review & Final Summary (Subagent — Reviewer)
1. Run `code-review` (Standards + Spec) against the baseline commit (plus `web-design-guidelines` if UI was modified).
2. If any hard standard violations, missing spec requirements, or high-impact issues are found, dispatch one fresh fixer subagent to resolve them and re-run verification (`verification-before-completion`).
3. Report to the user concisely: what was built, file/artifact pointers (`DESIGN.md`, `spec.md`, `issues/`), exact test/build commands run and their observed results, and any manual next steps (such as filling `.env` secrets).
