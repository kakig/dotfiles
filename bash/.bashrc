#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Bash options
HISTCONTROL=ignorespace

alias ls='ls -v --color=auto'
PS1='[\u@\h \W]\$ '

# Base 16
dracula_pro="$HOME/.dotfiles/private/base16/dracula-pro.sh"
kanagawa="$HOME/.config/base16/base16-kanagawa.sh"
if [ -f $dracula_pro ]; then
  source $dracula_pro
elif [ -f $kanagawa ]; then
  source $kanagawa
fi

# aliases
alias la='ls -lAhQv'
alias ..='cd ..'
alias grt='cd $(git rev-parse --show-toplevel)'

# lf
lfd() {
	lf -last-dir-path=/tmp/lf "$@"

	if [ -f /tmp/lf ]; then
		cd "$(cat /tmp/lf)"
		rm /tmp/lf
	fi
}

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
