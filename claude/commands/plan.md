# /plan - Technical Planning Command

Create a comprehensive technical plan for implementing a new feature.

## Instructions

You are entering **Plan Mode** for iterative feature planning. This follows a plan-first workflow:
1. Start in Plan mode (no code changes)
2. Iterate on the plan with the user
3. Only implement after explicit approval

## Input

**Feature Request:** $ARGUMENTS

If no arguments provided, ask the user to describe the feature they want to plan.

## Planning Process

### Step 1: Understand & Clarify

First, gather context:
- What problem are we solving?
- Who are the users/actors (e.g. end user vs admin)?
- What are the success criteria?
- Any constraints (tech, compatibility, scope)?

**Ask clarifying questions before proceeding.** Do not assume requirements.

### Step 2: Explore the Codebase

Use the `architect` subagent to:
1. Find existing patterns we can leverage
2. Identify similar features to model after
3. Map systems this will interact with (database, storage, background jobs, third-party services, etc.)
4. Locate relevant data models and APIs

If your project keeps reference docs under `.claude/skills/`, load any that are relevant (e.g. architecture principles, data model conventions, API conventions).

### Step 3: Draft the Technical Plan

If your project keeps a `.claude/plans/` index of prior and active work, read it first for context.

Create a plan file at `.claude/plans/[FEATURE-NAME].md` with this structure:

```markdown
# [Feature Name] - Technical Plan

**Status:** DRAFT | APPROVED | IN_PROGRESS | COMPLETED
**Created:** [date]
**Author:** Claude + [user]

## Overview
[2-3 sentence summary of what we're building]

## Success Criteria
- [ ] Criterion 1 (testable)
- [ ] Criterion 2 (testable)
- [ ] Criterion 3 (testable)

## Technical Design

### Data Model Changes
[New data models, fields, relationships — with types]

### API Changes
| Method | Endpoint | Auth | Purpose |
|--------|----------|------|---------|
| POST | /api/... | user | ... |

### Frontend / UI Changes
- Pages, components, data-fetching hooks

### Background Jobs / Async Work (if applicable)
[New jobs, queues, worker assignments]

### Storage (if applicable)
[New object types, access patterns]

### Dependencies
- External: [third-party services, APIs]
- Internal: [features that must exist first]

## Implementation Tasks

### Phase 1: Foundation
1. [ ] Task description (backend/frontend/infra)
   - Files: `path/to/file`
   - Depends on: none

2. [ ] Task description
   - Files: `path/to/file`
   - Depends on: Task 1

### Phase 2: Core Logic
[Continue with ordered tasks...]

### Phase 3: Integration & Polish
[Final tasks...]

## Verification Plan

### Unit Tests
- [ ] Test: [description] -> File: `tests/test_[feature]`
- [ ] Test: [description] -> File: `tests/test_[feature]`

### Integration Tests
- [ ] Test: [description] -> covers Tasks X, Y, Z

### Manual Testing Checklist
- [ ] Scenario 1: [steps to verify]
- [ ] Scenario 2: [steps to verify]
- [ ] Edge case: [what to check]

### Architectural Compliance
- [ ] Auth checks on all protected routes
- [ ] Input is validated and access is scoped to the current user
- [ ] Heavy computation runs in background workers (not the request cycle)
- [ ] Follows the project's established conventions

### Acceptance Criteria Validation
- [ ] Success Criterion 1 -> Verified by: [test/manual check]
- [ ] Success Criterion 2 -> Verified by: [test/manual check]

## Risks & Mitigations
| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| ... | High/Med/Low | High/Med/Low | ... |

## Questions & Decisions
- [ ] Question 1: [awaiting user input]
- [x] Question 2: Decided -> [answer]

## Changelog
- [date]: Initial draft
```

### Step 4: Review & Iterate

After creating the draft:
1. Present a summary to the user
2. Highlight any open questions or trade-offs
3. Ask for feedback on the approach
4. **Do not proceed to implementation without explicit approval**

The user may say:
- "Looks good, let's implement" -> Update status to APPROVED, suggest `/implement`
- "What about X?" -> Discuss and update the plan
- "I prefer approach B" -> Revise accordingly
- "Let's simplify" -> Use `/refine` to iterate

### Step 5: Approval Checkpoint

When the plan is finalized, ask:

> "The plan for **[Feature Name]** is ready. Summary:
> - [X tasks] across [Y phases]
> - Estimated complexity: [Low/Medium/High]
> - Key risk: [main risk]
>
> Ready to approve and move to implementation?"

Only after explicit approval:
1. Update the plan status to `APPROVED`
2. Tell the user to run `/implement [feature-name]` to begin

## Important Rules

1. **Never write implementation code during planning** — only exploration
2. **Always create a verification plan** — tests are required
3. **Ask before assuming** — unclear requirements should be clarified
4. **Keep the plan file updated** — it's the source of truth
5. **Iterate until approved** — planning is collaborative
6. **Check architectural compliance** — reference your project's conventions
