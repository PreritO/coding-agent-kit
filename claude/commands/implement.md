# /implement - Execute an Approved Plan

Implement a feature following an approved technical plan.

## Usage

```
/implement [plan-name]     # Implement specific plan
/implement                  # List available approved plans
```

## Instructions

**Arguments:** $ARGUMENTS

### Step 1: Load the Plan

If a plan name is provided:
1. Look for `.claude/plans/[PLAN-NAME].md`
2. Verify the plan status is `APPROVED`
3. If not approved, ask user to run `/plan [name]` first

If no argument:
1. List all plans in `.claude/plans/`
2. Show their status (DRAFT, APPROVED, IN_PROGRESS, COMPLETED)
3. Ask which one to implement

### Step 2: Pre-Implementation Checklist

Before starting:

```
Pre-Implementation Checklist for [Feature Name]

Plan Status: APPROVED
Tasks: [X total, Y phases]
Tests Required: [Z tests defined]

Ready to begin implementation?
```

Wait for user confirmation.

### Step 3: Execute Tasks in Order

For each task in the plan:

1. **Mark task as in-progress** in the plan file
2. **Use the appropriate subagent** for the work (e.g. the `architect` subagent for design questions that come up mid-implementation)
3. **Implement the task** following the plan's specifications
4. **Write the associated test(s)** as specified in the Verification Plan
5. **Mark task as complete** in the plan file
6. **Report progress** to user:
   ```
   Task 1/8 complete: Create data model
   - Modified: path/to/model
   - Added test: tests/test_model

   Starting Task 2/8: Add API endpoint...
   ```

### Step 4: Handle Dependencies

Respect task dependencies noted in the plan:
- If Task B depends on Task A, complete A first
- Parallelizable tasks can be done together when noted

### Step 5: Write Tests as You Go

For each implementation task, write the corresponding tests from the Verification Plan:

**Backend Tests:**
- Write unit tests for new service methods
- Write integration tests for new endpoints
- Mock external dependencies (database, storage, third-party services)

**Frontend Tests:**
- Write component tests
- Write data-fetching hook tests
- Mock API responses

### Step 6: Post-Implementation

After all tasks are complete:

1. Run the full test suite: `/test`
2. Regenerate any generated API clients/types if endpoints changed
3. Check all success criteria from the plan
4. Update plan status to `COMPLETED`

```
Implementation Complete: [Feature Name]

Completed:
- [X] tasks implemented
- [Y] tests written and passing
- [Z] success criteria met

Files Modified: [list of files]

Next steps:
- Run /verify [plan-name] for full verification
- Run /commit-push-pr to create a pull request
```

### Implementation Rules

1. **Follow the plan exactly** — don't add unplanned features
2. **Write tests for every task** — verification is mandatory
3. **Update the plan file** — track progress in real-time
4. **Use appropriate subagents** — leverage domain expertise
5. **Report blockers immediately** — don't silently fail
6. **Keep changes focused** — one task at a time
7. **Check architectural compliance** — auth checks, scoped access, project conventions
8. **Regenerate clients/types** — after any endpoint changes

### Handling Issues

If you encounter a problem:

1. **Can be solved quickly** -> Fix and continue
2. **Requires plan adjustment** -> Stop and ask user
   ```
   Implementation Issue

   Task 4 requires a service that isn't set up yet.

   Options:
   1. Skip for now, add TODO
   2. Set up the dependency first (infrastructure task)
   3. Mock it for development

   Which approach do you prefer?
   ```
3. **Major blocker** -> Stop implementation, update plan status

### Progress Tracking

Update the plan file as you work:

```markdown
## Implementation Tasks

### Phase 1: Foundation
1. [x] Create data model (completed)
2. [~] Add API endpoint (in progress)
3. [ ] Add service layer
```

## Related Commands

- `/plan` - Create a technical plan
- `/refine` - Iterate on a plan
- `/test` - Run the test suite
- `/verify` - Verify implementation matches plan
- `/commit-push-pr` - Create a pull request
