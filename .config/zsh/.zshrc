stty stop undef # Stop terminal from freezing
stty start undef

# Duan's config for the Zoomer Shell
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|sudo sdn|sdn|history|cd -|cd ..)"
export SUDO_PROMPT="Cual es tu contraseña %u? nwn: "

autoload -U colors && colors	# Load colors

setopt interactive_comments
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt LIST_PACKED		   # The completion menu takes less space.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

source <(fzf --zsh)
bindkey '^R' fzf-history-widget

# Basic auto/tab complete:
autoload -Uz compinit
compinit -C -d ~/.cache/zsh/zcompdump

# --------- Gentoo ---------
# Correction
setopt correctall

# Prompt
autoload -U promptinit
promptinit
prompt gentoo

zstyle ':completion::complete:*' use-cache 1
# -------------------------

autoload -Uz add-zsh-hook
_comp_options+=(globdots)

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list \
    'm:{a-zA-Z}={A-Za-z}' \
    '+r:|[._-]=* r:|=*' \
    '+l:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No hay matches para:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'

expand-or-complete-with-dots() {
    echo -n "\e[31m…\e[0m"
    zle expand-or-complete
    zle redisplay
}

zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots # ^I es tab

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q' ;;      # block
        viins|main) echo -ne '\e[5 q' ;; # beam
    esac
}

zle -N zle-keymap-select

function zle-beam-init () {
    zle -K viins
    echo -ne '\e[5 q'
}

zle -N zle-beam-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor on startup.

# ^? y ^H son backspace dependiendo de la terminal
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# ^[[3~ es tecla suprimir
# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^?' vi-delete-char
bindkey -M vicmd '^H' vi-delete-char
bindkey -M visual '^?' vi-delete
bindkey -M visual '^H' vi-delete

# command not found
command_not_found_handler() {
    printf "Comando %s%s no encontrado... unu\n" "$acc" "$0" >&2
    return 127
}

con() {
    cd ~/.config || exit
    selected_file=$(fzf --color="light") || return # Return if no selection
    cd "$(dirname "$selected_file")" || exit
    $EDITOR "$(basename "$selected_file")" # Open the file
}

se() {
    cd ~/.local/bin || exit
    $EDITOR "$(fzf --color="light")"
}

# ^[[A es flecha arriba
# ^[[B es flecha abajo
bindkey '^[[A' history-substring-search-up # or '\eOA'
bindkey '^[[B' history-substring-search-down # or '\eOB'
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

bindkey -s '^o' 'y\n'
bindkey -s '^f' 'con\n'
bindkey -s '^s' 'se\n'

# Configuración manual de git status
autoload -Uz vcs_info
precmd () { vcs_info }

zstyle ':vcs_info:*'     enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '%F{red}[✘!]%f'
zstyle ':vcs_info:git:*' stagedstr '%F{green}[✘+]%f'
zstyle ':vcs_info:git:*' formats       'on %F{magenta} %b %u%c%f'
zstyle ':vcs_info:git:*' actionformats 'on %F{magenta} %b %u%c% %af'

setopt PROMPT_SUBST        # enable command substitution in prompt

# para gentoo
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
source /usr/share/zsh/site-functions/_zsh-history-substring-search
source /usr/share/zsh/site-functions/zsh-autocomplete
source /usr/share/zsh/site-functions/zsh-autosuggestions.zsh

# fnm
FNM_PATH="/home/utane/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi

# pnpm
export PNPM_HOME='/home/utane/.local/share/pnpm'
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
