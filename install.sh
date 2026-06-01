#!/usr/bin/env bash
#
# coding-agent-kit installer
# Copies (or symlinks) the kit's commands/agents into a target project's
# .claude/ and .codex/ directories. Never overwrites existing files.
#
# Usage:
#   ./install.sh [target-project-dir]    # default: current directory
#   MODE=symlink ./install.sh [dir]      # symlink instead of copy (stays in sync)
#
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-$(pwd)}"
MODE="${MODE:-copy}"

if [ ! -d "$TARGET" ]; then
  echo "error: target directory not found: $TARGET" >&2
  exit 1
fi
if [ "$MODE" != "copy" ] && [ "$MODE" != "symlink" ]; then
  echo "error: MODE must be 'copy' or 'symlink' (got '$MODE')" >&2
  exit 1
fi

echo "Installing coding-agent-kit"
echo "  from : $KIT_DIR"
echo "  into : $TARGET"
echo "  mode : $MODE"
echo ""

mkdir -p \
  "$TARGET/.claude/commands" \
  "$TARGET/.claude/agents" \
  "$TARGET/.claude/skills" \
  "$TARGET/.codex/agents"

added=0
skipped=0

install_one() {
  local src="$1" dest="$2"
  local rel="${dest#"$TARGET"/}"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "  · skip (exists): $rel"
    skipped=$((skipped + 1))
    return
  fi
  if [ "$MODE" = "symlink" ]; then
    ln -s "$src" "$dest"
  else
    cp "$src" "$dest"
  fi
  echo "  + $rel"
  added=$((added + 1))
}

for f in "$KIT_DIR"/claude/commands/*.md; do
  [ -e "$f" ] && install_one "$f" "$TARGET/.claude/commands/$(basename "$f")"
done
for f in "$KIT_DIR"/claude/agents/*.md; do
  [ -e "$f" ] && install_one "$f" "$TARGET/.claude/agents/$(basename "$f")"
done
for f in "$KIT_DIR"/codex/agents/*.toml; do
  [ -e "$f" ] && install_one "$f" "$TARGET/.codex/agents/$(basename "$f")"
done

echo ""
echo "Done — $added added, $skipped skipped."
echo ""
echo "Slash commands now available in Claude Code:"
echo "  /workflow /plan /refine /implement /verify /code-review /tdd /test /init-tests /build-fix /commit-push-pr"
echo ""
echo "Codex MCP config template (copy + add your own secrets via env):"
echo "  $KIT_DIR/codex/config.example.toml"
