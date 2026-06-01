<!--
  AGENTS.md — a cross-harness instructions template.

  WHY THIS FILE: AGENTS.md is the open, cross-tool standard (https://agents.md)
  read by OpenAI Codex and most coding agents. Keep your DURABLE project rules
  here — not in a long always-loaded prompt.

  USE IT:
    1. Copy this file to the root of your project as AGENTS.md.
    2. Let Claude Code read the same rules without duplicating them:
         ln -s AGENTS.md CLAUDE.md
    3. Fill in the bracketed sections. Keep it a TABLE OF CONTENTS — short
       policy + links out, not a manual. Detail lives in the linked files and
       in your /commands and skills, which load on demand.

  PRINCIPLES (see docs/agent-workflow-principles.md):
    • Minimal & durable: constraints and conventions, not step-by-step prose.
    • First-person framing reads better to models ("I will…", below).
    • Link out with plain Markdown links so detail loads only when needed.
    • Don't rely on this file reloading mid-session — enforce the must-nots
      with hooks (formatters, linters, pre-commit) where it actually matters.
  Delete this comment block before committing.
-->

# [Project name]

I will follow the instructions in this file. When something here conflicts with a
more specific file closer to the code I'm editing, the more specific file wins.

## What this project is
[One or two sentences: what it does, who it's for.]

## Stack & layout
- **Language / framework:** [e.g. TypeScript + Next.js, Python + FastAPI]
- **Package manager / runtime:** [e.g. pnpm, uv]
- **Key directories:**
  - `[src/…]` — [what lives here]
  - `[tests/…]` — [test location + framework]

## Build, test, run
```bash
[install]      # e.g. pnpm install
[dev]          # e.g. pnpm dev
[test]         # e.g. pnpm test  /  pytest
[lint]         # e.g. pnpm lint && pnpm typecheck
```
Always run `[test]` and `[lint]` before considering a change done.

## Conventions
- [Naming, formatting, error-handling, commit-message conventions.]
- [Patterns to follow; link to an example file: `[path/to/exemplar]`.]

## Guardrails — I will NOT
- [ ] Commit secrets, tokens, or `.env*` files.
- [ ] Touch [generated code / migrations / vendored dirs] by hand.
- [ ] [Project-specific hard rule.]
> Enforce the critical ones with a pre-commit hook — a model can ignore prose, not a hook.

## Workflow
- Plan before non-trivial work; implement only after the plan is agreed. (This
  repo ships `/plan → /refine → /implement → /verify` — see `.claude/commands/`.)
- Delegate isolated, context-heavy work (codebase exploration, review, test
  triage) to subagents in `.claude/agents/` (or `.codex/agents/`).

## More context (load on demand)
- [Architecture](./[docs/architecture.md])
- [API / data model](./[docs/api.md])
- [Contributing](./[CONTRIBUTING.md])
