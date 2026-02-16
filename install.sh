#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="$HOME/.local/share/massive-cc-review"
COMMAND_DIR="$HOME/.claude/commands"

# Install scripts
mkdir -p "$INSTALL_DIR"
cp massive-CC-review/* "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR"/*

# Install slash command, replacing SCRIPTS_DIR placeholder
mkdir -p "$COMMAND_DIR"
sed "s|SCRIPTS_DIR|$INSTALL_DIR|g" .claude/commands/file-by-file-review.md > "$COMMAND_DIR/file-by-file-review.md"

echo "Installed."
echo "  Scripts: $INSTALL_DIR/"
echo "  Command: $COMMAND_DIR/file-by-file-review.md"
echo ""
echo "Usage: open Claude Code in any repo and run:"
echo "  /file-by-file-review <what to look for>"
