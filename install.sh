#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(pwd)/bin"
COMMAND_DIR="$HOME/.claude/commands"

# Verify we're in the repo root
if [[ ! -d "$SCRIPTS_DIR" ]]; then
  echo "Error: Run this from the repo root (expected $SCRIPTS_DIR to exist)."
  exit 1
fi

# Install slash command, replacing SCRIPTS_DIR placeholder
mkdir -p "$COMMAND_DIR"
sed "s|SCRIPTS_DIR|$SCRIPTS_DIR|g" .claude/commands/file-by-file-review.md > "$COMMAND_DIR/file-by-file-review.md"

echo "Installed."
echo "  Scripts: $SCRIPTS_DIR/"
echo "  Command: $COMMAND_DIR/file-by-file-review.md"
echo ""
echo "Usage: open Claude Code in any repo and run:"
echo "  /file-by-file-review <what to look for>"
