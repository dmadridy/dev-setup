# Cursor Setup

This repository stores a reproducible configuration for the **Cursor editor**.
It allows you to install the same **settings and extensions** on any machine in seconds.

The repository acts as the **single source of truth** for your Cursor environment.

---

# Repository Structure

```
cursor-setup
├─ cursor
│  ├─ settings.json
│  └─ extensions.txt
├─ setup.sh
├─ export.sh
└─ README.md
```

### Files

**cursor/settings.json**
Contains all Cursor editor settings.

**cursor/extensions.txt**
List of all installed extensions.

**setup.sh**
Installs extensions and applies settings on a new machine.

**export.sh**
Exports the current local Cursor configuration into the repository.

---

# First Time Setup

Clone the repository:

```
git clone https://github.com/YOUR_USERNAME/cursor-setup.git
cd cursor-setup
```

Make the scripts executable:

```
chmod +x setup.sh
chmod +x export.sh
```

---

# Setting Up a New Computer

After installing **Cursor**, run the following:

```
git clone https://github.com/YOUR_USERNAME/cursor-setup.git
cd cursor-setup
bash setup.sh
```

The script will:

1. Install all Cursor extensions listed in `extensions.txt`
2. Apply the editor settings from `settings.json`

After running the script, restart Cursor.

Your environment will match the configuration stored in this repository.

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

The setup scripts use the `cursor` command line interface.

If the command is not available, install it from Cursor:

Open the Command Palette:

```
Cmd + Shift + P
```

Run:

```
Shell Command: Install 'cursor' command in PATH
```

After installing the command, restart your terminal.

Verify installation:

```
cursor --version
```

---

# Notes

- Extensions are installed using the Cursor CLI.
- Settings overwrite the existing local Cursor configuration.
- This repository can be extended to include additional development environment configuration if needed.
