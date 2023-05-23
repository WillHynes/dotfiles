# Sample .bashrc for SUSE Linux
# Copyright (c) SUSE Software Solutions Germany GmbH

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

test -s ~/.alias && . ~/.alias || true

#ZJ_SESSIONS=$(zellij list-sessions)
#NO_SESSIONS=$(echo "${ZJ_SESSIONS}" | wc -l)
#
#if [ "${NO_SESSIONS}" -ge 2 ]; then
#    zellij attach \
#    "$(echo "${ZJ_SESSIONS}" | sk)"
#else
#   zellij attach -c
#fi

#if [[ $(echo $TMUX) == "" ]]; then
#	tmux attach
#fi


PS1="\e[1;33m \w \$ $(tput sgr0)"

ffh () {
	set count = 0
	if [[ $1 == "-f" ]];
	then
		while [ $count -lt 5 ]
		do count=$[$count+1]
		zellij run -f -- cd `ls -a | fzf --reverse`
		done
	else
		cd `ls -a | fzf --reverse`
	fi
	
}


# Greps through history, fuzzy finds it then runs that.
hsr () {
	if [[ $1 != "" ]];
	then 
		cat ~/.bash_history | grep $1 | fzf --reverse | while read line; do $line; done
	else
		cat ~/.bash_history | fzf --reverse | while read line; do $line; done
	fi

}
. "$HOME/.cargo/env"

cheat () {
	curl cht.sh/$1
}

eval "$(starship init bash)"

#eval "$(zoxide init bash)"

new() {
	if [[ $(echo $1 | awk -F"." '/\./{print $2}' ) == "c" ]]; then
	       touch $1
	       echo "#include <stdio.h>" > $1
	       echo "#include <stdlib.h>" >> $1
	fi	       
}

alias tldrf="tldr --list | fzf --preview \"tldr {1} --color=always\" --preview-window=right,70% --reverse | xargs tldr"
alias ls="exa"
alias docker="sudo docker"

note() {
	if [ ! -f ~/notes/$1 ]; then 
		touch ~/notes/$1.md
		echo "$1 | $(date)" >> ~/notes/$1
		edit ~/notes/$1
	else
		echo "$1 already exists"
	fi	
}


#export OPENSSL_DIR='/home/linuxbrew/.linuxbrew/Cellar/openssl@1.1/1.1.1t/'
