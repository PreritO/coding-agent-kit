# /commit-push-pr - Commit, Push, and Create PR

Automates the entire git workflow from staged changes to pull request.

## Usage

```
/commit-push-pr                    # Auto-generate commit message
/commit-push-pr "message"          # Use provided commit message
/commit-push-pr --draft            # Create draft PR
/commit-push-pr --plan [name]      # Link to implementation plan
```

## Instructions

**Arguments:** $ARGUMENTS

### Pre-computed Context

First, gather git context (this reduces back-and-forth):

```bash
# Get current state
git status --porcelain
git diff --stat
git diff --cached --stat
git log -1 --oneline
git branch --show-current
git log origin/main..HEAD --oneline 2>/dev/null || echo "No upstream"
```

### Step 1: Stage Changes

If there are unstaged changes:
```
Unstaged Changes Detected

Modified:
- path/to/service
- path/to/page

Untracked:
- tests/test_service

Stage all changes? (or specify files to exclude)
```

Stage the approved files:
```bash
git add [files]
```

### Step 2: Generate Commit Message

Analyze the staged changes and generate a commit message:

```bash
git diff --cached
```

**Commit Message Format:**
```
<type>(<scope>): <description>

<body - what and why>

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Types:** feat, fix, refactor, test, docs, chore, perf
**Scope:** the area of the codebase touched (e.g. api, auth, ui, infra)

### Step 3: Commit

```bash
git commit -m "$(cat <<'EOF'
<generated message>

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

### Step 4: Push to Remote

Check if branch exists on remote and push with upstream tracking:
```bash
git push -u origin $(git branch --show-current)
```

### Step 5: Create Pull Request

Use `gh` CLI to create the PR:

```bash
gh pr create \
  --title "<PR title>" \
  --body "$(cat <<'EOF'
## Summary
<1-3 bullet points of what changed>

## Changes
- <specific change 1>
- <specific change 2>

## Test plan
- [ ] Unit tests added/updated
- [ ] Manual testing completed
- [ ] All tests passing

## Plan
<If --plan flag provided>
See: .claude/plans/[PLAN-NAME].md

Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

For draft PRs:
```bash
gh pr create --draft ...
```

### Step 6: Report Success

```
PR Created Successfully

Commit: abc1234 - feat(api): add resource CRUD endpoints
Branch: feature/resource-crud
PR: #42 - https://github.com/org/repo/pull/42

Files changed: 5
Insertions: +234
Deletions: -12

Next steps:
- Review PR at the link above
- Request reviewers if needed
- Merge when approved
```

### Handling Edge Cases

**No changes to commit:** Report clean working tree.

**Not on a feature branch:** Suggest creating one first.

**PR already exists:** Open existing PR URL, push new commits to update.

### Linking to Plans

When using `--plan`:
```
/commit-push-pr --plan RESOURCE-CRUD
```

The PR body will include completed tasks from the plan.

## Related Commands

- `/plan` - Create a technical plan
- `/implement` - Execute a plan
- `/verify` - Verify implementation
- `/test` - Run tests before committing
