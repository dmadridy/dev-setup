# Dev Setup

This repository stores a reproducible configuration for the **Cursor editor** and a minimal **development environment bootstrap**.

It allows you to quickly configure a new machine with:

- Cursor/VsCode settings
- Cursor/VsCode extensions
- Git configuration
- Zsh shell aliases
- Node.js via NVM
- Homebrew package manager
- GitHub SSH authentication

The repository acts as the **single source of truth** for your development environment.

---

# Prerequisites

Before using this setup, make sure you have:

- **Git** installed on your machine. You can download it from the official site: `https://git-scm.com/downloads`.

---

# Auth and Cloning the Repo

This repository should always be cloned **initially over HTTPS** so that it works on any machine, even before SSH is configured.

Clone the repo:

```bash
git clone https://github.com/dmadridy/dev-setup.git
cd dev-setup
```

From here:

- You can use the repo entirely over **HTTPS** (no SSH required).
- **Optionally**, you can configure SSH later (using the platform-specific instructions in `macos/` or `windows/`) and then switch the remote to SSH, for example:

```bash
git remote set-url origin git@github.com:dmadridy/dev-setup.git
```

SSH setup is optional and only needed if you prefer SSH-based Git operations.

For detailed OS-specific steps (including where to find and how to run the SSH setup script and other tooling), see the corresponding `README.md` inside `macos/` or `windows/`.
