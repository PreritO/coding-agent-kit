# Agent workflow principles (and what to be skeptical of)

The hard-won techniques behind this kit — distilled from the people who build these tools (Anthropic's Claude Code team, OpenAI's Codex docs), respected independent practitioners (Simon Willison, Hamel Husain), and a lot of skeptical Hacker News discussion. Where a claim has *evidence*, it's cited; where the community is *divided*, that's flagged too. The point isn't to add more skills — it's to use the ones you have well.

## Principles that show up everywhere

1. **Separate planning from execution.** The single most-endorsed technique across HN and Anthropic's own guidance. Plan first (in plan mode / a plan file), get the plan reviewed, *then* implement. Reported 2–10× gains come **only** with a detailed plan plus rigorous review — not from "just let it code." This kit's `/plan → /refine → /implement → /verify` loop exists for exactly this.

2. **Run multiple worktrees in parallel.** The Claude Code team calls 3–5 git worktrees — one agent session each — their "single biggest productivity unlock." Independent tasks don't share context; let them run concurrently instead of serializing.

3. **Put guardrails in deterministic hooks, not agent memory.** Don't *ask* the agent to remember to run the formatter/linter — wire it into a `PostToolUse`/pre-commit hook so it's *forced* to. Agents regularly ignore even explicit `CLAUDE.md` instructions; a hook can't be ignored.

4. **Use feedback loops and keep context lean.** Give the agent something to check itself against — tests, screenshots, type-checks, a verification step. Keep working context around **30–40%** of the window; quality degrades as it fills.

5. **Task-scoped subagents beat persona subagents.** Delegate by *task* ("review this diff for security issues", "run the tests and triage failures"), not by *role-play* ("you are a senior architect"). HN's blunt version: "personas produce theater, not utility." Subagents shine for research-heavy gathering, parallel independent work, unbiased review, and pre-commit verification — and are **weak** for sequential dependent work, multiple agents editing one file, or sustained refactoring on a large brownfield codebase.

6. **If you do something more than once a day, make it a command or skill.** That's the bar for promoting an ad-hoc prompt into a reusable `/command` or skill. Below that bar, it's just context tax.

7. **First-person framing lands better than imperative.** In Vercel's evals, *"I will follow the instructions in AGENTS.md"* scored 3/3 where *"Follow the instructions…"* scored 0/3. Phrase durable rules as the agent's own commitments.

8. **Treat `AGENTS.md`/`CLAUDE.md` as a table of contents.** Keep it minimal — policy and constraints — and link out to detail files with plain Markdown links (not `@`-imports) so they load only on demand. Drive day-to-day behavior through commands and skills, not a giant always-loaded doc.

## What the evidence says about skills

- **Human-curated skills help; self-generated ones can hurt.** *SkillsBench* (arXiv) measured human-written skills at **+16.2pp** and model-self-generated skills at **−1.3pp** — i.e. net-negative. The takeaway: skills earn their keep when they encode **external research or domain expertise the model doesn't already have**, not when the model writes notes to itself about things it already knows.
- **Generate skills *after* a task, not before.** The reliable pattern is to encode what you learned (a failure mode, a domain quirk, a project convention) *once you've hit it* — then it's real knowledge, not speculation.
- **Skills can rival MCP servers at a fraction of the cost.** Simon Willison's point: a lightweight `SKILL.md` often replaces a heavyweight MCP server. Top MCP servers each cost 10–30k tokens of standing context (GitHub MCP: 39 tools / ~30k tokens — many users disable it and use the `gh` CLI instead).

## Known failure modes — stay skeptical

These are real, repeatedly reported, and worth designing around:

- **Skills don't reliably fire.** Even with a good `description`, a skill may simply not trigger — and models drop skill files when context gets cluttered. Don't assume a skill ran; verify the output.
- **`AGENTS.md`/`CLAUDE.md` don't reliably *reload*.** They're read on initial load; as context grows the agent often won't re-read them and quietly loses the rules. Reinforce critical constraints with hooks (principle 3).
- **Context bloat is the silent killer.** Every installed skill, MCP server, and always-loaded doc costs tokens whether or not it's used. Audit periodically; prune aggressively. (See the [context tax](skills-vs-agents.md).)
- **Subagents fly partly blind.** They don't inherit the full system prompt/context, so they're poor at refactoring and sustained feature work, and each attempt costs real money ($1–5). Use them where isolation *helps* (review, triage, search), not where continuity matters.
- **Beware cargo-cult ROI claims.** Most "10× with this skill" posts are non-falsifiable vibes (and often vendor lead-gen). Prefer A/B evals on your own repo over influencer rankings.
- **Avoid lock-in.** A `CLAUDE.md`-only setup ties your project to one harness. Keep durable rules in `AGENTS.md` and symlink: `ln -s AGENTS.md CLAUDE.md`. See [`../templates/AGENTS.md`](../templates/AGENTS.md).

## Sources

- Claude Code team workflow tips (Boris Cherny) — worktrees, plan-mode review, `PostToolUse` formatter hooks, "make repeated tasks into skills".
- Anthropic — [Subagents in Claude Code](https://claude.com/blog/subagents-in-claude-code) (when to use / when not to).
- OpenAI Codex docs — [best practices](https://developers.openai.com/codex/learn/best-practices), [AGENTS.md guide](https://developers.openai.com/codex/guides/agents-md), [skills](https://developers.openai.com/codex/skills).
- Simon Willison — [Superpowers](https://simonwillison.net/2025/Oct/10/superpowers/), notes on skills vs MCP.
- Hacker News — "Separation of planning and execution" ([47106686](https://news.ycombinator.com/item?id=47106686)), "Claude Code as a Daily Driver" ([48289950](https://news.ycombinator.com/item?id=48289950)), subagents thread ([45181577](https://news.ycombinator.com/item?id=45181577)), Vercel "AGENTS.md vs skills" eval + critique ([46809708](https://news.ycombinator.com/item?id=46809708)), SkillsBench ([47040430](https://news.ycombinator.com/item?id=47040430)).

*These are field observations from 2025–2026, not laws. The tools move fast — re-test against your own workflow.*
