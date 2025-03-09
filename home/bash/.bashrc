alias vim="nvim"

# eval "$(direnv hook bash)"

if command -v fzf-share >/dev/null; then
  source "$(fzf-share)/key-bindings.bash"
  source "$(fzf-share)/completion.bash"
fi

function _update_ps1() {
    PS1="$(powerline-go -newline -hostname-only-if-ssh -theme low-contrast -error $? -jobs $(jobs -p | wc -l))"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
fi

. "$HOME/.local/bin/env"
