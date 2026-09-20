# Esto va en /etc/zsh/zshenv
# if [[ -z "$XDG_CONFIG_HOME" ]]
# then
#     export XDG_CONFIG_HOME="$HOME/.config"
# fi
#
# if [[ -d "$XDG_CONFIG_HOME/zsh" ]]
# then
#     export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
# fi

# Add all directories in `~/.local/bin` to $PATH
PATH="${PATH}:$HOME/.local/bin"
# unsetopt PROMPT_SP 2>/dev/null

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="footclient"
export BROWSER="firefox"
export MANPAGER='nvim +Man!'

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export GPG_TTY=$(tty)

export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"
export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
# export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"

# Other program settings:
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export LESS="-R"
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export MOZ_USE_XINPUT2="1" # Mozilla smooth scrolling/touchpads.
export ELECTRON_OZONE_PLATFORM_HINT=auto

[ ! -f "$XDG_CONFIG_HOME/shell/shortcutrc" ] && setsid shortcuts >/dev/null 2>&1
