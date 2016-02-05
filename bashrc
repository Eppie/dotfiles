# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export JAVA_HOME="/usr/java/latest"

google () {
	search=""
	echo "Googling: $@"
	for term in $@
	do
		search="$search%20$term"
	done
	w3m "http://www.google.com/search?q=$search"
}

alias g='google'
alias define='sdcv'
alias d='define'
alias xdg-open='gnome-open'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -al'
alias cd..='cd ..'
alias mkdir='mkdir -pv'
alias bc='bc -l'
alias grep='grep --color=auto'
alias vi='vim'
alias gs='git status'
alias gp='git pull'

cls() { cd "$1"; ll; }

function push {
	lastReturn=$?
	lastCommand=$(history | tail -n1 | tr -s ' ' | cut -d ' ' -f 3- | sed "s/\"/'/g")
	if [ $lastReturn -eq 0  ]; then
		title="Success on $(hostname)"
	else
		title="Failure on $(hostname)"
	fi
	curl https://api.pushbullet.com/v2/pushes -X POST \
		-u o.lSFrtwyYsNkkSp9Jm9M2MNpjj7e8AnnU: \ # my key
		--header "Content-Type: application/json" \
		--data-binary "{\"type\": \"note\", \"title\":\"$title\", \"body\": \"$lastCommand\"}" \
		&> /dev/null
}

extract() {
	local c e i

	(($#)) || return

	for i; do
		c=''
		e=1

		if [[ ! -r $i ]]; then
			echo "$0: file is unreadable: \`$i'" >&2
			continue
		fi

		case $i in
			*.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
				c=(tar xvf);;
			*.7z)  c=(7z x);;
			*.Z)   c=(uncompress);;
			*.bz2) c=(bunzip2);;
			*.exe) c=(cabextract);;
			*.gz)  c=(gunzip);;
			*.rar) c=(unrar x);;
			*.xz)  c=(unxz);;
			*.zip) c=(unzip);;
			*)     echo "$0: unrecognized file extension: \`$i'" >&2
				continue;;
		esac

		command "${c[@]}" "$i"
		((e = e || $?))
	done
	return "$e"
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
