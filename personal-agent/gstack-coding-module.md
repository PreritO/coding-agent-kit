# Optional: the "text-it-to-code" superpower (gstack)

This is the piece that turns your personal agent into the *full* Garry rig: text OpenClaw
a coding task → it spawns a **Claude Code** session running **gstack** discipline → it
reports a **PR** back in the chat. You never leave Telegram.

> Verify against the live integration doc on your machine:
> `~/.claude/skills/gstack/docs/OPENCLAW.md` (this summarizes it).

## Auth reality (important)
The conversational brain can be ChatGPT Pro, **but the spawned coding sessions are Claude
Code — they need their own Anthropic auth.** Cleanest is a dedicated **Anthropic API key**.
(Claude Pro/Max via `claude -p` is allowed again and gets a monthly "Agent SDK credit" from
**Jun 15, 2026**, but an API key is the most predictable for an always-on box.) **ChatGPT
Pro cannot drive the coding part.**

## How it works
gstack integrates with OpenClaw as *methodology injected via prompt*, not ported code.
OpenClaw spawns a native Claude Code session (via ACP) and decides how much gstack to apply:

| Tier | When | What's injected |
|------|------|-----------------|
| Simple | one-file edits, typos | nothing |
| Medium | multi-file, obvious approach | `gstack-lite` (5-line plan→implement→self-review) |
| Heavy | you name a skill (`/review`, `/qa`) | "Load gstack. Run /X" |
| Full | a real feature/project | `gstack-full` (autoplan → implement → ship a PR) |
| Plan | "plan this for Claude Code" | `gstack-plan` (review gauntlet, no code) |

## Setup
1. **Install gstack for Claude Code on the VPS** (so spawned sessions have it):
   ```bash
   git clone https://github.com/garrytan/gstack ~/.claude/skills/gstack
   cd ~/.claude/skills/gstack && ./setup
   ```
   Make sure Claude Code on the box is authenticated with your **Anthropic API key**.
2. **Tell your OpenClaw agent:** `install gstack for openclaw`. It will:
   - install the `gstack-lite` template into its coding-session spawn prompts,
   - install the 4 native methodology skills from ClawHub:
     ```bash
     clawhub install gstack-openclaw-office-hours
     clawhub install gstack-openclaw-ceo-review
     clawhub install gstack-openclaw-investigate
     clawhub install gstack-openclaw-retro
     ```
   - add the dispatch-routing section to your OpenClaw `AGENTS.md` (the ready-to-paste block
     lives at `~/.claude/skills/gstack/openclaw/agents-gstack-section.md`),
   - set `OPENCLAW_SESSION=1` on spawned sessions (so gstack runs non-interactively).
3. **Test it from Telegram:** text `use gstack to plan a small feature in <your-repo>` and
   confirm it spawns a session and reports back. Then try a Full-tier task and check the PR.

## Keep it safe
- Coding sessions still obey your [`SECURITY.md`](SECURITY.md) hardening (sandbox, no exposed port).
- Per the persona in [`AGENTS.md`](AGENTS.md): the agent opens a **PR for review** — it never
  pushes to main or deploys on its own.
- Scope which repos it may touch; don't point it at anything you can't review.
