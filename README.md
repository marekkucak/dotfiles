# Zsh Developer Shell

This repository configures **Zsh as a fast developer shell** optimized for:

* AI-assisted coding
* large Git repositories
* tmux-based development
* command-line workflows
* Databricks / Python / infrastructure work

The goal is **speed and ergonomics**, not heavy shell frameworks.

Key tools used:

| Tool                      | Purpose                                   |
| ------------------------- | ----------------------------------------- |
| Zsh native completion     | fast TAB completion                       |
| `fzf`                     | fuzzy finder for files, history and paths |
| `fzf-tab`                 | interactive completion UI                 |
| `zoxide`                  | intelligent `cd` replacement              |
| `atuin`                   | advanced shell history                    |
| `direnv`                  | project-specific environment variables    |
| `zsh-autosuggestions`     | inline command suggestions                |
| `zsh-syntax-highlighting` | highlight mistakes before execution       |
| `starship`                | lightweight prompt                        |

---

# Installation

Clone the repository and run bootstrap:

```bash
git clone https://github.com/marekkucak/dotfiles.git
cd dotfiles
bash bootstrap/install.sh
exec zsh
```

The bootstrap script installs:

* zsh
* tmux
* fzf
* direnv
* zsh plugins
* development tools

and creates symlinks for:

```
~/.zshrc
~/.zshenv
~/.tmux.conf
~/.config/nvim
```

---

# Zsh Usage Guide

## TAB Completion

Zsh completion is configured for:

* interactive selection
* case-insensitive matching
* completion caching
* grouped output

Example:

```
git che<TAB>
```

Shows:

```
checkout
cherry-pick
check-ignore
```

With **fzf-tab**, you can search the completion list.

---

# Fuzzy Finder (fzf)

`fzf` enables fuzzy search across the shell.

## History search

Press:

```
CTRL + R
```

Search previous commands interactively.

Example:

```
pytest
```

Find all previous pytest commands.

---

## File selection

Press:

```
CTRL + T
```

This inserts a file path into the command.

Example:

```
vim <CTRL-T>
```

Pick a file.

---

## Directory jump

Press:

```
ALT + C
```

Select a directory and jump to it.

---

## Fuzzy completion

You can search for files using:

```
vim **<TAB>
```

or

```
cd **<TAB>
```

This opens a fuzzy search for matching paths.

---

# zoxide – smarter `cd`

`zoxide` remembers frequently used directories.

Instead of:

```
cd ~/dev/projects/my-long-project-name
```

You can use:

```
z project
```

or

```
z dotfiles
```

The more often you visit a directory, the easier it becomes to jump there.

---

# Atuin – better shell history

Atuin replaces the basic shell history.

Benefits:

* full-text search
* context aware history
* shared history across sessions
* faster recall of long commands

Use:

```
CTRL + R
```

to search history.

---

# direnv – project environments

`direnv` automatically loads environment variables for a project.

Example `.envrc`:

```
layout python
export OPENAI_API_KEY=...
```

Activate:

```
direnv allow
```

Now the environment loads automatically when entering the directory.

This avoids polluting `~/.zshrc` with project-specific configuration.

---

# Autosuggestions

Inline suggestions appear based on command history.

Example:

```
git che
```

Suggestion:

```
git checkout main
```

Accept suggestion with:

```
→ (right arrow)
```

---

# Syntax highlighting

Commands are highlighted before execution.

Example:

```
git chec
```

will appear in **red** because the command does not exist.

This helps prevent mistakes.

---

# Repository navigation helpers

Several helper commands are provided.

## `p`

Search repositories and jump to one.

```
p
```

Select repository using fuzzy search.

---

## `pw`

Open a repository and start the **tmux developer cockpit**.

```
pw
```

---

# AI Development Helpers

These shortcuts help with AI-driven development workflows.

## Open agent rules

```
vagents
```

Opens:

```
AGENTS.md
```

---

## Open latest specification

```
vspec
```

Opens newest file in:

```
docs/specs
```

---

## Open architecture decision records

```
vadr
```

Opens newest file in:

```
docs/adrs
```

---

# Git helpers

Useful aliases:

| Alias | Command         |
| ----- | --------------- |
| `gs`  | git status      |
| `gd`  | git diff        |
| `gds` | git staged diff |
| `gl`  | git log graph   |

---

# Development workflow shortcuts

For repositories using the AI coding workflow:

```
spec → plan → implement → verify → integrate
```

Aliases are provided:

| Alias   | Command                |
| ------- | ---------------------- |
| `pint`  | `make pre-integration` |
| `vfy`   | `make verify`          |
| `integ` | `make integration`     |

Example cycle:

```
vspec
pint
gd
vfy
```

---

# tmux Developer Cockpit

The repository includes a script:

```
twork
```

It creates a tmux workspace with panes for:

* editor
* terminal
* git
* tests

Example:

```
twork .
```

---

# Philosophy

This setup follows a few principles:

1. **Terminal first**
2. **Keyboard driven**
3. **Fast startup**
4. **Minimal shell frameworks**
5. **Composable tools**

The shell is intentionally kept lightweight while integrating powerful utilities.

---

# Future Improvements

Planned additions:

* git-aware repo jump
* interactive project selector
* Databricks CLI integration
* AI-coding command helpers

---
```
Zsh
   ↓
fzf / zoxide / atuin
   ↓
tmux cockpit
   ↓
Neovim IDE
   ↓
AI coding agents
```

