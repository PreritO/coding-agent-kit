# /refine - Refine an Existing Plan

Iterate on a technical plan based on feedback. This is the core of the iterative planning workflow.

## Usage

```
/refine [plan-name]           # Open plan for refinement
/refine                        # List plans and choose one
```

## Instructions

**Arguments:** $ARGUMENTS

### The Iteration Loop

This command enables the back-and-forth refinement that makes plans great:

```
┌─────────────────────────────────────────────┐
│                                             │
│   /plan  ──►  Draft  ──►  /refine  ───┐    │
│                              │         │    │
│                              ▼         │    │
│                         Discuss  ◄─────┘    │
│                              │              │
│                              ▼              │
│                          Update             │
│                              │              │
│                              ▼              │
│                       ┌──────────┐          │
│                       │ Approved? │          │
│                       └──────────┘          │
│                         │     │             │
│                        No    Yes            │
│                         │     │             │
│                         │     ▼             │
│                         │  /implement       │
│                         │                   │
│                         └──► /refine        │
│                                             │
└─────────────────────────────────────────────┘
```

### Step 1: Load the Plan

Find and read `.claude/plans/[PLAN-NAME].md` (also check subdirectories).

Display current status and summary:
```
Plan: [Feature Name]
Status: DRAFT
Last modified: [date]

Summary:
[2-3 sentences from plan]

Tasks: 8 (0 completed)
Tests: 5 defined
Open Questions: 2
```

### Step 2: Present for Discussion

Show the key sections that typically need refinement:

```
Areas to Refine

1. SCOPE
   Current: [summary of scope]
   Questions: Is this too broad? Missing anything?

2. TECHNICAL APPROACH
   Current: [summary of approach]
   Alternatives considered: [list]

3. TASK BREAKDOWN
   Current: 8 tasks across 3 phases
   Review: Are tasks the right size? Dependencies correct?

4. TESTING STRATEGY
   Current: 5 unit tests, 2 integration tests
   Coverage: Does this cover all success criteria?

5. OPEN QUESTIONS
   - Question 1: [awaiting answer]
   - Question 2: [awaiting answer]

What would you like to refine?
```

### Step 3: Collect Feedback

Listen for user input on what to change:

**Scope changes:**
- "Make it simpler" — Reduce scope, mark items as future work
- "Add X feature" — Expand scope, add tasks
- "Split this up" — Break into multiple plans/phases

**Technical changes:**
- "Use approach B instead" — Update design section
- "What about caching?" — Analyze and add if needed
- "This violates our conventions" — Check against project conventions, fix

**Task changes:**
- "This seems too big" — Break task into smaller steps
- "Can we parallelize more?" — Reorder with dependencies
- "Add a task for X" — Insert new task in correct order

**Testing changes:**
- "Need more edge case tests" — Add specific test cases
- "Include load testing" — Add performance test plan
- "Manual testing for X" — Add to manual checklist

### Step 4: Update the Plan

After each piece of feedback:
1. Update the relevant section in the plan file
2. Add entry to the Changelog section
3. Show the user what changed

### Step 5: Answer Open Questions

Work through unresolved questions with the user, updating decisions in the plan.

### Step 6: Approval Check

After refinements, check readiness:

```
Plan Refinement Summary

Changes Made:
- [list of changes]

Open Questions: [count]
Blockers: [any]

Status Options:
1. Continue refining (more changes needed)
2. Mark as APPROVED (ready to implement)
3. Save as DRAFT (come back later)

What's your choice?
```

### When to Stop Refining

A plan is ready for approval when:
- [ ] All open questions are answered
- [ ] Scope is clearly defined (what's in AND what's out)
- [ ] Technical approach is decided
- [ ] Tasks are appropriately sized
- [ ] Each success criterion has a verification method
- [ ] Architectural / convention compliance checked
- [ ] User explicitly approves

## Related Commands

- `/plan` - Create a new plan
- `/implement` - Execute an approved plan
- `/verify` - Verify implementation
