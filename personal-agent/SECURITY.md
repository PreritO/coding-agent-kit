# SECURITY — read before connecting any channel

OpenClaw runs shell/tools on the host you put it on. A cloud box reachable from
the internet is a real target — so this is not optional. Sources: OpenClaw docs
(gateway/security, sandboxing, exposure-runbook) + the "Claw Chain" disclosures.

## The non-negotiables

1. **Be on a patched version.** The "Claw Chain" — CVE-2026-44112 (CVSS 9.6),
   44113, 44115, 44118 — chained to data theft → privilege escalation → persistence,
   and tens of thousands of instances were found exposed. **Patched in `2026.4.22`.**
   Install `openclaw@latest` (newer stable) and verify: `openclaw --version`.
   Keep current: `openclaw update --channel stable`.

2. **Never expose the gateway port.** Default `18789`, default bind `loopback` —
   keep it that way. Reach the box over **Tailscale** (or an SSH tunnel), never a
   public `0.0.0.0` bind. The docs say this verbatim: *"Never expose the Gateway
   unauthenticated on 0.0.0.0."*

3. **Gateway auth token.** Set `gateway.auth.mode: "token"` with a long random
   value (`openssl rand -hex 32`). No valid auth → it should refuse connections.

4. **Sandbox tool execution.** `agents.defaults.sandbox: { mode: "all", backend: "docker" }`.
   This is exactly the layer the Claw Chain abused — run it. Inspect with
   `openclaw sandbox explain`.

5. **Lock who can talk to it.** `dmPolicy: "pairing"` to start; after you approve
   yourself once, switch to `"allowlist"` with only **your** numeric Telegram ID.
   Never `"open"` / `allowFrom: ["*"]`. Require mentions in any group.

6. **Least privilege.** `tools.profile: "messaging"`, `tools.exec: { security: "deny", ask: "always" }`,
   `tools.elevated.enabled: false`. No email/calendar/payment tools in v1.

7. **Throwaway, scoped credentials.** The box should hold *its own* API keys, never
   your primary logins. If you ever commit a token anywhere, rotate it (git history
   keeps it). The gbrain Supabase URL grants full read/write to the brain — treat it
   like a password.

8. **Audit, before and after.**
   ```bash
   openclaw security audit --fix     # tightens perms, restores secret redaction
   openclaw doctor
   openclaw security audit --deep    # live probing — re-run after any config change
   openclaw health
   ```
   Confirm: unauthorized access fails, logs redact secrets, only your ID can DM, the
   port isn't publicly reachable.

## Mindset
Assume any content the agent *reads* (a pasted note, a web page) can carry hidden
instructions (prompt injection). Keep the agent on a short leash: it captures and
recalls, it doesn't execute irreversible actions without your explicit yes. Treat the
whole box as compromisable — keep it isolated and updatable, with nothing on it you
can't rotate.
