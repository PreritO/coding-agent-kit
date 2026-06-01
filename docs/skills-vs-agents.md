# Skills vs. Agents vs. Commands — the mental model

AI coding harnesses (Claude Code, Codex, and friends) give you three extension primitives. They're easy to confuse, and using the wrong one is the most common reason a setup feels bloated and slow. Here's the model this kit is built on.

## The three primitives

| Primitive | What it is | Analogy | Lives in |
|-----------|------------|---------|----------|
| **Skill** | A *passive* reference document the agent loads on demand for domain knowledge. It does not act. | A reference manual on the shelf | `.claude/skills/<name>/SKILL.md` |
| **Agent** (subagent) | An *active* worker you delegate a task to. It has its own tools and its own context window. | A specialist colleague you hand a ticket | `.claude/agents/<name>.md` · `.codex/agents/<name>.toml` |
| **Command** (slash command) | A reusable *prompt/playbook* you trigger by name. It orchestrates skills and agents. | A runbook you execute | `.claude/commands/<name>.md` |

```
  YOU ──▶ /command ──▶ delegates to ──▶ Agent (active worker, own tools)
                                            └── loads ──▶ Skill (reference doc)
```

- A **command** says *what to do, in what order* (e.g. `/verify` runs tests, then asks `reviewer`).
- An **agent** *does* the work in an isolated context so it doesn't pollute your main thread.
- A **skill** *informs* the work with knowledge the agent would otherwise lack.

### Rules of thumb

- **Reaching for tools and editing files?** → Agent.
- **Encoding knowledge ("how our auth works", "Remotion gotchas")?** → Skill.
- **A repeatable sequence you run by name?** → Command.
- If a "skill" tells the agent to *go run* something, it's really a command or agent. If a "command" is just facts with no steps, it's really a skill.

## The context tax

> Every skill you install costs tokens on **every** turn it's eligible to load — whether or not it fires.

Skill descriptions sit in the model's context so it can decide when to use them. Install 30 skills and you pay a standing tax in tokens, latency, and — worse — *misfires*, where a broad skill triggers on an irrelevant task and derails the run.

The widely-shared community finding (a "tested 30 skills for a week" audit that circulated in late 2025 / early 2026) lands on a simple heuristic:

- **Keep your active skill set to ~8–12.** Junior setups hoard skills; senior setups prune.
- **Favor skills that save measurable time daily** (TDD discipline, systematic debugging, code review, document generation) over **meta-skills and broad orchestrators** that rarely earn their context cost.
- **Vet before you install:** read the `SKILL.md`, check the author and the star count, and confirm the trigger conditions are *narrow*.
- **Prune on a schedule.** If a skill hasn't fired in weeks, remove it.

This is why `coding-agent-kit` is curated rather than exhaustive: a tight core loop you actually use beats a junk drawer of 30 skills. Layer on specialized skills deliberately — see [`recommended-community-skills.md`](recommended-community-skills.md).

## Why agents don't pay the same tax

A subagent runs in its **own** context window and returns only a summary. So delegating a big search or a noisy build-fix to an agent *protects* your main thread instead of taxing it. That's the whole point of the roster in [`../claude/agents`](../claude/agents): push heavy, context-hungry work (codebase exploration, review sweeps, test runs) into agents and keep your primary conversation clean.

## Putting it together

A typical feature in this kit:

```
/plan          → architect agent explores; you approve a plan file
/implement     → code written against the plan; tests as you go
/verify        → test-runner + reviewer + security-reviewer agents run
/commit-push-pr
```

Commands sequence it, agents do the heavy lifting in isolation, and skills (yours + a curated few community ones) supply the domain knowledge — without drowning the context.
