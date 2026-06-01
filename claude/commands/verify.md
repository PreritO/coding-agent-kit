# /verify - Verify Implementation

Verify that an implementation matches its technical plan and all tests pass.

## Usage

```
/verify [plan-name]     # Verify specific feature
/verify                  # Verify most recent implementation
```

## Instructions

**Arguments:** $ARGUMENTS

### Why Verification Matters

Give the agent a way to verify its work. A solid feedback loop dramatically improves the quality of the final result — this command provides that loop.

### Step 1: Load the Plan

Find the plan file in `.claude/plans/[PLAN-NAME].md` (also check subdirectories).

If no argument provided, find the most recently modified plan with status `IN_PROGRESS` or `COMPLETED`.

### Step 2: Run the Test Suite

Use the `test-runner` subagent (or run directly) to execute all tests:

<!-- Customize: your test commands, e.g. npm test / pytest -->
```bash
# Backend
<your backend test command>

# Frontend
<your frontend test command>
```

Report results:
```
Test Results

Backend:  X passed, Y failed
Frontend: X passed, Y failed
```

### Step 3: Check Success Criteria

Go through each success criterion from the plan:

```
Success Criteria Verification

1. [PASS] Criterion description
   — Verified by: test_file::test_name

2. [PASS] Criterion description
   — Verified by: manual check

3. [FAIL] Criterion description
   — Missing: No test found, feature not implemented

4. [WARN] Criterion description
   — Needs manual verification
```

### Step 4: Verify Planned Tests Exist

Check that all tests from the Verification Plan section of the plan were created:

```
Verification Plan Check

Unit Tests:
- [FOUND] test_service
- [FOUND] test_processing
- [MISSING] test_engine

Integration Tests:
- [FOUND] test_api
```

### Step 5: Architectural Compliance Check

Verify the implementation follows your project's conventions:

- [ ] Auth validated on all protected routes?
- [ ] Users can only access their own data?
- [ ] Heavy work runs in background workers, not the request cycle?
- [ ] Data models follow the project's base patterns?
- [ ] Schema migrations created for any data model changes?
- [ ] Generated clients/types regenerated after endpoint changes?

### Step 6: Code Review with Reviewer Agent

Use the `reviewer` subagent to check:
1. Code quality and patterns
2. Security issues (auth checks, input validation)
3. Performance concerns (N+1 queries, heavy work in request cycle)
4. Consistency with codebase conventions

For security-sensitive changes, also use the `security-reviewer` subagent.

### Step 7: Generate Verification Report

Create a summary:

```
Verification Report: [Feature Name]

Date: [date]
Plan: .claude/plans/[PLAN-NAME].md
Status: PASSED | PARTIAL | FAILED

Test Results
- Backend: X/Y passed
- Frontend: X/Y passed

Success Criteria
- X/Y verified

Architectural Compliance
- Auth: [PASS/FAIL]
- Access scoping: [PASS/FAIL]
- Background work: [PASS/FAIL/N/A]

Code Review
- X issues found (Y critical)

Missing Items
- [ ] item 1
- [ ] item 2

Recommendation
Ready for PR / Needs more work

Next Steps
1. Fix issues (if any)
2. Inform the user that the changes are ready to be pushed.
```

### Step 8: Update Plan Status

Based on verification results:

- **All passed** — Mark as `COMPLETED`
- **Minor issues** — Keep as `IN_PROGRESS`, list fixes needed
- **Major issues** — Note blockers, suggest re-planning

## Related Commands

- `/plan` - Create a technical plan
- `/implement` - Execute the plan
- `/test` - Run tests only
- `/commit-push-pr` - Create a pull request
