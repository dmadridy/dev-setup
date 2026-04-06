# Dev Setup

This repository stores a reproducible configuration for the **Cursor editor** and a minimal **development environment bootstrap** for **macOS only**.

It allows you to quickly configure a new Mac with:

- Cursor settings and extensions
- Git configuration
- Zsh shell aliases
- Node.js via NVM
- Homebrew
- Optional GitHub SSH authentication

The repository is the **single source of truth** for this environment.

## Structure

- **`config/`** — Cursor settings (`settings.json`) and extension list (`extensions.txt`).
- **`scripts/`** — Bootstrap, SSH setup, apply config to Cursor, and export from Cursor.

---

## Prerequisites

- **Git** — [git-scm.com/downloads](https://git-scm.com/downloads)
- **Cursor** — installed, with the `cursor` CLI on your `PATH` (Command Palette → *Shell Command: Install 'cursor' command in PATH*)

---

## Auth and cloning

Clone over **HTTPS** first (works before SSH is set up):

```bash
git clone https://github.com/dmadridy/cursor-setup.git
cd cursor-setup
```

- You can keep using **HTTPS** only.
- **Optionally**, after SSH setup below, switch the remote:

```bash
git remote set-url origin git@github.com:dmadridy/cursor-setup.git
```

---

## Scripts

All scripts live in **`scripts/`**:

| Script | Purpose |
|--------|---------|
| `bootstrap.sh` | Homebrew, Git config, Zsh aliases, NVM, Node LTS |
| `ssh-setup.sh` | SSH key for GitHub |
| `setup.sh` | Apply `config/` to Cursor and install extensions |
| `export.sh` | Copy local Cursor config back into `config/` |

### Bootstrapping a new Mac

From the repo root:

```bash
chmod +x scripts/bootstrap.sh
bash scripts/bootstrap.sh
```

This installs **Homebrew**, configures **Git** (name/email/defaults), adds **Zsh aliases**, installs **NVM** and **Node.js LTS**.

Git defaults applied:

```bash
init.defaultBranch = main
core.editor = cursor
pull.rebase = false
```

### SSH setup for GitHub

```bash
chmod +x scripts/ssh-setup.sh
bash scripts/ssh-setup.sh
```

Creates `~/.ssh` if needed, generates an **ed25519** key (comment `code@dmadridy.com`), configures GitHub in `~/.ssh/config`, adds the key to the agent, and prints the public key. Add it at [github.com/settings/keys](https://github.com/settings/keys), then:

```bash
ssh -T git@github.com
```

### Setting up Cursor

```bash
chmod +x scripts/setup.sh
bash scripts/setup.sh
```

1. Installs extensions listed in `config/extensions.txt`
2. Copies `config/settings.json` into Cursor’s user folder

Restart Cursor afterward.

### Cursor CLI

If `cursor` is missing:

1. Cursor → Command Palette (`Cmd + Shift + P`)
2. *Shell Command: Install 'cursor' command in PATH*
3. Restart the terminal → `cursor --version`

### Exporting Cursor configuration

After changing settings or extensions in Cursor:

```bash
chmod +x scripts/export.sh
bash scripts/export.sh
```

Updates `config/settings.json` and `config/extensions.txt`. Commit and push from the repo root.

### Keeping multiple Macs in sync

**Machine A** (where you change the setup):

```bash
cd cursor-setup
git pull
bash scripts/export.sh
git add .
git commit -m "update cursor config"
git push
```

**Machine B**:

```bash
cd cursor-setup
git pull
bash scripts/setup.sh
```

### Zsh aliases

`scripts/bootstrap.sh` appends to `~/.zshrc` (once):

```bash
alias gs="git status"
alias gc="git commit"
alias gp="git push"
alias ga="git add ."
alias ll="ls -la"
```
