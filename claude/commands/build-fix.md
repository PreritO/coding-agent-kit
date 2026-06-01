# /build-fix - Fix Build Errors Command

Quickly fix compilation, type, and build errors with minimal changes.

## Instructions

You are invoking the **build-error-resolver** subagent to fix build errors. Use the **build-validator** subagent to confirm the build/typecheck passes after fixes.

## Input

**Component with build errors:** $ARGUMENTS

Options:
- `/build-fix` - Auto-detect which component has errors
- `/build-fix backend` - Fix backend build/type errors
- `/build-fix frontend` - Fix frontend build/type errors

## Workflow

### Step 1: Identify Errors

<!-- Customize: your build/typecheck commands -->
```bash
# Backend
<your backend build/typecheck command> 2>&1 | head -30

# Frontend
<your frontend typecheck command> 2>&1 | head -30
<your frontend build command> 2>&1 | head -30
```

### Step 2: Categorize Errors

Group by type:
- Import/Module errors
- Type errors
- Syntax errors
- Missing dependencies

### Step 3: Fix Systematically

Use the **build-error-resolver** subagent with strict rules:
- Minimal changes only
- No refactoring
- No feature additions
- Fix one error at a time

### Step 4: Verify Fix

After each fix, re-run the build (or use the **build-validator** subagent):
```bash
<your build command> 2>&1 | head -10
```

### Step 5: Report

```markdown
## Build Fix: [Component]

### Errors Found: N
### Errors Fixed: N

### Changes Made
| File | Line | Fix |
|------|------|-----|
| ... | ... | ... |

### Build Status
✅ PASSING / ❌ STILL FAILING (N remaining)
```

## Example

```
User: /build-fix frontend
```

Output:
```markdown
## Build Fix: Frontend

### Errors Found: 3

1. TS2322: Type 'undefined' not assignable to 'string' - page.tsx:15
2. TS2307: Cannot find module '@/components/Foo' - page.tsx:3
3. TS7006: Parameter 'data' implicitly has 'any' - api.ts:22

### Fixes Applied

#### Fix 1: page.tsx:15
```diff
- const name: string = user?.name;
+ const name: string = user?.name ?? '';
```

#### Fix 2: page.tsx:3
```diff
- import { Foo } from '@/components/Foo';
+ // Removed unused import
```

#### Fix 3: api.ts:22
```diff
- function process(data) {
+ function process(data: Record) {
```

### Build Status
✅ PASSING
```

## Key Principle

> Fix the error, not the code.

Only change what's necessary to make the build pass. Save refactoring for later.
