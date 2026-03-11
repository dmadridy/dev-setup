MacOS-specific development environment configuration.

This folder contains everything needed to bootstrap and configure a macOS development machine using Cursor.

## Structure

- `config/`: Cursor IDE settings and extensions for macOS (`settings.json`, `extensions.txt`).
- `scripts/`: Helper scripts to bootstrap and manage this setup on macOS.

## Prerequisites

- **Git** installed (see global `README.md` for details).
- **Cursor** installed, with the `cursor` CLI available in your PATH.
- **VSCode** installed, with the `code` CLI available in your PATH.

## Cloning the repository (macOS)

From a terminal:

```bash
git clone https://github.com/dmadridy/dev-setup.git
cd dev-setup
```

For authentication details (corporate vs personal), see the global `README.md` section **“Auth and Cloning the Repo”**.

## Scripts (macOS)

All macOS scripts live in `macos/scripts`:

- `bootstrap.sh`: Configures the base development environment on a new macOS machine.
- `ssh-setup.sh`: Creates and configures an SSH key for GitHub authentication.
- `setup.sh`: Applies Cursor settings and installs extensions from `macos/config`.
- `export.sh`: Exports your current local Cursor configuration back into `macos/config`.

### Bootstrapping a new macOS machine

From the repo root:

```bash
chmod +x macos/scripts/bootstrap.sh
bash macos/scripts/bootstrap.sh
```

This script will:

- Install **Homebrew**
- Configure **Git identity and defaults** (name/email/editor/branch)
- Add **Zsh aliases**
- Install **NVM (Node Version Manager)**
- Install **Node.js LTS**

Git configuration applied:

```bash
init.defaultBranch = main
core.editor = cursor
pull.rebase = false
```

### SSH setup for GitHub (macOS)

Run:

```bash
chmod +x macos/scripts/ssh-setup.sh
bash macos/scripts/ssh-setup.sh
```

This will:

- Create `~/.ssh` if needed
- Generate an **ed25519 SSH key** with email `code@dmadridy.com`
- Configure SSH for GitHub
- Add the key to the SSH agent
- Print your public key so you can add it to GitHub

Add the printed key at:

```bash
https://github.com/settings/keys
```

Then verify:

```bash
ssh -T git@github.com
```

You should see a greeting confirming successful authentication.

### Setting up Cursor on macOS

After installing Cursor:

```bash
chmod +x macos/scripts/setup.sh
bash macos/scripts/setup.sh
```

This will:

1. Install all Cursor extensions listed in `macos/config/extensions.txt`
2. Apply editor settings from `macos/config/settings.json`

Restart Cursor after running the script.

### Setting up VSCode on macOS

After installing VSCode and ensuring the `code` command is available:

```bash
chmod +x macos/scripts/setup-vscode.sh
bash macos/scripts/setup-vscode.sh
```

This will:

1. Install all VSCode extensions listed in `macos/config/extensions.txt`
2. Apply editor settings from `macos/config/settings.json` into your VSCode user configuration

Restart VSCode after running the script.

If the `code` CLI is not available:

1. Open VSCode.
2. Open the Command Palette (`Cmd + Shift + P`).
3. Run: `Shell Command: Install 'code' command in PATH`.
4. Restart your terminal and verify:

```bash
code --version
```

### Exporting Cursor configuration (macOS)

If you change settings or extensions locally and want to persist them into this repo:

```bash
chmod +x macos/scripts/export.sh
bash macos/scripts/export.sh
```

This updates:

- `macos/config/settings.json`
- `macos/config/extensions.txt`

Commit and push the changes from the repo root.

### Keeping multiple macOS machines in sync

Typical flow:

- **On Machine A (where you tweak the setup)**:

```bash
cd dev-setup
git pull
bash macos/scripts/export.sh
git add .
git commit -m "update macOS cursor config"
git push
```

- **On Machine B (to apply the latest config)**:

```bash
cd dev-setup
git pull
bash macos/scripts/setup.sh
```

### Cursor CLI on macOS

The setup and export scripts require the `cursor` CLI.

If `cursor` is not available:

1. Open Cursor.
2. Open the Command Palette (`Cmd + Shift + P`).
3. Run: `Shell Command: Install 'cursor' command in PATH`.
4. Restart your terminal and verify:

```bash
cursor --version
```

### Zsh aliases (macOS)

`macos/scripts/bootstrap.sh` adds a small set of helpful aliases to your `~/.zshrc`:

```bash
alias gs="git status"
alias gc="git commit"
alias gp="git push"
alias ga="git add ."
alias ll="ls -la"
```

These are intended to speed up day-to-day terminal work on macOS.
