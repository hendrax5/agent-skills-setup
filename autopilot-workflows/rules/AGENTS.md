# Agent Workflow Router

Orient to the active workspace first: if `AGENTS.md`, `GLOSSARY.md`, `DESIGN.md`, `docs/adr/`, or `.scratch/` exist, read the relevant files before planning or editing.

## Route by Intent

- **One-shot full project or feature build** (when the user wants end-to-end execution without step-by-step prompts): read and execute `autopilot-build`.
- **One-shot UI overhaul / "fix slop UI"**: read and execute `autopilot-ui-fix`.
- **Interactive planning & build**: follow `setup-matt-pocock-skills` → `grill-with-docs` → `to-spec` → `to-tickets` → `implement` (or `implement-spec`), keeping `GLOSSARY.md` and `docs/adr/` current.
- **Any frontend / UI task**: align with `DESIGN.md` (create via `frontend-design` if absent), filter with `antislop` (`antislop-ui`, `antislop-human`, `antislop-layoutmobile`), apply `vercel-react-best-practices` + `vercel-composition-patterns` + `web-design-guidelines`, and verify rendered UI with `webapp-testing` or the `browser` subagent.
- **Debugging / regressions**: establish a reproducible failing test or command before proposing fixes (`diagnosing-bugs` / `systematic-debugging`).
- **Existing architecture cleanup**: use `improve-codebase-architecture` + `codebase-design`.

## Completion Gate

Never claim a fix, build, or refactor passes without running the project's real test, typecheck, and build commands after the final edit.
