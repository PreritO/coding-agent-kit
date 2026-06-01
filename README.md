# coding-agent-kit

A portable, battle-tested toolkit for AI coding agents — **Claude Code** and **OpenAI Codex** — distilled from real production projects into a clean, **stack-agnostic** starter kit.

It gives you a disciplined **plan → implement → verify** workflow, a roster of specialist subagents (Claude *and* Codex), and a curated guide to the best community skills — without the "context tax" of installing 30 skills you'll never use.

> Drop it into any repo, get a senior-engineer workflow on day one.

---

## What's inside

| Path | What it is |
|------|------------|
| [`claude/commands/`](claude/commands) | Slash commands for the core dev loop — `/plan`, `/refine`, `/implement`, `/verify`, `/code-review`, `/tdd`, `/test`, `/init-tests`, `/build-fix`, `/commit-push-pr`, `/workflow` |
| [`claude/agents/`](claude/agents) | Specialist subagents — `architect`, `reviewer`, `simplifier`, `security-reviewer`, `test-runner`, `build-validator`, `build-error-resolver`, `tdd-guide` |
| [`claude/skills/`](claude/skills) | How to author your own skills (format + template) |
| [`codex/agents/`](codex/agents) | The **same** agent roster as Codex `.toml` agents — one roster, both CLIs |
| [`codex/`](codex) | Codex `.toml` agents, a templated MCP config, and [how Codex loads custom instructions](codex/README.md) (`AGENTS.md` / prompts / skills / agents) |
| [`templates/`](templates) | A cross-harness [`AGENTS.md`](templates/AGENTS.md) starter (works for Codex + Claude via one symlink) |
| [`docs/`](docs) | The [skills-vs-agents model](docs/skills-vs-agents.md), the [agent-workflow principles](docs/agent-workflow-principles.md) (evidence-backed techniques + what to be skeptical of), and a [curated, verified list of the best community skills](docs/recommended-community-skills.md) |

---

## Quick start

From inside the project you want to equip:

```bash
git clone https://github.com/PreritO/coding-agent-kit
./coding-agent-kit/install.sh            # installs into the current directory
# or target another project:
./coding-agent-kit/install.sh /path/to/your/project
```

The installer copies `claude/` into your project's `.claude/` and `codex/` into `.codex/` (it never overwrites files you already have). Prefer symlinks so the kit stays in sync? Run `MODE=symlink ./install.sh`.

Then, inside Claude Code:

```
/workflow          # see the recommended loop
/plan add user avatars
```

---

## The inner loop

The kit encodes one opinionated, plan-first loop (inspired by Boris Cherny's approach):

```
/plan ──▶ /refine (iterate) ──▶ /implement ──▶ /verify ──▶ /commit-push-pr
                                      │
                                      └─ /code-review, /tdd, /test as needed
```

1. **`/plan`** — enter plan mode, clarify requirements, explore the codebase with the `architect` agent, and write a plan file to `.claude/plans/` with tests defined up front. **No code is written until you approve.**
2. **`/refine`** — iterate on the plan until it's right.
3. **`/implement`** — execute the approved plan, writing tests as you go.
4. **`/verify`** — run the suite, check every success criterion, and run a `reviewer` + `security-reviewer` pass.
5. **`/commit-push-pr`** — clean commit message, pushed branch, and a linked PR.

See [`claude/commands/workflow.md`](claude/commands/workflow.md) for the full guide (including backend-only and bug-fix tracks).

---

## Philosophy: skills vs agents, and the context tax

- **Skills** = passive reference docs loaded on demand (domain knowledge).
- **Agents** = active workers you delegate to (they have their own tools and context).
- **Commands** = orchestrate both.

Every installed skill costs tokens **whether or not it fires**. The community lesson (see the [recommended-skills guide](docs/recommended-community-skills.md)) is to keep your *active* set lean — roughly **8–12 skills**, not 30. This kit is deliberately curated, not exhaustive. Read [`docs/skills-vs-agents.md`](docs/skills-vs-agents.md) for the mental model.

---

## Works with both Claude Code and Codex

The agent roster is mirrored: `claude/agents/<name>.md` (Markdown + YAML frontmatter) and `codex/agents/<name>.toml` (Codex format). Write a role once, run it in either CLI. See [`codex/README.md`](codex/README.md).

---

## Community skills worth adding on top

This kit is the *core loop*. For specialized power, layer on the best of the community — see the [curated, verified list](docs/recommended-community-skills.md) (every star count / license / freshness checked against the GitHub API). Highlights:

- [`anthropics/skills`](https://github.com/anthropics/skills) + [`openai/skills`](https://github.com/openai/skills) — the official Claude and Codex skill catalogs (incl. vendor skills from Trail of Bits, Vercel, Stripe…).
- [`obra/superpowers`](https://github.com/obra/superpowers) — the dominant community framework (TDD, systematic debugging, planning, git worktrees).
- [`trailofbits/skills`](https://github.com/trailofbits/skills) — template-grade security/testing skills; [`backnotprop/plannotator`](https://github.com/backnotprop/plannotator) — visual plan review; [`garrytan/gstack`](https://github.com/garrytan/gstack) — headless-browser QA (provides `/qa`, `/plan-ceo-review`, referenced by `/workflow`).

**Before you install a pile of skills,** read [`docs/agent-workflow-principles.md`](docs/agent-workflow-principles.md) — the evidence-backed techniques (plan-first, worktrees, hooks-as-guardrails) and the failure modes to design around (skills don't always fire, self-generated skills can *hurt*, context bloat is real).

---

## License

[MIT](LICENSE) — use it, fork it, adapt it.
