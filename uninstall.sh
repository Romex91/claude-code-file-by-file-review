#!/usr/bin/env bash
set -euo pipefail

COMMAND_FILE="$HOME/.claude/commands/file-by-file-review.md"
LEGACY_DIR="$HOME/.local/share/massive-cc-review"

# Remove slash command
if [[ -f "$COMMAND_FILE" ]]; then
  rm "$COMMAND_FILE"
  echo "Removed: $COMMAND_FILE"
else
  echo "Not found: $COMMAND_FILE (already removed)"
fi

# Clean up legacy install directory
if [[ -d "$LEGACY_DIR" ]]; then
  rm -rf "$LEGACY_DIR"
  echo "Removed legacy dir: $LEGACY_DIR"
fi

echo "Uninstalled."
