# /test - Run Test Suite

Run the full test suite for backend and/or frontend.

## Usage

```
/test              # Run all tests (backend + frontend)
/test backend      # Run only backend tests
/test frontend     # Run only frontend tests
/test [file]       # Run a specific test file
```

## Instructions

**Arguments:** $ARGUMENTS

### Determine Scope

Based on arguments:
- No args or "all" — Run both backend and frontend tests
- "backend" or "be" — Run only backend tests
- "frontend" or "fe" — Run only frontend tests
- Specific file path — Run that test file only

Prefer using the `test-runner` subagent to execute and interpret results.

### Backend Tests

<!-- Customize: your backend test command, e.g. pytest / go test ./... -->
```bash
<your backend test command>
```

**For specific files:**
```bash
<your backend test command> <test file>
<your backend test command> <test file>::<test function>
```

**With coverage:**
```bash
<your backend test command with coverage flags>
```

### Frontend Tests

<!-- Customize: your frontend test command, e.g. npm test / vitest run -->
```bash
<your frontend test command>
```

**Specific app / file:**
```bash
<your frontend test command> <path>
```

**Watch mode:**
```bash
<your frontend test command in watch mode>
```

### Test Output Analysis

After running tests:

1. **All Passed** — Report success with summary
   ```
   All tests passed
   - Backend: X passed
   - Frontend: Y passed
   ```

2. **Failures** — Analyze and report:
   ```
   Test failures detected

   Backend (2 failed):
   - test_service::test_create - AssertionError
   - test_auth::test_invalid_token - ConnectionError

   Frontend (1 failed):
   - List.test - Expected "Loading" but got "Error"

   Would you like me to investigate these failures?
   ```

3. **No Tests Found** — Report and suggest creating tests
   ```
   No tests found in [location]

   This feature doesn't have tests yet. Would you like me to:
   1. Create a test infrastructure setup? (use /init-tests)
   2. Write tests for a specific feature?
   ```

### If Tests Don't Exist Yet

If the project has no test infrastructure yet, direct the user to run `/init-tests` to set it up.

## Related Commands

- `/init-tests` - Set up test infrastructure
- `/plan` - Create plans that include verification tests
- `/implement` - Write tests during implementation
- `/verify` - Verify implementation matches plan
