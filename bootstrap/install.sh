#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

say() { printf "\n\033[1;32m==>\033[0m %s\n" "$*"; }

say "Installing packages (Ubuntu)..."
sudo apt-get update -y
sudo apt-get install -y \
  git curl ca-certificates unzip \
  tmux ripgrep fd-find \
  make gcc g++ \
  python3 python3-venv python3-pip \
  shellcheck

# fd is called fdfind on Ubuntu sometimes
if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
  sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd || true
fi

say "Creating dirs"
mkdir -p "$HOME/.config" "$HOME/.local/bin"

say "Symlinking tmux"
ln -sf "$REPO_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

say "Symlinking nvim"
rm -rf "$HOME/.config/nvim"
ln -sf "$REPO_DIR/nvim" "$HOME/.config/nvim"

say "Symlinking twork"
ln -sf "$REPO_DIR/bin/twork" "$HOME/.local/bin/twork"
chmod +x "$REPO_DIR/bin/twork"

say "Optional: zsh if present"
[ -f "$REPO_DIR/zsh/zshrc" ] && ln -sf "$REPO_DIR/zsh/zshrc" "$HOME/.zshrc"
[ -f "$REPO_DIR/zsh/zprofile" ] && ln -sf "$REPO_DIR/zsh/zprofile" "$HOME/.zprofile"
[ -f "$REPO_DIR/zsh/zshenv" ] && ln -sf "$REPO_DIR/zsh/zshenv" "$HOME/.zshenv"

say "Done."