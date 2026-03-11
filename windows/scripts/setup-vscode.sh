#!/bin/bash

set -e

echo "Applying VSCode configuration (Windows)..."

VSCODE_CONFIG_DIR="$APPDATA/Code/User"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_CONFIG_DIR="$SCRIPT_DIR/../config"

# Ensure config directory exists
mkdir -p "$VSCODE_CONFIG_DIR"

# Apply settings.json
if [ -f "$REPO_CONFIG_DIR/settings.json" ]; then
  cp "$REPO_CONFIG_DIR/settings.json" "$VSCODE_CONFIG_DIR/settings.json"
  echo "Applied settings.json"
else
  echo "settings.json not found in repo"
fi

# Install extensions
if [ -f "$REPO_CONFIG_DIR/extensions.txt" ]; then
  echo "Installing extensions..."

  while IFS= read -r extension
  do
    if [ ! -z "$extension" ]; then
      echo "Installing $extension"
      code --install-extension "$extension"
    fi
  done < "$REPO_CONFIG_DIR/extensions.txt"

  echo "Extensions installed"
else
  echo "extensions.txt not found in repo"
fi

echo "VSCode setup complete. Restart VSCode."

