# Personal agent — the full "Garry rig" (OpenClaw + gbrain + gstack)

A runbook to replicate Garry Tan's setup: an **always-on agent you text** (and dictate to with Wispr Flow), backed by a shared brain, with an optional "text-it-to-code" superpower.

**Core (safe, high-value):**
- **Daily/weekly check-ins** — it messages *you* (morning / evening / weekly) and logs your replies.
- **Capture** — you send meeting notes / todos; it files them as markdown in your Obsidian vault.
- **Recall** — it answers "what did I decide about X?" from your accumulated brain (gbrain).

**Optional (makes it the full rig):**
- **Text it to ship code** — a coding request spawns a Claude Code session running gstack discipline and reports a PR back. See [`gstack-coding-module.md`](gstack-coding-module.md).

**Two providers, on purpose:**
- **Conversational brain** (check-ins/capture/recall): **ChatGPT Pro** via OpenClaw's Codex OAuth. ⚠️ It works, but it's gray-area for 24/7 and rate-capped (a 5h + weekly window *shared with your interactive Codex*) — fine to start, but flip to an **OpenAI API key** when the caps bite (a one-line config change).
- **Coding sessions** (optional module): spawn **Claude Code**, which needs its own **Anthropic** auth (an API key is cleanest). You can't power the coding part with ChatGPT Pro.

> This is a **runbook you execute on your own cloud box** — it needs your VPS, Telegram bot, Supabase, and accounts. Everything here is the map plus ready-to-edit config. Do the [SECURITY](SECURITY.md) steps *before* connecting any channel.

> ⚠️ Config keys below match OpenClaw's **v2026.5.x** docs. OpenClaw moves fast — verify each key against `openclaw --help` / docs.openclaw.ai on your installed version before trusting it.

---

## Architecture (your chosen setup)

```
   YOUR MAC                                  CLOUD VPS (always-on, Tailscale-only)
   ┌────────────────────┐                    ┌─────────────────────────────────────┐
   │ Obsidian (you read/ │   vault sync       │ OpenClaw gateway (daemon)            │
   │ edit notes)         │◄──git / Syncthing─►│  ├─ Telegram channel  ◄── you text   │
   │ Claude Code (coding)│                    │  ├─ cron check-ins  ──► texts you     │
   └─────────┬───────────┘                    │  ├─ workspace = the synced vault      │
             │ MCP                             │  └─ MCP → gbrain                      │
             │                                 └───────────────┬─────────────────────┘
             │                                                 │ MCP
             └───────────────►  gbrain on SUPABASE  ◄──────────┘
                          (one shared brain both sides query)
```

Two things make the "shared brain" work:
1. **gbrain on Supabase** (shared Postgres) — *not* local PGLite — so the cloud agent and your local Claude Code read/write the *same* brain. (Source: gstack `setup-gbrain` skill.)
2. **The Obsidian vault is synced onto the VPS** (git or Syncthing) so OpenClaw can read/write your markdown. Captured notes land in the vault on the box → sync back → you see them in Obsidian.

The vault stays your **human-readable source of truth**; gbrain is the **fast, synthesized recall layer** on top of it.

---

## Runbook (ordered — security-first)

Legend: **[you]** = you run it (interactive/accounts). Files referenced live in this folder.

### 0. Mindset
Read [SECURITY.md](SECURITY.md) first. OpenClaw runs shell/tools on the host and has had actively-exploited CVEs. The non-negotiables: latest version, **never expose the port**, Tailscale-only, sandbox on, gateway auth token, DM allowlist to *your* Telegram ID, minimal tools.

### 1. [you] Provision the box + lock the network
- A small VPS (Hetzner CX22 ~€4/mo, or DigitalOcean) or Fly.io with a persistent volume.
- Install **Tailscale** on the VPS and on your phone/Mac. This is how you'll reach it — no public ports.

### 2. [you] Install + HARDEN OpenClaw (before any channel)
```bash
# Node 24 (or 22.19+), then:
npm install -g openclaw@latest
openclaw onboard --install-daemon
openclaw --version            # must be ≥ 2026.4.22 (Claw Chain patch); latest stable is newer
sudo loginctl enable-linger $USER   # keep the user daemon alive after logout
```
Apply the hardened config (copy [`openclaw.example.json5`](openclaw.example.json5) → `~/.openclaw/openclaw.json`, fill placeholders), then:
```bash
openclaw security audit --fix
openclaw doctor
```

### 3. [you] Point it at your model (ChatGPT Pro)
Authenticate the conversational brain with your ChatGPT Pro subscription via Codex OAuth:
```bash
openclaw onboard --auth-choice openai     # "Sign in with ChatGPT" (PKCE); --device-code for headless
openclaw models status                    # confirm the active OpenAI model id
```
⚠️ This runs on a shared 5-hour + weekly cap and is gray-area for 24/7 use. When it throttles, switch to a usage-billed key with `openclaw onboard --auth-choice openai-api-key` (set `OPENAI_API_KEY`) — nothing else changes.

### 4. [you] gbrain on Supabase (the shared brain)
- Easiest: on your **Mac**, run `/setup-gbrain` (you have it) and choose **Supabase** (auto-provision or paste a connection string). Note the Session Pooler URL.
- On the **VPS**, install the gbrain CLI and `gbrain init` against the *same* Supabase URL, then register it with OpenClaw:
  ```bash
  openclaw mcp add gbrain --command gbrain --arg serve
  ```
- Back on your **Mac**, register the same brain for Claude Code: `claude mcp add gbrain -- gbrain serve`. Now both sides share one brain.

### 5. [you] Get the vault onto the box
- Put the Obsidian vault under OpenClaw's workspace (set `agents.defaults.workspace` to the vault path, or symlink it under `~/.openclaw/workspace`).
- Sync it both ways: a private **git** repo with a scheduled commit/pull, or **Syncthing**, or **Obsidian Sync**. (Two-way markdown sync can conflict — for v1, have the agent append to a single `inbox/` daily note to minimize collisions.)

### 6. [you] Connect Telegram + lock it down
- Message **@BotFather** → `/newbot` → copy the token into the config (`channels.telegram.botToken`).
- Start the gateway, DM your bot, then approve yourself:
  ```bash
  openclaw pairing list telegram
  openclaw pairing approve telegram <CODE>
  ```
- Find your numeric Telegram user ID (`openclaw logs --follow`, read `from.id`) and switch `dmPolicy` to `"allowlist"` with only your ID.

### 7. Drop in the persona + check-ins
- Copy [`AGENTS.md`](AGENTS.md) into the OpenClaw workspace (this is the agent's personality + rules: gbrain-first, capture-to-vault, no email/calendar, draft-don't-send).
- Create the scheduled check-ins from [`cron-checkins.md`](cron-checkins.md).

### 7.5 [optional] Add the "text-it-to-code" superpower (the full Garry rig)
Wire OpenClaw to spawn Claude Code + gstack so you can text it a coding task and get a PR back. This part needs **Anthropic** auth for the spawned sessions (ChatGPT Pro can't drive it). See [`gstack-coding-module.md`](gstack-coding-module.md). Skip it if you only want the personal companion.

### 8. [you] Verify, then live
```bash
openclaw security audit --deep
openclaw health
```
Confirm: unauthorized access fails, secrets are redacted in logs, only your ID can DM, port 18789 is not publicly reachable. Then text it "morning check-in" and watch it work.

---

## Files in this folder
- [`openclaw.example.json5`](openclaw.example.json5) — hardened config template (Telegram, cron, gbrain MCP, vault workspace, sandbox, auth).
- [`AGENTS.md`](AGENTS.md) — the agent's persona + behavioral rules.
- [`cron-checkins.md`](cron-checkins.md) — exact commands for morning/evening/weekly check-ins.
- [`gstack-coding-module.md`](gstack-coding-module.md) — *optional* "text-it-to-code" superpower (spawns Claude Code + gstack).
- [`SECURITY.md`](SECURITY.md) — the hardening checklist. **Read first.**

## When you're ready for more
Add email/calendar later *only* in draft-don't-send mode, behind explicit confirms (see [`../docs/agent-workflow-principles.md`](../docs/agent-workflow-principles.md)). Keep the brain curated; let gbrain's overnight daemon enrich it.
