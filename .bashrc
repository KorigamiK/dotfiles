[[ "$-" != *i* ]] && return

# Keep Windows-installed CLI tools available inside MSYS2 when launched with
# msys2_shell.cmd -use-full-path.
if [ -n "$USERPROFILE" ]; then
  win_userprofile="$(cygpath -u "$USERPROFILE" 2>/dev/null)"

  if [ -n "$win_userprofile" ]; then
    winget_links="$win_userprofile/AppData/Local/Microsoft/WinGet/Links"
    cargo_bin="$win_userprofile/.cargo/bin"

    [ -d "$winget_links" ] && PATH="$PATH:$winget_links"
    [ -d "$cargo_bin" ] && PATH="$PATH:$cargo_bin"
  fi

  unset win_userprofile winget_links cargo_bin
fi

export PATH

if [ -z "$VSCODE_GIT_IPC_HANDLE" ] && [ "$TERM_PROGRAM" != "vscode" ]; then
  export EDITOR="nvim"
  export VISUAL="nvim"
fi

eval "$(fzf --bash)"

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

alias ll='ls -lah --color=auto'

alias vim=nvim
alias q=exit
alias lg=lazygit

export VISUAL=nvim
