# Codex setup

This kit ships the same agent roster for **OpenAI Codex** that it does for Claude Code — write a role once, run it in either CLI.

## Agents

`codex/agents/*.toml` are the Codex equivalents of `claude/agents/*.md`. Each file looks like:

```toml
description = "One-line summary used to decide when to delegate to this agent."
developer_instructions = """
# Agent Title
...the agent's full instructions (Markdown)...
"""
name = "agent-name"
```

Install them into a project with the repo's [`install.sh`](../install.sh) (it copies them to `.codex/agents/`), or place them under `~/.codex/agents/` to make them global.

The roster: `architect`, `reviewer`, `simplifier`, `security-reviewer`, `test-runner`, `build-validator`, `build-error-resolver`, `tdd-guide`. See [`../claude/agents`](../claude/agents) for the matching Claude versions and what each one does.

## MCP servers & secrets

[`config.example.toml`](config.example.toml) is a template for wiring up MCP servers (Linear, Render, Vercel shown as examples).

**Handle secrets correctly:**

- Copy the template to your real config (`~/.codex/config.toml` for global, or `.codex/config.toml` for a single project).
- The real `config.toml` is **gitignored** by this kit so a token can't be committed by accident.
- Never hardcode an API token in a committed file. Inject it from your environment or a secret manager at runtime.

> If you previously committed a token anywhere, **rotate it** — git history keeps old values even after you delete them.
