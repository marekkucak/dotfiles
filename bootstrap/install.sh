#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

say() {
  printf "\n\033[1;32m==>\033[0m %s\n" "$*"
}

ensure_git_repo() {
  local url="$1"
  local dest="$2"

  if [[ -d "$dest/.git" ]]; then
    git -C "$dest" pull --ff-only
  else
    git clone --depth=1 "$url" "$dest"
  fi
}

say "Installing packages (Ubuntu / WSL)..."
sudo apt-get update -y
sudo apt-get install -y \
  git curl ca-certificates unzip \
  zsh tmux ripgrep fd-find fzf direnv \
  make gcc g++ \
  python3 python3-venv python3-pip \
  shellcheck

# fd is called fdfind on Ubuntu sometimes
if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
  sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd || true
fi

say "Creating directories"
mkdir -p \
  "$HOME/.config" \
  "$HOME/.config/zsh/plugins" \
  "$HOME/.cache/zsh" \
  "$HOME/.local/bin"

say "Installing zsh plugins"
ensure_git_repo "https://github.com/Aloxaf/fzf-tab.git" \
  "$HOME/.config/zsh/plugins/fzf-tab"

ensure_git_repo "https://github.com/zsh-users/zsh-autosuggestions.git" \
  "$HOME/.config/zsh/plugins/zsh-autosuggestions"

ensure_git_repo "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
  "$HOME/.config/zsh/plugins/zsh-syntax-highlighting"

ensure_git_repo "https://github.com/zsh-users/zsh-completions.git" \
  "$HOME/.config/zsh/plugins/zsh-completions"

say "Symlinking tmux"
ln -sf "$REPO_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

say "Symlinking nvim"
rm -rf "$HOME/.config/nvim"
ln -sf "$REPO_DIR/nvim" "$HOME/.config/nvim"

say "Symlinking twork"
ln -sf "$REPO_DIR/bin/twork" "$HOME/.local/bin/twork"
chmod +x "$REPO_DIR/bin/twork"

say "Symlinking zsh"
[[ -f "$REPO_DIR/zsh/zshrc" ]] && ln -sf "$REPO_DIR/zsh/zshrc" "$HOME/.zshrc"
[[ -f "$REPO_DIR/zsh/zshenv" ]] && ln -sf "$REPO_DIR/zsh/zshenv" "$HOME/.zshenv"

say "Done."
say "Restart your shell with: exec zsh"