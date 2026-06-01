# /init-tests - Initialize Test Infrastructure

Set up testing infrastructure for backend and/or frontend.

## Usage

```
/init-tests              # Set up both backend and frontend
/init-tests backend      # Backend only
/init-tests frontend     # Frontend only
```

## Instructions

**Arguments:** $ARGUMENTS

First, detect the project's language and tooling, then set up a test runner that matches the stack. The steps below are a template — adapt the specific tool to your project.

### Backend Test Setup

#### 1. Add Test Dependencies

Add a test runner and supporting libraries to your project's dependency manifest.

<!-- Customize: your backend test deps, e.g. pytest + httpx, or jest, or go's testing pkg -->
```
<add test runner + assertion/mocking libs to your dependency manifest>
```

Install them with your package manager.

#### 2. Create Test Structure

Create a `tests/` directory mirroring your source layout:

```
tests/
├── conftest / setup file    # Shared fixtures and setup
├── test_health              # Health/smoke test
├── services/                # Service-layer unit tests
└── integration/             # Endpoint / integration tests
```

#### 3. Create Shared Fixtures

Create a shared setup/fixtures file that provides:

- A **test database** (in-memory or a disposable test instance), created and torn down per test/session.
- A **test HTTP client** wired to the app, with dependency overrides so you can inject the test DB and a fake authenticated user.
- **Mocks for external dependencies** — storage, background-job/queue clients, and third-party services. Return predictable fake values (e.g. a fake upload URL, a fake job id).
- A **sample authenticated user** helper for tests that need an authenticated request.

The goal: tests run fast, hermetically, and never touch real external services.

#### 4. Configure the Test Runner

Add test-runner configuration to your project (test paths, file/function naming patterns, async mode if relevant, and any warning filters).

#### 5. Create a Sample Test

Write one smoke test against a known-good endpoint to confirm the harness works:

```
# tests/test_health
# Call the health endpoint, assert it returns a success status
# and the expected body, e.g. {"status": "healthy"}
```

### Frontend Test Setup

#### 1. Install Dependencies

<!-- Customize: your frontend test deps, e.g. vitest / jest + testing-library + jsdom -->
```
<install a test runner, a component testing library, and a DOM environment>
```

#### 2. Create Test Runner Config

Configure the test runner with:
- A DOM-like test environment
- Globals enabled (optional)
- A setup file (see below)
- An include glob for `*.test`/`*.spec` files
- Coverage reporting
- Module path aliases matching your build config

#### 3. Create Test Setup

Create a setup file that registers DOM matchers and cleans up the DOM after each test.

#### 4. Create Test Utilities

Create a custom render helper that wraps components in the providers they need at runtime (e.g. a data-fetching/query provider, theme/router providers) and bundles a user-event instance. Re-export it so tests import a single `render`.

#### 5. Add Test Scripts

Add `test`, `test:run`, and `test:coverage` scripts to your package manifest.

### Verification

After setup, verify the harness works:

```bash
# Backend: collect tests without running them
<your backend test collect command>

# Frontend: run the suite once
<your frontend test run command>
```

### Next Steps

After initialization:
1. Run `/test` to verify setup works
2. Add tests as you build features with `/plan` and `/implement`
3. Use `/verify` to check test coverage against plans

## Related Commands

- `/test` - Run the test suite
- `/plan` - Create plans that include tests
- `/implement` - Write tests during implementation
