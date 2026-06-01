# /code-review - Code Review Command

Perform a thorough code review focusing on bugs, security, and performance.

## Instructions

You are invoking the **reviewer** subagent (for general review) or **security-reviewer** subagent (for security-focused review).

## Input

**Files or feature to review:** $ARGUMENTS

Options:
- `/code-review` - Review all uncommitted changes
- `/code-review [file]` - Review specific file
- `/code-review --security` - Security-focused review
- `/code-review --plan [name]` - Review implementation of a plan

## Workflow

### Step 1: Identify Scope

If no arguments:
```bash
# Review uncommitted changes
git diff --name-only
git diff --cached --name-only
```

If a file is specified, read that file and review it.

### Step 2: Select Reviewer

- General review → Use the `reviewer` subagent
- Security flag → Use the `security-reviewer` subagent
- Both for critical features

### Step 3: Conduct Review

Follow the review checklist:

1. **Security** - Secrets, injection, auth
2. **Bugs** - Null handling, async errors, edge cases
3. **Performance** - N+1 queries, re-renders
4. **Error Handling** - All paths covered
5. **Consistency** - Follows project patterns

### Step 4: Report Findings

Output format:
```markdown
## Code Review: [Scope]

### Summary
[1-2 sentence overview]

### Critical Issues 🔴
[Must fix before merge]

### Major Issues 🟠
[Should fix]

### Minor Issues 🟡
[Nice to fix]

### Suggestions 💡
[Optional improvements]

### Verdict
- [ ] APPROVE
- [ ] APPROVE WITH COMMENTS
- [ ] REQUEST CHANGES
```

### Step 5: Suggest Fixes

For each issue, provide:
1. What's wrong
2. Why it matters
3. How to fix (with code snippet)

## Example

```
User: /code-review src/services/parser
```

Output:
```markdown
## Code Review: parser

### Summary
The parser service looks good overall. One error-handling issue and two performance suggestions.

### Critical Issues 🔴
None

### Major Issues 🟠
1. **Missing error handling** - `parser:15`
   - Problem: the load call can fail if the file doesn't exist
   - Fix:
   ```
   try:
       data = load(path)
   except Exception as e:
       raise ParseError(f"Failed to load: {e}")
   ```

### Verdict
- [x] APPROVE WITH COMMENTS
```
