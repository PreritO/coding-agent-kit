# /workflow - Development Workflow Guide

Show the recommended development workflow: a plan-first inner loop with optional browser-based visual QA.

## The Inner Loop

There are two workflow tracks depending on what you're building.

> Note: `/qa`, `/qa-design-review`, and `/plan-ceo-review` referenced below are **not** part of this kit. They are provided by the **gstack** skill pack (https://github.com/garrytan/gstack) and are optional. The rest of the workflow (`/plan`, `/refine`, `/implement`, `/verify`, `/test`, `/commit-push-pr`) ships in this kit.

---

### Track A: User-Facing Feature (with UI changes)

Use this for features with meaningful frontend work, new pages, or significant UX changes.

```
┌──────────────────────────────────────────────────────────────────────────────┐
│               TRACK A — USER-FACING FEATURE (UI CHANGES)                     │
└──────────────────────────────────────────────────────────────────────────────┘

                          ┌──────────────┐
                          │   NEW TASK   │
                          └──────┬───────┘
                                 │
                                 ▼
                    ┌────────────────────────┐
                    │  /plan-ceo-review      │  ← optional (gstack)
                    │                        │
                    │  • Challenge the       │
                    │    premise / scope     │
                    │  • Choose mode:        │
                    │    EXPANSION /         │
                    │    SELECTIVE /         │
                    │    HOLD / REDUCTION    │
                    │  • 10-section review   │
                    └───────────┬────────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │      /plan [task]     │
                    │                       │
                    │  • Clarify requirements│
                    │  • Explore codebase   │
                    │  • Design solution    │
                    │  • Define tests       │
                    └───────────┬───────────┘
                                │
                         ┌──────┴──────┐
                         ▼             ▼
                ┌─────────────┐   ┌─────────────┐
                │  Approved?  │   │   /refine   │◄─┐
                │     No      │   │             │  │
                └──────┬──────┘   │  Iterate on │  │
                       │          │  the plan   │──┘
                       │          └─────────────┘
                       ▼
                ┌─────────────┐
                │  Approved?  │
                │     Yes     │
                └──────┬──────┘
                       │
                       ▼
             ┌───────────────────────┐
             │   /implement [plan]   │
             │                       │
             │  • Execute tasks      │
             │  • Write tests        │
             │  • Track progress     │
             └───────────┬───────────┘
                         │
                         ▼
               ┌───────────────────┐
               │   /qa             │  ← optional (gstack): live browser test
               │                   │
               │  • Auto-detects   │
               │    changed pages  │
               │  • Screenshots    │
               │    every issue    │
               │  • Fixes + atomic │
               │    commits        │
               │  • Health score   │
               └─────────┬─────────┘
                         │
                   ┌─────┴──────────────────────┐
                   ▼                            ▼
         ┌──────────────────┐        ┌──────────────────────┐
         │ Significant UI   │        │  Backend/logic only  │
         │ changes?         │        │  (skip design review)│
         │                  │        └──────────┬───────────┘
         ▼                  │                   │
 ┌──────────────────────┐   │                   │
 │  /qa-design-review   │   │                   │
 │  (optional, gstack)  │   │                   │
 │  • design audit      │   │                   │
 │  • AI Slop Score     │   │                   │
 │  • Design system     │   │                   │
 │    compliance        │   │                   │
 │  • Fixes + commits   │   │                   │
 └──────────┬───────────┘   │                   │
            │               │                   │
            └───────┬───────┘                   │
                    │◄──────────────────────────┘
                    ▼
          ┌───────────────────┐
          │      /verify      │
          │                   │
          │  • Run all tests  │
          │  • Check criteria │
          │  • Code review    │
          │  • Arch compliance│
          └─────────┬─────────┘
                    │
             ┌──────┴──────┐
             ▼             ▼
      ┌───────────┐  ┌───────────┐
      │  Issues?  │  │   Clean   │
      │   Fix     │  │    ✓      │
      └─────┬─────┘  └─────┬─────┘
            │              │
            └──────────────▼
                  ┌───────────────────┐
                  │  /commit-push-pr  │
                  └───────────────────┘
```

---

### Track B: Backend / API / Infrastructure

Use this for features without meaningful UI changes (new API endpoints, migrations, background jobs, infrastructure).

```
┌──────────────────────────────────────────────────────────────────────────────┐
│               TRACK B — BACKEND / API / INFRASTRUCTURE                        │
└──────────────────────────────────────────────────────────────────────────────┘

  NEW TASK → /plan [task] → /refine (iterate) → /implement → /verify → /commit-push-pr
```

Skip the optional gstack commands (`/plan-ceo-review`, `/qa`, `/qa-design-review`) for:
- API endpoint additions/changes
- Database migrations
- Background job changes
- Infrastructure/container changes
- Backend bug fixes

---

### Track C: Bug Fix

```
┌──────────────────────────────────────────────────────────────────────────────┐
│               TRACK C — BUG FIX                                               │
└──────────────────────────────────────────────────────────────────────────────┘

  /test (reproduce) → [fix] → /test (verify) → /qa (if UI bug, optional) → /commit-push-pr
```

---

## When to Use Each Optional Command

These come from the **gstack** skill pack (https://github.com/garrytan/gstack) and are optional.

| Command | When to Use |
|---------|-------------|
| `/plan-ceo-review` | Before planning any non-trivial user-facing feature. Skip for bug fixes, refactors, backend-only work. |
| `/qa` | After `/implement` for any change that touches frontend pages or components. Diff-aware. |
| `/qa-design-review` | After `/qa` when you've added a new page, changed layout, or touched the design system. Optional for minor UI tweaks. |

**Decision heuristic:**
- "Is this a new user-facing feature or significant UX change?" → consider `/plan-ceo-review` first
- "Did I change UI files?" → consider `/qa` after implement
- "Did I add a page, change layout, or update design tokens?" → consider `/qa-design-review` after `/qa`

---

## Command Quick Reference

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/workflow` | Show this guide | First time, or need a refresher |
| `/plan [feature]` | Create technical plan | Starting new work |
| `/refine [plan]` | Iterate on plan | Plan needs changes |
| `/implement [plan]` | Execute approved plan | After plan approval |
| `/test` | Run test suite | During/after implementation |
| `/verify [plan]` | Verify implementation | After implementation (+ QA) |
| `/commit-push-pr` | Create pull request | Ready to merge |
| `/init-tests` | Set up test infrastructure | First time test setup |
| `/tdd` | Test-first development | When writing tests before code |
| `/code-review` | Review changes | Before merging |
| `/build-fix` | Fix build/type errors | When the build breaks |
| `/plan-ceo-review` (gstack) | Scope challenge | Before planning significant features |
| `/qa` (gstack) | Visual QA with live browser | After implementing frontend changes |
| `/qa-design-review` (gstack) | Design audit | After implementing UI/layout changes |

---

## How Skills and Agents Work Together

**Skills** are passive reference documents (context). **Agents** are active workers (execution). **Commands** orchestrate both.

```
                     ┌─────────────────────────────────────┐
  YOU ──► /command ──► Agent (active worker with tools)     │
                     │   └── loads Skill (reference doc)    │
                     │       for domain context             │
                     └─────────────────────────────────────┘
```

This kit ships subagents you can reference from commands:
- `architect` — explore the codebase and design solutions
- `reviewer` — general code review
- `security-reviewer` — security-focused review
- `simplifier` — reduce complexity and dead code
- `test-runner` — run and interpret the test suite
- `build-validator` — confirm the build/typecheck passes
- `build-error-resolver` — fix build and type errors
- `tdd-guide` — drive the RED-GREEN-REFACTOR cycle

---

## Workflow Principles

### 1. Plan Before You Code
Don't jump into implementation. Take time to understand requirements, explore existing patterns, design the solution, and define how you'll test it. Stay in plan mode — don't code until the plan is approved.

### 2. Challenge Scope for User-Facing Features
For significant user-facing features, consider the optional `/plan-ceo-review` (gstack) before `/plan`. It challenges whether you're solving the right problem and gives you a clear scope mode to work in.

### 3. Iterate Until Right
Plans are living documents. Use `/refine` to simplify scope, adjust technical approach, answer open questions, or add missing tests.

### 4. Tests Are Part of Implementation
Every feature needs tests. During `/implement`: write unit tests as you go, create integration tests for APIs, define manual testing steps.

### 5. QA with Real Eyes (optional)
After implementing frontend changes, the optional `/qa` (gstack) can test the running app with a real browser. This catches things code review misses: broken layouts, missing loading states, console errors, interaction bugs.

### 6. Protect the Design System (optional)
After significant UI changes, the optional `/qa-design-review` (gstack) audits design consistency and catches generic AI-generated design patterns before they ship.

### 7. Verify Your Work
Before committing, `/verify` checks all tests pass, success criteria met, code quality standards, and architectural compliance.

### 8. Clean Git History
Use `/commit-push-pr` for well-formatted commit messages, linked PR descriptions, and traceable changes.

---

## Session Patterns

### Pattern 1: New User-Facing Feature (Full Track A)
```
/plan-ceo-review [task description]  # optional (gstack): scope challenge
/plan [feature-name]
[iterate with /refine as needed]
/implement [PLAN-NAME]
/qa                                  # optional (gstack): diff-aware browser QA
/qa-design-review                    # optional (gstack): if new pages/layout
/verify [PLAN-NAME]
/commit-push-pr
```

### Pattern 2: Backend Feature (Track B)
```
/plan [api-feature]
[iterate with /refine as needed]
/implement [PLAN-NAME]
/verify [PLAN-NAME]
/commit-push-pr
```

### Pattern 3: Bug Fix (Track C)
```
/test                              # reproduce the bug
[fix the code]
/test                              # verify fix
/qa                                # optional (gstack): if it's a UI bug
/commit-push-pr "fix: description"
```

### Pattern 4: Large Feature (Phased, Track A)
```
/plan-ceo-review [large feature]   # optional (gstack): scope challenge first
/plan [phase-a]
[scope down with /refine]
/implement [PHASE-A]
/qa
/verify [PHASE-A]
/commit-push-pr

/refine [phase-a → phase-b]
/implement [PHASE-B]
...
```

---

## Browse Binary Setup (Optional — One-Time)

The optional `/qa` and `/qa-design-review` commands rely on the gstack browse binary (compiled headless browser) for browser-based QA:

```bash
# 1. Install Bun (if not installed)
curl -fsSL https://bun.sh/install | bash

# 2. Clone gstack
git clone https://github.com/garrytan/gstack ~/.claude/skills/gstack

# 3. Build the browse binary (~10 seconds)
cd ~/.claude/skills/gstack && ./setup

# 4. Verify
~/.claude/skills/gstack/browse/dist/browse --help
```

The binary is a headless browser daemon. First invocation takes ~3 seconds to start; subsequent commands in the same session run in ~100-200ms. Auto-shuts down after 30 minutes of inactivity. This is only needed if you want browser-based QA — the core plan→implement→verify loop works without it.

---

## Tips

1. **Use a strong model for complex tasks** — planning, architecture, review
2. **Track A vs B vs C** — don't run browser QA on a database migration
3. **`/plan-ceo-review` is collaborative** (gstack) — it asks questions, you answer
4. **`/qa` is diff-aware by default** (gstack) — it only tests pages you actually changed
5. **Check everything into git** — commands, agents, plans, skills

$ARGUMENTS
