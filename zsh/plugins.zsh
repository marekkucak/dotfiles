# zsh/plugins.zsh

# ---------- Completion init ----------
autoload -Uz compinit
compinit -d "$HOME/.cache/zsh/.zcompdump"

# ---------- fzf shell integration ----------
if command -v fzf >/dev/null 2>&1; then
  if fzf --zsh >/dev/null 2>&1; then
    source <(fzf --zsh)
  else
    [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
    [[ -f /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh
  fi
fi

# ---------- fzf-tab ----------
# Must be after compinit and before autosuggestions/syntax-highlighting
if [[ -f "$HOME/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh" ]]; then
  source "$HOME/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh"

  # Keep completion snappy: no heavy previews by default
  zstyle ':fzf-tab:*' switch-group ',' '.'
fi

# ---------- Prompt ----------
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# ---------- Per-project env ----------
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"

# ---------- Smart cd ----------
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# ---------- Better history ----------
command -v atuin >/dev/null 2>&1 && eval "$(atuin init zsh)"

# ---------- Autosuggestions ----------
if [[ -f "$HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_USE_ASYNC=1
fi

# ---------- Syntax highlighting ----------
# Must stay last
if [[ -f "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
