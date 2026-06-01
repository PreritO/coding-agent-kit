# Recommended community skills & setups

A curated, opinionated shortlist of the best community skills/agents/commands to layer on top of this kit's core loop — for **both Claude Code and OpenAI Codex**. The guiding principle is the **context tax** (see [`skills-vs-agents.md`](skills-vs-agents.md)): install deliberately, keep your active set to ~8–12, and prefer official + well-vetted sources over high-star "awesome lists" (which are *indexes*, not vetted bundles).

> **Verification:** every star count, license, and "last pushed" date below was checked directly against the GitHub API on **2026-05-31**. Numbers drift — treat them as a signal, not a guarantee. **Always read a skill's `SKILL.md` before installing.** A high star count often just means a catchy README; some 100k★ repos are a single Markdown file.

---

## Start here — official + foundation

| Repo | ⭐ | License | What | Install |
|------|---:|---------|------|---------|
| [anthropics/skills](https://github.com/anthropics/skills) | ~145k | MIT | **Official** Claude skills: document gen (PDF/DOCX/XLSX/PPTX), `webapp-testing`, `mcp-builder`, `skill-creator`, `frontend-design` | `/plugin marketplace add anthropics/skills` |
| [openai/skills](https://github.com/openai/skills) | ~21k | — | **Official** Codex skills catalog; aggregates *vendor-authored* skills (Trail of Bits, Vercel, Stripe, Cloudflare, Sentry, Figma, Expo, Hugging Face) | Browse → copy into Codex skill dir |
| [obra/superpowers](https://github.com/obra/superpowers) | ~214k | — | The dominant skills *framework*: TDD, systematic-debugging, brainstorming, writing-plans, subagent-driven-dev, requesting-code-review, git-worktrees. Endorsed by Simon Willison. Works on Claude Code, Codex, Gemini, Cursor, OpenCode. | `/plugin install superpowers@claude-plugins-official` |
| [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) | ~29k | — | Anthropic-curated directory of vetted plugins | `/plugin marketplace add anthropics/claude-plugins-official` |
| [agentsmd/agents.md](https://github.com/agentsmd/agents.md) | ~22k | MIT | The **official `AGENTS.md` spec** — the cross-tool format Codex (and most agents) read for project instructions | Reference / template |

> ⚠️ A note on `superpowers`: it's the strongest single pick, but it's also the most-*debated* on HN — several heavy users removed it for burning >50k tokens of standing context. Install it, then prune what doesn't earn its keep.

---

## By category (new, verified picks)

These complement — not duplicate — this kit's built-in `reviewer`, `security-reviewer`, and plan→implement→verify loop.

### Testing & security
- **[trailofbits/skills](https://github.com/trailofbits/skills)** — 5.5k★, CC-BY-SA-4.0, active. A security firm's ~40 plugins: property-based testing, mutation testing, Semgrep/CodeQL, fuzzing handbook (asan/aflpp/atheris/cargo-fuzz), differential review. **The best non-Anthropic source of *template-grade* `SKILL.md` files** (clear triggers, "when NOT to use", decision trees). `/plugin marketplace add trailofbits/skills`. *(Also surfaced via `openai/skills`.)*
- **[hashicorp/agent-skills](https://github.com/hashicorp/agent-skills)** — 644★, MPL-2.0, official. Terraform + Packer IaC skills — narrow but authoritative. `/plugin marketplace add hashicorp/agent-skills`.

### Code review
- **[hamelsmu/claude-review-loop](https://github.com/hamelsmu/claude-review-loop)** — 678★. An automated review loop that uses **Codex as an adversarial second reviewer** until clean — a clean cross-model pattern, from a well-regarded ML practitioner. *(No license; not pushed since 2026-03.)*

### Planning & spec
- **[backnotprop/plannotator](https://github.com/backnotprop/plannotator)** — 5.7k★, Apache-2.0. Visual plan review — annotate/approve a plan before execution. Repeatedly cited in HN's top "plan-first" threads; pairs with this kit's `/plan`.
- **[OthmanAdi/planning-with-files](https://github.com/OthmanAdi/planning-with-files)** — 22k★, MIT. Persistent Markdown planning (`task_plan.md`/`findings.md`/`progress.md`) that **survives `/clear` and context resets**. Real engineering (130+ tests, published evals) under heavy marketing framing.

### Browser QA / web testing
- **[microsoft/playwright-mcp](https://github.com/microsoft/playwright-mcp)** — 33k★, Apache-2.0. The official Playwright MCP — drive a real browser for UI testing. (HN's caveat: ~10k-token tool overhead — load it only when testing.)
- **[lackeyjb/playwright-skill](https://github.com/lackeyjb/playwright-skill)** — 2.7k★, MIT. A lighter model-invoked Playwright *skill*. *(Stale since 2025-12 — verify before relying on it.)*
- See also **[garrytan/gstack](https://github.com/garrytan/gstack)** — the headless-browser QA pack this kit already references in `/workflow`.

### Git, review & meta-skills
- **[NeoLabHQ/context-engineering-kit](https://github.com/NeoLabHQ/context-engineering-kit)** — 1.1k★, **GPL-3.0**, active. Hand-crafted plugins: `git` (worktrees/PR/commit), `review`, `reflexion`, `kaizen` (5-whys root-cause), plus skill-authoring meta-skills (`create-skill`, `test-skill`, `agent-evaluation`). Multi-harness with published accuracy evals. *(GPL limits redistribution — link, don't copy.)*

### Platform-specific
- **[CharlesWiltgen/Axiom](https://github.com/CharlesWiltgen/Axiom)** — 942★, MIT, very active. Apple-platform (iOS/iPadOS/watchOS/tvOS) skills + diagnostic tooling; claims TDD-tested against real failure scenarios. The standout Apple suite.

---

## Cross-harness: one source, both Claude + Codex

- **[wshobson/agents](https://github.com/wshobson/agents)** — 36k★, MIT. Emits *harness-native* artifacts for Claude **and** Codex (`.codex/skills/`, `.codex/agents/`, respects Codex's skill-size cap). 191 agents / 155 skills / 102 commands. Big surface — audit the subset you need. `npx codex-marketplace add wshobson/agents`.
- **[runkids/skillshare](https://github.com/runkids/skillshare)** — 2.1k★, MIT, active. One-command skill sync across CLIs (Codex/Claude/OpenClaw+). The cleanest "keep one source in sync everywhere" utility.

(For more Codex-specific resources and the exact directory mechanics, see [`../codex/README.md`](../codex/README.md).)

---

## Template-grade examples to study

When authoring your own skill/command/agent, read these first — they're the cleanest references:

- **`trailofbits/skills`** `property-based-testing` / `mutation-testing` `SKILL.md` — exemplary frontmatter, narrow triggers, "when NOT to use", decision-tree routing to modular reference files.
- **[datasette/skill](https://github.com/datasette/skill)** — Simon Willison's tiny worked example of "a lightweight skill beats a full MCP server." (12★ — it's an *example*, not a popularity pick.)
- **[EveryInc/claude_commands](https://github.com/EveryInc/claude_commands)** — 510★. Six tasteful, focused slash commands (experiment-driven dev, generate-codebase-context, resolve-PR-comments) — a good *command-authoring* template. *(No license; not updated since 2025-11.)*
- This kit's own [`claude/agents/reviewer.md`](../claude/agents/reviewer.md) and [`claude/commands/plan.md`](../claude/commands/plan.md).

---

## Install mechanics

- **Plugin marketplaces (recommended):** in Claude Code, `/plugin marketplace add <owner>/<repo>` then `/plugin install <pack>@<marketplace>`. Updates are managed for you.
- **Manual drop-in (Claude):** copy a skill folder into `.claude/skills/<name>/` (project) or `~/.claude/skills/<name>/` (global); copy a subagent `<name>.md` into `.claude/agents/`.
- **Codex:** see [`../codex/README.md`](../codex/README.md) for the exact paths (`.agents/skills/`, `~/.codex/prompts/`, `.codex/agents/*.toml`, `config.toml`).
- **CLI installer:** `npx claude-code-templates@latest` ([davila7/claude-code-templates](https://github.com/davila7/claude-code-templates), ~28k★) to browse/install components *and audit your config* so you stay under the context-tax ceiling.

After installing anything: **prune.** If a skill hasn't fired in weeks, remove it.

---

## Skip list — popular but thin (don't be fooled by the star count)

- **Mega grab-bags** advertising hundreds/thousands of skills (e.g. "337 skills / 30 agents / 70 commands", "425 plugins / 2,810 skills") — classic quantity-over-quality; auto-aggregated, low signal.
- **`multica-ai/andrej-karpathy-skills`** (~164k★) — despite the stars, it's *one* `CLAUDE.md` file of (sensible) defaults, "inspired-by" Karpathy, **not official**. Read it and crib the four rules; don't expect a skill suite.
- **Novelty virals** — "talk like a caveman to save tokens", prose "humanizers", etc. Fun, off-mission for an engineering toolkit.
- **`rNN-*` derivative repos** — auto-generated spam farms that fork other lists. Avoid.
- **The "X Best Claude Skills in 2026" listicle farm** — near-identical SEO posts (often vendor lead-gen) recycling the same handful of repos and quoting *stale* star counts. Useful at most as a discovery index; not independent signal.
- **Index/"awesome" lists** ([hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code), [ComposioHQ/awesome-claude-skills](https://github.com/ComposioHQ/awesome-claude-skills), [VoltAgent/awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents)) — fine for *discovery*, but high stars ≠ per-item quality. Verify each item.

---

*Methodology: candidates surfaced via GitHub search, Hacker News (Algolia), and practitioner blogs/X, then star counts/licenses/freshness verified live against the GitHub API on 2026-05-31. See [`agent-workflow-principles.md`](agent-workflow-principles.md) for the hard-won techniques (and skepticism) behind these picks.*
