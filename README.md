# dev-stack-dotfiles (WSL Ubuntu)

Minimal reproducible development cockpit for tmux + Neovim + agentic coding workflows.

Reproducible terminal-first dev cockpit for agentic coding:

- **Zsh** (lightweight, fast)
- **tmux** (project cockpit + Catppuccin + TPM)
- **Neovim** (lazy.nvim, Telescope + fzf-native, Harpoon, Oil, Flash, Mason, LSP, format/lint, Diffview, Neotest, Copilot + CopilotChat)
- **twork**: project launcher that creates a consistent tmux workspace per repo

Designed for **WSL + Windows Terminal**.

---

## Quick install

### 1) Clone the repo

```bash
git clone <YOUR_REPO_URL> /mnt/c/Repos/dev-stack-dotfiles
cd /mnt/c/Repos/dev-stack-dotfiles
```

### 2) Run bootstrap
```bash
bash bootstrap/install.sh
```

### 3) Restart your shell
```bash
exec zsh
```

### 4) tmux plugins (first time only)

Start tmux:

```bash
tmux
```

Install plugins: press `Ctrl-a`, then `I` (capital i)

### 5) Neovim plugins

Start Neovim:

```bash
nvim
```

Install/update plugins:

Run `:Lazy sync`

Install LSP servers:

Run `:Mason`

Ensure `pyright` and `lua_ls` are installed

## Git configuration

This repository does not manage `~/.gitconfig`.

Git identity is intentionally left to the user because:

- many developers use different identities (work vs personal)
- overriding `~/.gitconfig` can break existing setups
- commit email should match your GitHub/GitLab account

If Git complains about missing identity, configure it manually:

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

Verify:

```bash
git config --global --list
```

## What bootstrap links on your machine

The install script symlinks these files so your machine uses the repo version:

- `~/.tmux.conf` → `tmux/tmux.conf`
- `~/.config/nvim` → `nvim/`
- `~/.local/bin/twork` → `bin/twork`
- `~/.zshrc` → `zsh/zshrc`
- `~/.zshenv` → `zsh/zshenv`

Git configuration (`~/.gitconfig`) is intentionally NOT managed by this repository.

This means: update a file in the repo → your live setup updates immediately.

## tmux keys

Prefix: `Ctrl-a`

### Splits

- `Ctrl-a |` : split (left/right)
- `Ctrl-a -` : split (top/bottom)

### Move between panes

- `Ctrl-a h/j/k/l`

### Move between windows (tabs)

- `Ctrl-a Ctrl-h` : previous window
- `Ctrl-a Ctrl-l` : next window

### Resize panes

- `Ctrl-a H/J/K/L`

### Reload tmux config

- `Ctrl-a r`

### Copy to Windows clipboard (copy-mode-vi)

1. Enter copy-mode (default tmux keybind is usually `Ctrl-a [`)
2. Select text
3. Press `y` to copy via `clip.exe`

## Project cockpit: twork

Launch a project session:

```bash
twork /mnt/c/Repos/dev-stack
```

Creates a tmux session named after the folder with windows:

- `brief` (opens `AGENTS.md` if present)
- `code` (opens `nvim .`)
- `verify`
- `run`
- `git` (runs `git status`)
- `agent`
- `logs`

This is the core “cockpit” idea: each repo has a consistent workspace layout.

## Neovim keys

Leader: `Space`

### Navigation (Telescope)

- `<leader>ff` : find files (git root if available)
- `<leader>fg` : live grep
- `<leader>fb` : buffers
- `<leader>fr` : recent files

### Harpoon

- `<leader>ha` : add file
- `<leader>hh` : menu
- `<leader>1..4` : jump to slots

### Oil

- `-` : open parent directory

### Flash

- `<leader>j` : quick jump

### LSP

- `gd` : definition
- `gr` : references
- `K` : hover
- `<leader>rn` : rename
- `<leader>ca` : code action
- `[d` / `]d` : prev/next diagnostic
- `<leader>fd` : line diagnostics

### Format / lint

- `<leader>cf` : format buffer
- `<leader>cl` : lint buffer now

### Git review

- `<leader>gd` : Diffview open
- `<leader>gq` : Diffview close
- `<leader>gh` : file history

### Tests (neotest)

- `<leader>tn` : run nearest
- `<leader>tf` : run file
- `<leader>ts` : toggle summary
- `<leader>to` : open output

### AI

- Copilot accept: `Ctrl-l` (insert mode)
- CopilotChat: `<leader>cc`

## Agentic coding workflow (how to use this stack)

This stack is designed for “spec → implement → verify → review” loops with an AI agent.

### Recommended loop per ticket

1.  **brief window**
    - open `AGENTS.md`
    - open or create a ticket/spec file (e.g. `docs/specs/TICKET-123.md`)
    - write a tight definition of done (DoD)
2.  **agent window**
    - run Copilot CLI (or your allowed agent tool)
    - give it the spec + repo rules (`AGENTS.md`) and request a small diff
3.  **code window**
    - inspect/edit the changes in Neovim
4.  **verify window**
    - run tests, lint, typecheck
5.  **git window**
    - review changes (`git status`, `git diff`)
    - open Diffview in Neovim for review (`<leader>gd`)
6.  **logs/run windows**
    - run server / tail logs if needed

### Why tmux matters for agentic coding

Agentic tools often need:

- a stable working directory,
- long-running commands,
- dedicated panes/windows for logs/tests.

`tmux` gives you that structure and makes “agent + human review + verification” smooth and repeatable.

## Notes / philosophy

- Search-first workflow (Telescope + Harpoon) is faster than file trees for coding flow.
- Tree-sitter intentionally omitted for stability; regex highlighting is sufficient for this workflow.
- LSP uses Neovim 0.11+ native API with Mason managing server binaries.
