# Autopilot Workflows

Custom orchestrator plugin that gives the agent an automatic workflow router (`rules/AGENTS.md`) plus single-command pipelines (`/autopilot-build` and `/autopilot-ui-fix`) backed by fresh subagent contexts.

## Components

- `rules/AGENTS.md`: Always-on lightweight workflow router so the agent immediately knows which skills and workspace docs (`GLOSSARY.md`, `DESIGN.md`, `docs/adr/`, `.scratch/`) to use.
- `/autopilot-build`: Full 0 → finish pipeline (`GLOSSARY.md` / ADRs → `DESIGN.md` → `spec.md` & vertical-slice tickets → TDD frontier implementation → Playwright/browser QA → dual-axis `code-review`).
- `/autopilot-ui-fix`: Existing-UI overhaul pipeline (Git baseline → `antislop` After audit + `DESIGN.md` via `frontend-design` → systematic UI refactor with `antislop` During & Vercel React guidelines → browser QA → `code-review`).
