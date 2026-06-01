# Codex setup

This kit ships the same agent roster for **OpenAI Codex** that it does for Claude Code — write a role once, run it in either CLI.

## How Codex loads your customizations

Codex has four extension points. Knowing exactly where each lives is half the battle (paths from the official docs at [developers.openai.com/codex](https://developers.openai.com/codex), verified 2026-05-31):

| Mechanism | Where it lives | Notes |
|-----------|----------------|-------|
| **Instructions** (`AGENTS.md`) | `~/.codex/AGENTS.md` (global) + every dir from git root down to cwd | Concatenated root-first; **closer-to-cwd wins**. Default cap ~32 KiB (`project_doc_max_bytes`). The cross-tool standard — see [agents.md spec](https://github.com/agentsmd/agents.md). |
| **Prompts** (slash commands) | `~/.codex/prompts/*.md` | **Top-level files only** (no subdirs). `draftpr.md` → `/prompts:draftpr`. YAML frontmatter (`description:`, `argument-hint:`); args are `$1`–`$9` / `$UPPERCASE`. Restart Codex to reload. Lives in `~/.codex`, so **not** shared via the repo. |
| **Skills** | repo: `.agents/skills/` (+ parents, + `$REPO_ROOT/.agents/skills`); user: `~/.agents/skills/`; admin: `/etc/codex/skills` | One dir per skill with a required `SKILL.md` (same format as Claude — see [agentskills.io](https://agentskills.io)). Invoked via `$skill` / `/skills`, or implicitly by intent. *(Some installers also target `~/.codex/skills`.)* |
| **Subagents** | `~/.codex/agents/*.toml` (personal) or `.codex/agents/*.toml` (project) | One TOML per agent. Required: `name`, `description`, `developer_instructions`; optional `model`, `model_reasoning_effort`, `sandbox_mode`, `mcp_servers`. **This is what this kit ships in [`agents/`](agents).** |
| **Config + MCP** | `~/.codex/config.toml` (global) / `.codex/config.toml` (project) | Settings, profiles, and MCP server definitions. Root→cwd precedence. |

> Because the **same `SKILL.md` format** now works in both Claude Code and Codex, a single skill library is portable across both — that's why the cross-harness tools below matter.

## Agents (shipped in this kit)

`codex/agents/*.toml` are the Codex equivalents of `claude/agents/*.md`. Each file looks like:

```toml
description = "One-line summary used to decide when to delegate to this agent."
developer_instructions = """
# Agent Title
...the agent's full instructions (Markdown)...
"""
name = "agent-name"
```

Install them with the repo's [`install.sh`](../install.sh) (it copies them to `.codex/agents/`), or place them under `~/.codex/agents/` to make them global.

The roster: `architect`, `reviewer`, `simplifier`, `security-reviewer`, `test-runner`, `build-validator`, `build-error-resolver`, `tdd-guide`. See [`../claude/agents`](../claude/agents) for the matching Claude versions and what each one does.

## MCP servers & secrets

[`config.example.toml`](config.example.toml) is a template for wiring up MCP servers (Linear, Render, Vercel shown as examples).

**Handle secrets correctly:**

- Copy the template to your real config (`~/.codex/config.toml` for global, or `.codex/config.toml` for a single project).
- The real `config.toml` is **gitignored** by this kit so a token can't be committed by accident.
- Never hardcode an API token in a committed file. Inject it from your environment or a secret manager at runtime.

> If you previously committed a token anywhere, **rotate it** — git history keeps old values even after you delete them.

## Codex resources worth referencing

Verified against the GitHub API on 2026-05-31. See [`../docs/recommended-community-skills.md`](../docs/recommended-community-skills.md) for the full cross-harness picture.

| Resource | ⭐ | What | How to use |
|----------|---:|------|-----------|
| [openai/codex](https://github.com/openai/codex) | ~87k | The Codex CLI itself (source of truth for these mechanics) | — |
| [openai/skills](https://github.com/openai/skills) | ~21k | **Official** Codex skills catalog — aggregates *vendor-authored* skills (Trail of Bits, Vercel, Stripe, Cloudflare, Sentry, Figma…) | Browse → copy into a skills dir |
| [agentsmd/agents.md](https://github.com/agentsmd/agents.md) | ~22k | The official **`AGENTS.md` spec** Codex consumes | Reference when writing `AGENTS.md` |
| [wshobson/agents](https://github.com/wshobson/agents) | ~36k | Cross-harness roster that emits **native** `.codex/skills/` + `.codex/agents/` | `npx codex-marketplace add wshobson/agents` |
| [ComposioHQ/awesome-codex-skills](https://github.com/ComposioHQ/awesome-codex-skills) | ~13k | 50+ Codex-native `SKILL.md` skills (no LICENSE — vendor-backed) | Installer → `~/.codex/skills` |
| [VoltAgent/awesome-codex-subagents](https://github.com/VoltAgent/awesome-codex-subagents) | ~5k | 130+ `.codex/agents/*.toml` subagent examples | Drop TOML → `~/.codex/agents` |
| [feiskyer/codex-settings](https://github.com/feiskyer/codex-settings) | ~200 | The most complete end-to-end Codex layout: prompts, skills, 5 `config.toml` provider variants, MCP | Clone into `~/.codex` (reference) |
| [runkids/skillshare](https://github.com/runkids/skillshare) | ~2k | One-command skill sync across Codex/Claude/etc. | Keep one source in sync everywhere |

## Use Codex *and* Claude together (no lock-in)

A common pattern: keep your durable rules in `AGENTS.md`, and symlink so Claude reads the same file —

```bash
ln -s AGENTS.md CLAUDE.md
```

Then this kit's agents run in either CLI from one source of truth. See [`../docs/agent-workflow-principles.md`](../docs/agent-workflow-principles.md) for more on avoiding harness lock-in.
