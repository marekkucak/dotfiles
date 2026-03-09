# zsh/aliases.zsh

alias vim='nvim'
alias v='nvim'

alias ta='tmux attach -t'
alias tls='tmux ls'

alias gs='git status -sb'
alias gd='git diff --minimal'
alias gds='git diff --staged --minimal'
alias gdc='git diff --cached --minimal'
alias gl='git log --oneline --decorate --graph --all'

command -v eza >/dev/null 2>&1 && alias ls='eza --group-directories-first --icons'
command -v eza >/dev/null 2>&1 && alias ll='eza -lah --group-directories-first --icons'

if command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never'
elif command -v batcat >/dev/null 2>&1; then
  alias bat='batcat'
  alias cat='batcat --paging=never'
fi

command -v fzf >/dev/null 2>&1 && alias ff='fzf'

alias vfy='make verify'
alias vfyf='make verify-full'
alias pint='make pre-integration'
alias integ='make integration'
