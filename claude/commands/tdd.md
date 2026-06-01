# /tdd - Test-Driven Development Command

Write tests FIRST, then implement. Enforces the RED-GREEN-REFACTOR cycle.

## Instructions

You are invoking the **tdd-guide** subagent to implement a feature using test-driven development.

## Input

**Feature to implement:** $ARGUMENTS

If no arguments provided, ask: "What feature or function should we implement using TDD?"

## Workflow

### Phase 1: Understand the Feature

1. What is the expected behavior?
2. What are the inputs and outputs?
3. What edge cases exist?
4. Which part of the codebase does this touch? (backend / frontend / other)

### Phase 2: Write Failing Tests (RED)

Create a test file in the appropriate place for the component you're touching:

<!-- Customize: where tests live and how they're named in your project -->
```bash
# Create the test file next to similar existing tests
<create tests/test_[feature] (or your project's equivalent)>
```

Write tests that:
- Test ONE behavior each
- Have clear names describing what they test
- Will FAIL until the implementation exists

### Phase 3: Verify RED

Run the tests and confirm they fail:

<!-- Customize: your test command -->
```bash
<your test command> <the new test file>
```

**Do not proceed until tests fail for the right reason.**

### Phase 4: Hand Off to Implementation

After tests are written and failing:

1. Show the user the test file(s)
2. Show the failing test output
3. Suggest: "Run `/implement` to make these tests pass"

## Output Format

```markdown
## TDD: [Feature Name]

### Behavior Defined
- Input: [what goes in]
- Output: [what comes out]
- Edge cases: [list]

### Tests Written

#### [test file]
```
[test code]
```

### RED Phase Verified
```
$ <test command> <test file>
FAILED test_feature::test_something - [reason]
```

### Ready for Implementation
Tests are failing as expected. Run `/implement [feature]` to make them pass.
```

## Example

```
User: /tdd pause detection in the audio parser
```

The agent defines the expected behavior, writes failing tests for it, verifies they fail for the right reason, and hands off to `/implement`.
