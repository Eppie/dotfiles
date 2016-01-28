# Setup fzf
# ---------
if [[ ! "$PATH" == *~/.fzf/bin* ]]; then
  export PATH="$PATH:~/.fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == *~/.fzf/man* && -d "~/.fzf/man" ]]; then
  export MANPATH="$MANPATH:~/.fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source $(eval echo "~/.fzf/shell/completion.bash") 2> /dev/null

# Key bindings
# ------------
source $(eval echo "~/.fzf/shell/key-bindings.bash")

