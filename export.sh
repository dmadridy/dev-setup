#!/bin/bash

set -e

echo "Exporting Cursor configuration..."

CURSOR_CONFIG_DIR="$HOME/Library/Application Support/Cursor/User"
REPO_CURSOR_DIR="$(pwd)/cursor"

mkdir -p "$REPO_CURSOR_DIR"

# Export settings
if [ -f "$CURSOR_CONFIG_DIR/settings.json" ]; then
  cp "$CURSOR_CONFIG_DIR/settings.json" "$REPO_CURSOR_DIR/settings.json"
  echo "Exported settings.json"
else
  echo "Local settings.json not found"
fi

# Export extensions
echo "Exporting extensions list..."
cursor --list-extensions > "$REPO_CURSOR_DIR/extensions.txt"

echo "Export complete."