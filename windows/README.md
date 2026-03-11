Windows-specific development environment configuration.

This folder contains everything needed to configure a Windows development machine using Cursor and VSCode, mirroring the macOS setup.

## Structure

- `config/`: Shared settings and extensions for Cursor and VSCode on Windows.
- `scripts/`: Helper scripts to apply these configurations on Windows.

## Prerequisites (Windows)

- **Git** installed (see global `README.md` for details).
- **Cursor** installed, with the `cursor` CLI available in your PATH.
- **VSCode** installed, with the `code` CLI available in your PATH.
- **Git Bash** (or another Bash-compatible shell) installed — scripts are written for Bash.

## Cloning the repository (Windows)

From a Git Bash (or any Bash) terminal:

```bash
git clone https://github.com/dmadridy/cursor-setup.git
cd cursor-setup
```

For auth and HTTPS vs SSH details, see the global `README.md` **“Auth and Cloning the Repo”** section.

## Scripts (Windows)

Windows scripts live in `windows/scripts`:

- `bootstrap.sh`: Placeholder for future Windows environment bootstrap logic.
- `ssh-setup.sh`: Creates and configures an SSH key for GitHub authentication.
- `setup.sh`: Applies Cursor settings and installs extensions from `windows/cursor/config`.
- `setup-vscode.sh`: Applies VSCode settings and installs extensions from `windows/vscode/config`.

> **Note:** Both Cursor and VSCode settings configure the integrated terminal to use **Git Bash** by default (via `terminal.integrated.defaultProfile.windows`).

### Setting up Cursor on Windows

After installing Cursor and ensuring the `cursor` CLI is available:

```bash
chmod +x windows/scripts/setup.sh
bash windows/scripts/setup.sh
```

This will:

1. Install all Cursor extensions listed in `windows/config/extensions.txt`
2. Apply editor settings from `windows/config/settings.json` (including Git Bash as the default integrated terminal)

Restart Cursor after running the script.

### Setting up VSCode on Windows

After installing VSCode and ensuring the `code` CLI is available:

```bash
chmod +x windows/scripts/setup-vscode.sh
bash windows/scripts/setup-vscode.sh
```

This will:

1. Install all VSCode extensions listed in `windows/config/extensions.txt`
2. Apply editor settings from `windows/config/settings.json` (including Git Bash as the default integrated terminal)

Restart VSCode after running the script.

If the `code` CLI is not available:

1. Open VSCode.
2. Open the Command Palette (Ctrl + Shift + P).
3. Run: `Shell Command: Install 'code' command in PATH`.
4. Restart your terminal and verify:

```bash
code --version
```

### SSH setup for GitHub (Windows)

Run from the repo root (in Git Bash):

```bash
chmod +x windows/scripts/ssh-setup.sh
bash windows/scripts/ssh-setup.sh
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

### Keeping multiple Windows machines in sync

Typical flow:

- **On Machine A (where you tweak the setup)**:

```bash
cd cursor-setup
git pull
bash windows/scripts/export.sh
git add .
git commit -m "update Windows cursor config"
git push
```

- **On Machine B (to apply the latest config)**:

```bash
cd cursor-setup
git pull
bash windows/scripts/setup.sh
```

