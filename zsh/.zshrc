# Theming
source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme

# Setting colors inside some terminals (like inside vim) causes garbled output.
# Try to detect and prevent those.
# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if [ -z ${VIM+x} ]; then
  dracula_pro="~/.dotfiles/private/base16/dracula-pro.sh"
  kanagawa="~/.config/base16/kanagawa.sh"
  if [ -f dracula_pro ]; then
    source dracula_pro
  elif [ -f kanagawa ]; then
    source kanagawa
  fi
fi


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Completion
fpath+=~/.zfunc
_comp_options+=(globdots)
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' menu select=1
# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=32000
# General
setopt hist_ignore_all_dups hist_ignore_space interactivecomments share_history\
  inc_append_history hist_reduce_blanks appendhistory autocd beep nomatch notify\
  rmstarsilent
KEYTIMEOUT=0
PROMPT_EOL_MARK='' # disable annoying '%' character if the line breaks


# Aliases
alias ls='ls -v --color=auto'
alias lh='ls -Av --color=auto'
alias la='ls -lAhQv --color=auto'
alias sl='ls -ltrQh'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias diff='diff --color=auto'
alias cl=clear
alias rdir='ranger --choosedir=/tmp/.rangerdir && cd `cat /tmp/.rangerdir`'
alias grt='cd $(git rev-parse --show-toplevel)' # quick cd to git project root
alias n='nvim'
alias nn='nvim -u NORC'
alias nvs='nvim --listen /tmp/nvim' # neovim socket
alias rz='rizin'
alias dark='gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark && gsettings set org.gnome.desktop.interface color-scheme prefer-dark'
alias light='gsettings set org.gnome.desktop.interface gtk-theme Adwaita && gsettings set org.gnome.desktop.interface color-scheme prefer-light'


# Functions
cdp() {
  items=$(
    find ~/personal -maxdepth 1 -mindepth 1 -type d
  )
  cd `echo "$items" | fzf`
}

mkcd() {
  mkdir -p $@ && cd $@
}

open() {
  xdg-open $@ &>/dev/null & disown
}

enable_pyenv() {
  if type pyenv &>/dev/null; then
    eval "$(pyenv init -)"
    echo "Pyenv Initialized!"
  fi
}

enable_nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
    echo "NVM Initialized!"
}

optimize_jpg() {
  img_file="$@"
  cjpeg -quality 50 $img_file > $(basename "${img_file%.*}")-optimized.jpg
}

optimize_image() {
  img_file="$@"
  cwebp -q 75 "$img_file" -o "$(basename "${img_file%.*}".webp)"
}

optr() {
  img_file="$@"
  cwebp -resize 2000 0 -q 75 "$img_file" -o "$(basename "${img_file%.*}".webp)"
}

# Custom bindings
bindkey -e # emacs bindings
# fish word style, Ctrl-W stops at / for editing paths quickly
WORDCHARS='*?_[]~=&!#$%^(){}<>' 
autoload -U select-word-style
select-word-style normal
# Fix some bindings like delete not working by default
bindkey "^?" backward-delete-char    # backspace
bindkey "^[[H" beginning-of-line     # home
bindkey "^[[F" end-of-line           # end
bindkey "^[[1~" beginning-of-line    # home
bindkey "^[[4~" end-of-line          # end
bindkey "^[[3~" delete-char          # delete
bindkey "^[[Z" reverse-menu-complete # shift tab
# Edit command line in editor (neovim)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line

# Plugins
# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh
# Installed with pacman
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Installed with apt / dnf
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# I can't stand problems with $PATH anymore
typeset -U PATH

autoload -Uz compinit
compinit -d

# replace cd with zoxide
if type zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'
fi
