#!/bin/bash

set -e

echo "Starting machine bootstrap..."

########################################
# Install Homebrew
########################################

if ! command -v brew &> /dev/null
then
    echo "Installing Homebrew..."

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add brew to PATH (Mac Silicon compatibility)
    if [[ -d "/opt/homebrew/bin" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "Homebrew already installed"
fi

########################################
# Configure Git
########################################

echo "Configuring Git..."

git config --global init.defaultBranch main
git config --global core.editor cursor
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

########################################
# Configure Zsh
########################################

echo "Configuring Zsh aliases..."

if ! grep -q "CUSTOM_ALIASES" ~/.zshrc 2>/dev/null; then

cat <<EOF >> ~/.zshrc

# CUSTOM_ALIASES
alias gs="git status"
alias gc="git commit"
alias gp="git push"
alias ga="git add ."
alias ll="ls -la"

EOF

fi

########################################
# Install NVM
########################################

if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing NVM..."

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

########################################
# Install Node LTS
########################################

if ! command -v node &> /dev/null
then
    echo "Installing Node LTS..."

    nvm install --lts
    nvm alias default lts/*
else
    echo "Node already installed"
fi

echo "Bootstrap complete."