source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f$ '

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "^[OA" history-beginning-search-backward-end
bindkey "^[OB" history-beginning-search-forward-end

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"

eval "$(starship init zsh)"

alias emacs="emacs -nw"
alias ff="fastfetch --structure Title:Separator:OS:Host:Kernel:Uptime:Shell:Display:DE:WM:Terminal:CPU:GPU:Memory:Disk:Break:Colors"
alias clear='clear -x; printf "\e[3J"'
