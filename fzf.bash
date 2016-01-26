# Setup fzf
# ---------
if [[ ! "$PATH" == */home/eppie/.fzf/bin* ]]; then
  export PATH="$PATH:/home/eppie/.fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */home/eppie/.fzf/man* && -d "/home/eppie/.fzf/man" ]]; then
  export MANPATH="$MANPATH:/home/eppie/.fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/eppie/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/eppie/.fzf/shell/key-bindings.bash"

