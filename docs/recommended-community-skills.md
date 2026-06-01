# Recommended community skills & setups

A curated, opinionated shortlist of the best community skills/agents to layer on top of this kit's core loop. The guiding principle is the **context tax** (see [`skills-vs-agents.md`](skills-vs-agents.md)): install deliberately, keep your active set to ~8–12, prefer official and well-vetted sources over high-star "awesome lists" (which are *indexes*, not vetted bundles).

> Star counts verified via the GitHub API on **2026-05-31** and will drift over time. Treat them as a popularity signal, not a quality guarantee — always read a skill's `SKILL.md` before installing.

## The major sources

| Repo | ⭐ (approx) | What it offers | Trust | Install |
|------|-----------:|----------------|-------|---------|
| [anthropics/skills](https://github.com/anthropics/skills) | ~145k | Official skills: PDF/DOCX/XLSX/PPTX document generation, `webapp-testing`, `mcp-builder`, `skill-creator`, `frontend-design` | **Official** | `/plugin marketplace add anthropics/skills` |
| [obra/superpowers](https://github.com/obra/superpowers) | ~214k | The dominant skills *framework*: TDD, systematic-debugging, brainstorming, writing-plans, subagent-driven-dev, requesting-code-review, git-worktrees, verification-before-completion | Community standard (now in the official marketplace) | `/plugin install superpowers@claude-plugins-official` |
| [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) | ~29k | Anthropic-curated directory of vetted Claude Code plugins | **Official** | `/plugin marketplace add anthropics/claude-plugins-official` |
| [wshobson/agents](https://github.com/wshobson/agents) | ~36k | Large multi-harness roster (agents / skills / commands / plugins) from one Markdown source — Claude, Codex, Cursor, OpenCode, Gemini | Community | `/plugin marketplace add wshobson/agents` |
| [davila7/claude-code-templates](https://github.com/davila7/claude-code-templates) | ~28k | 900+ components (agents, commands, MCPs, hooks) + a config/analytics auditor, via CLI | Community | `npx claude-code-templates@latest` |
| [garrytan/gstack](https://github.com/garrytan/gstack) | — | Headless-browser QA daemon + a large skill pack (`/qa`, `/qa-design-review`, `/plan-ceo-review`, `/ship`, `/investigate`, iOS QA, design review). Referenced by this kit's `/workflow`. | Community | `git clone … ~/.claude/skills/gstack && ./setup` |

**Index / "awesome" lists** (useful for discovery, *not* curated bundles — high stars ≠ per-item quality): [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) (~45k), [ComposioHQ/awesome-claude-skills](https://github.com/ComposioHQ/awesome-claude-skills) (~63k), [VoltAgent/awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) (~21k).

## The shortlist — what to actually adopt

Kept near the ~8–12 ceiling and grouped by job. This kit already gives you the plan→implement→verify loop, a reviewer, and a security-reviewer — so the picks below *complement* rather than duplicate it.

**Foundation framework**
1. **superpowers** — installs the whole methodology in one plugin (TDD, debugging, planning, code-review, worktrees, verification). Start here. → `obra/superpowers`

**Testing**
2. **test-driven-development** (superpowers) — RED-GREEN-REFACTOR discipline; consistently the highest-ROI pick in community audits.
3. **webapp-testing** (anthropics/skills) — Playwright-driven browser tests for web apps.

**Debugging**
4. **systematic-debugging** (superpowers) — structured root-cause hunting for flaky/intermittent bugs.

**Browser QA & shipping**
5. **gstack** — `/qa` and `/qa-design-review` for live headless-browser QA, plus `/ship`, `/investigate`, and design review. (This is the source of the optional commands referenced in `/workflow`.)

**Planning**
6. **brainstorming + writing-plans** (superpowers) — turn vague intent into a validated plan before any code. Pairs naturally with this kit's `/plan`.

**Docs / office formats**
7. **document-skills** (anthropics/skills) — generate and extract PDF / DOCX / XLSX / PPTX.

**Frontend / design**
8. **frontend-design** (anthropics/skills) — distinctive, production-grade UI that avoids generic "AI slop" styling.

**Meta / hygiene**
9. **claude-code-templates** (`npx claude-code-templates@latest`) — browse/install components and **audit** your config so you stay under the context-tax ceiling.

## How to install community skills (the mechanics)

- **Plugin marketplaces (recommended):** inside Claude Code, `/plugin marketplace add <owner>/<repo>` then `/plugin install <pack>@<marketplace>`. Updates are managed for you.
- **Manual drop-in:** copy a skill's directory into `.claude/skills/<name>/` (project) or `~/.claude/skills/<name>/` (global). Each skill is a folder with a `SKILL.md`.
- **Subagents:** copy `<name>.md` into `.claude/agents/` (project) or `~/.claude/agents/` (global).
- **CLI installer:** `npx claude-code-templates@latest` for a browsable catalog.

After installing anything, **prune**: remove what you don't use, and re-read [`skills-vs-agents.md`](skills-vs-agents.md) if your sessions start feeling sluggish.

---

*Sourced from the GitHub API (live star counts, 2026-05-31) and community coverage of the "I tested 30 community Claude skills for a week" audit. The original Reddit thread is access-restricted to automated fetchers; the context-tax thesis above is corroborated across secondary coverage rather than quoted first-party.*
