#!/bin/bash

set -e

echo "Starting machine bootstrap..."

echo "This Windows bootstrap script is not yet implemented."

########################################
# Configure Git
########################################

echo "Configuring Git..."

git config --global init.defaultBranch main
git config --global pull.rebase false

# Ask before overriding name/email to avoid conflicts with corporate config
CURRENT_EMAIL=$(git config --global user.email || echo "")
CURRENT_NAME=$(git config --global user.name || echo "")

echo ""
if [ -n "$CURRENT_EMAIL" ] || [ -n "$CURRENT_NAME" ]; then
    echo "Git is already configured with:"
    [ -n "$CURRENT_NAME" ]  && echo "  Name:  $CURRENT_NAME"
    [ -n "$CURRENT_EMAIL" ] && echo "  Email: $CURRENT_EMAIL"
    echo ""
    read -r -p "Do you want to override this with your personal config (David Madrid / code@dmadridy.com)? [y/N] " response
else
    read -r -p "Do you want to set personal Git identity (David Madrid / code@dmadridy.com)? [y/N] " response
fi

if [[ "$response" =~ ^[Yy]$ ]]; then
    git config --global user.name "David Madrid"
    git config --global user.email "code@dmadridy.com"
    echo "Personal Git identity applied."
else
    echo "Skipping Git identity — existing config preserved."
fi

echo "Git configured successfully."