# Cursor Setup

This repository stores a reproducible configuration for the **Cursor editor** and a minimal **development environment bootstrap**.

It allows you to quickly configure a new machine with:

- Cursor settings
- Cursor extensions
- Git configuration
- Zsh shell aliases
- Node.js via NVM
- Homebrew package manager

The repository acts as the **single source of truth** for your development environment.

---

# Repository Structure

```
cursor-setup
├─ cursor
│  ├─ settings.json
│  └─ extensions.txt
├─ setup.sh
├─ export.sh
├─ bootstrap.sh
└─ README.md
```

### Files

**cursor/settings.json**
Contains all Cursor editor settings.

**cursor/extensions.txt**
List of installed Cursor extensions.

**setup.sh**
Installs Cursor extensions and applies editor settings.

**export.sh**
Exports the current local Cursor configuration into the repository.

**bootstrap.sh**
Sets up the base development environment on a new machine.

---

# First Time Setup

Clone the repository:

```
git clone https://github.com/YOUR_USERNAME/cursor-setup.git
cd cursor-setup
```

Make scripts executable:

```
chmod +x setup.sh
chmod +x export.sh
chmod +x bootstrap.sh
```

---

# Bootstrapping a New Machine

The `bootstrap.sh` script installs and configures the core development environment.

Run:

```
bash bootstrap.sh
```

This script will automatically:

- Install **Homebrew**
- Install **Git**
- Configure **Git identity and defaults**
- Add **Zsh aliases**
- Install **NVM (Node Version Manager)**
- Install **Node.js LTS**

### Git configuration applied

```
init.defaultBranch = main
core.editor = cursor
pull.rebase = false
```

You should update your personal identity in the script if needed.

---

# Setting Up Cursor

After installing Cursor, run:

```
bash setup.sh
```

The script will:

1. Install all Cursor extensions listed in `cursor/extensions.txt`
2. Apply the editor settings from `cursor/settings.json`

Restart Cursor after running the script.

Your editor will now match the configuration stored in this repository.

---

# Updating the Configuration

If you change settings or install new extensions on your machine, export them back into the repository.

Run:

```
cd cursor-setup
bash export.sh
```

This updates:

- `cursor/settings.json`
- `cursor/extensions.txt`

Commit and push the changes:

```
git add .
git commit -m "update cursor config"
git push
```

---

# Updating the Configuration From Any Machine

Any machine that has this repository cloned can update the configuration and push changes.

The repository is the **single source of truth**, so improvements made on any machine can be shared with all others.

### Step 1 — Pull the latest changes

Always pull before making changes to avoid conflicts.

```
cd cursor-setup
git pull
```

### Step 2 — Make changes

Examples:

- Install or remove Cursor extensions
- Change Cursor settings
- Modify `bootstrap.sh`
- Update Zsh aliases
- Improve scripts

### Step 3 — Export Cursor configuration (if settings or extensions changed)

```
bash export.sh
```

### Step 4 — Commit and push

```
git add .
git commit -m "update development environment"
git push
```

Other machines can then update their environment by running:

```
git pull
bash setup.sh
```

This workflow ensures that every machine stays synchronized with the latest configuration.

---

# Typical Workflow

### Machine A (where changes happen)

```
cd cursor-setup
bash export.sh
git add .
git commit -m "update cursor config"
git push
```

### Machine B (update environment)

```
cd cursor-setup
git pull
bash setup.sh
```

---

# Cursor CLI Requirement

The setup scripts require the `cursor` command line interface.

If the command is not available, install it from Cursor.

Open the Command Palette:

```
Cmd + Shift + P
```

Run:

```
Shell Command: Install 'cursor' command in PATH
```

Restart your terminal and verify:

```
cursor --version
```

---

# Zsh Configuration

The bootstrap script adds a small set of useful aliases:

```
alias gs="git status"
alias gc="git commit"
alias gp="git push"
alias ga="git add ."
alias ll="ls -la"
```

These improve everyday terminal workflow.

---

# Notes

- Extensions are installed using the Cursor CLI.
- Settings overwrite the existing local Cursor configuration.
- `bootstrap.sh` prepares the machine for development.
- `setup.sh` configures the Cursor editor itself.

Together they allow a new development machine to be ready in a few minutes.
