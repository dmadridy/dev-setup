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
# Install Git
########################################

if ! command -v git &> /dev/null
then
    echo "Installing Git..."
    brew install git
else
    echo "Git already installed"
fi

########################################
# Configure Git
########################################

echo "Configuring Git..."

git config --global user.name "David Madrid"
git config --global user.email "code@dmadridy.com"

git config --global init.defaultBranch main
git config --global core.editor cursor
git config --global pull.rebase false

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