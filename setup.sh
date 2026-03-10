#!/bin/bash

set -e

echo "Applying Cursor configuration..."

CURSOR_CONFIG_DIR="$HOME/Library/Application Support/Cursor/User"
REPO_CURSOR_DIR="$(pwd)/cursor"

# Ensure config directory exists
mkdir -p "$CURSOR_CONFIG_DIR"

# Apply settings.json
if [ -f "$REPO_CURSOR_DIR/settings.json" ]; then
  cp "$REPO_CURSOR_DIR/settings.json" "$CURSOR_CONFIG_DIR/settings.json"
  echo "Applied settings.json"
else
  echo "settings.json not found in repo"
fi

# Install extensions
if [ -f "$REPO_CURSOR_DIR/extensions.txt" ]; then
  echo "Installing extensions..."

  while IFS= read -r extension
  do
    if [ ! -z "$extension" ]; then
      echo "Installing $extension"
      cursor --install-extension "$extension"
    fi
  done < "$REPO_CURSOR_DIR/extensions.txt"

  echo "Extensions installed"
else
  echo "extensions.txt not found in repo"
fi

echo "Cursor setup complete. Restart Cursor."