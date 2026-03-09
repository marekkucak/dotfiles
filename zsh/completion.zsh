# zsh/completion.zsh

# Extra completions must be on fpath before compinit
if [[ -d "$HOME/.config/zsh/plugins/zsh-completions/src" ]]; then
  fpath=("$HOME/.config/zsh/plugins/zsh-completions/src" $fpath)
fi

zmodload zsh/complist

# Better completion UX
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Be forgiving
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# Cache completions
mkdir -p "$HOME/.cache/zsh" "$HOME/.zcompcache"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zcompcache"

# More useful completion behavior
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{magenta}%d%f'
zstyle ':completion:*:warnings' format '%F{red}no matches for:%f %d'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' special-dirs true
