# zsh/functions.zsh

# Roots searched by the repo picker
typeset -ga REPO_ROOTS
REPO_ROOTS=(
  "$HOME/dev"
  "/mnt/c/Repos"
)

# Pick a repo and cd into it
p() {
  local dir
  dir="$(
    for root in "${REPO_ROOTS[@]}"; do
      [[ -d "$root" ]] || continue
      find "$root" -maxdepth 4 -type d -name .git -prune -print 2>/dev/null | sed 's#/.git$##'
    done | sort -u | fzf
  )"
  [[ -n "$dir" ]] && cd "$dir"
}

# Pick a repo and launch the tmux cockpit
pw() {
  p || return
  command -v twork >/dev/null 2>&1 && twork "$PWD"
}

# Open AGENTS.md in the current repo
vagents() {
  if [[ -f AGENTS.md ]]; then
    "$EDITOR" AGENTS.md
  else
    printf "AGENTS.md not found in %s\n" "$PWD"
  fi
}

# Open the newest spec in docs/specs
vspec() {
  local f
  f="$(find docs/specs -type f 2>/dev/null | sort | tail -n 1)"
  if [[ -n "$f" ]]; then
    "$EDITOR" "$f"
  else
    printf "No spec files found under docs/specs\n"
  fi
}

# Open the newest ADR in docs/adrs
vadr() {
  local f
  f="$(find docs/adrs -type f 2>/dev/null | sort | tail -n 1)"
  if [[ -n "$f" ]]; then
    "$EDITOR" "$f"
  else
    printf "No ADR files found under docs/adrs\n"
  fi
}

# Show changed files and diff summary
diffscope() {
  if [[ -x ./scripts/diffscope ]]; then
    ./scripts/diffscope
  else
    git diff --name-only --minimal
    echo
    git diff --stat --minimal
  fi
}

# Convenience helper
mkcd() {
  mkdir -p "$1" && cd "$1"
}
