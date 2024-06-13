#
# ~/.bash_profile
#
# Source ~/.profile if it exists.

if [ -r ~/.profile ]; then . ~/.profile; fi
if [[ $- == *i* ]]; then . ~/.bashrc; fi
