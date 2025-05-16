# Theming
source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme

# Setting colors inside some terminals (like inside vim) causes garbled output.
# Try to detect and prevent those.
# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if [ -z ${VIM+x} ]; then
  dracula_pro="$HOME/.dotfiles/private/base16/dracula-pro.sh"
  kanagawa="$HOME/.config/base16/base16-kanagawa.sh"
  highc="$HOME/.config/base16/base16-highc.sh"
  if [ -f $dracula_pro ]; then
    source $dracula_pro
  elif [ -f $highc ]; then
    source $highc
  elif [ -f $kanagawa ]; then
    source $kanagawa
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
if [[ `uname` != 'Darwin' ]]; then
  alias la='ls -lAhQv --color=auto'
  alias sl='ls -ltrQh'
else
  alias la='ls -lAhv --color=auto'
  alias sl='ls -ltrh'
fi
alias ls='ls -v --color=auto'
alias lh='ls -Av --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias diff='diff --color=auto'
alias cl=clear
alias rdir='ranger --choosedir=/tmp/.rangerdir && cd `cat /tmp/.rangerdir`'
alias n='nvim'
alias nn='nvim -u NORC'
alias nvs='nvim --listen /tmp/nvim' # neovim socket
alias ndot='pushd && cd ~/.dotfiles && nvim . && popd'
alias rz='rizin'
alias dark='gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark && gsettings set org.gnome.desktop.interface color-scheme prefer-dark'
alias light='gsettings set org.gnome.desktop.interface gtk-theme Adwaita && gsettings set org.gnome.desktop.interface color-scheme prefer-light'

# OnlyGit
alias g='git'
alias gap='git add -p'
alias gb='git branch'
alias gbc='git branch --show-current'
alias gc='git commit'
alias gck='git checkout'
alias gd='git diff'
alias gl='git log'
alias gm='git merge'
alias gp='git pull'
alias gph='git push'
alias gr='git reset'
alias grb='git rebase'
alias grbi='git rebase --interactive'
alias grc='git reset --soft HEAD~1' # git reset commit
alias grh='git reset --hard'
alias grho='git reset --hard "origin/$(git branch --show-current)"'
alias grt='cd $(git rev-parse --show-toplevel)' # git root
alias gs='git s'
alias gst='git stash'
alias gsw='git switch'
alias gw='git worktree'
alias gwa='git worktree add'

# Functions
cdp() {
  items=$(
    find ~/personal -maxdepth 1 -mindepth 1 -type d
  )
  cd `echo "$items" | fzf`
}

cdw() {
  items=$(
    find ~/work -maxdepth 1 -mindepth 1 -type d
  )
  cd `echo "$items" | fzf`
}

mkcd() {
  mkdir -p $@ && cd $@
}

if [[ `uname` != 'Darwin' ]]; then
  open() {
    xdg-open $@ &>/dev/null & disown
  }
fi

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

nnn ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    export NNN_TMPFILE="/tmp/nnn.lastd"

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
}

containerspace() {
  docker run --rm -it --userns=keep-id --user $(id -u):$(id -g) -v .:/workspace:Z $@ dotneo
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
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f "$HOME/.nix-profile/share/fzf/key-bindings.zsh" ] && source "$HOME/.nix-profile/share/fzf/key-bindings.zsh"
[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
# Installed with pacman
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Installed with apt / dnf
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Installed with homebrew
[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# I can't stand problems with $PATH anymore
typeset -U PATH

autoload -Uz +X compinit
compinit -d

# replace cd with zoxide if available
if type zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'
fi
