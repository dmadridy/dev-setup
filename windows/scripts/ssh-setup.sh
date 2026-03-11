#!/bin/bash

set -e

echo "Starting SSH setup..."

SSH_DIR="$HOME/.ssh"
KEY_PATH="$SSH_DIR/id_ed25519"
NAME="David Madrid"
EMAIL="code@dmadridy.com"
GITHUB_USERNAME="dmadridy"

mkdir -p $SSH_DIR
chmod 700 $SSH_DIR

# Generate key if it doesn't exist
if [ ! -f "$KEY_PATH" ]; then
  echo "Generating new SSH key..."
  ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""
else
  echo "SSH key already exists"
fi

# Start ssh-agent
echo "Starting ssh-agent..."
eval "$(ssh-agent -s)"

# Add key to agent
ssh-add "$KEY_PATH"

# Create SSH config if missing
CONFIG_FILE="$SSH_DIR/config"

if [ ! -f "$CONFIG_FILE" ]; then
cat <<EOF > "$CONFIG_FILE"
Host github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
EOF
fi

chmod 600 "$CONFIG_FILE"

echo ""
echo "Your public SSH key:"
echo "--------------------------------------"
cat "$KEY_PATH.pub"
echo "--------------------------------------"
echo ""
echo "Add this key to GitHub account '$GITHUB_USERNAME':"
echo "https://github.com/settings/keys"
echo ""
echo "SSH setup complete for $NAME <$EMAIL>."