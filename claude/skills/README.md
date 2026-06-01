# Skills

**Skills** are passive reference documents an agent loads on demand for domain knowledge — see [`../../docs/skills-vs-agents.md`](../../docs/skills-vs-agents.md) for how they differ from agents and commands.

This kit is intentionally light on skills (skills are usually project- or domain-specific, and every installed skill costs context — the "context tax"). Instead, this folder shows you the **format** so you can author your own, and points you to vetted community skills for the rest.

## Anatomy of a skill

A skill is a directory containing a `SKILL.md` with YAML frontmatter:

```
.claude/skills/
└── my-skill/
    ├── SKILL.md          # required: frontmatter + when/how to use
    └── rules/            # optional: detailed reference files loaded on demand
        └── topic.md
```

### Minimal template

```markdown
---
name: my-skill
description: One sharp sentence describing exactly when this skill applies. The
  agent reads this to decide whether to load the skill, so make the trigger
  narrow and concrete — vague descriptions cause misfires.
---

## When to use

Use this skill when <specific, narrow condition>. Do NOT use it for <common
near-miss> — that keeps it from firing on the wrong tasks.

## Key knowledge

The domain facts, conventions, gotchas, and patterns the agent needs. Be
specific and example-driven. This is reference material, not a task list — a
skill informs work, it doesn't perform it.

## Detailed references (optional)

For deep topics, keep `SKILL.md` short and link out so the agent only pulls in
what it needs:

- [rules/topic-a.md](rules/topic-a.md) — when handling topic A
- [rules/topic-b.md](rules/topic-b.md) — when handling topic B
```

## Authoring tips

- **Narrow the trigger.** The `description` is the whole budget the model uses to decide. "Best practices for Remotion video code" is good; "frontend stuff" will misfire constantly.
- **Keep `SKILL.md` lean; link out for depth.** Put the decision logic up top and push long reference material into `rules/*.md` that load only when relevant. This keeps the standing context cost low.
- **One skill, one domain.** Don't bundle unrelated knowledge.
- **Prune.** If a skill hasn't fired in weeks, remove it.

## Don't reinvent — borrow vetted skills

Before writing a skill, check whether a good one already exists. The official `skill-creator` (in [`anthropics/skills`](https://github.com/anthropics/skills)) scaffolds new skills for you, and the curated list in [`../../docs/recommended-community-skills.md`](../../docs/recommended-community-skills.md) covers testing, debugging, docs, frontend, and browser QA.
