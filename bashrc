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

TOKEN=at4jWDraNaTZzCF38T81CUDWmQDUBc
USER_KEY=uom5JvaizujLSWQRDGsf6cx7QrpnoA


function push {
   lastCommand="$(history | tail -n1 | cut -d ' ' -f 6 | citu -d ';' -f 0)"
   lastReturn=$?
   if [ $lastReturn -eq 0  ]; then
       title="Command Success"
   else
       title="Command Failure"
   fi
   curl -s -F "token=$TOKEN" \
   -F "user=$USER_KEY" \
   -F "title=$title" \
   -F "message=$lastCommand on $(hostname)" https://api.pushover.net/1/messages.json
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
