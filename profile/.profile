# Harden umask value
umask 027

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Custom paths
#
# The test [[ "$PATH" =~ "..." ]] tries to avoid repeated entries in the PATH
# even if this file is sourced more than once.
#
# Also, always add entries to the PATH at the end, to make binary injection /
# hijacking attacks more difficult.
#
[[ "$PATH" =~ "$HOME/.local/bin" ]] || PATH="$PATH:$HOME/.local/bin"
[[ "$PATH" =~ "$HOME/bin" ]] || PATH="$PATH:$HOME/bin"
[[ "$PATH" =~ "$HOME/.luarocks/bin" ]] || PATH="$PATH:$HOME/.luarocks/bin"
[[ "$PATH" =~ "$HOME/go/bin" ]] || PATH="$PATH:$HOME/go/bin"
[[ "$PATH" =~ "$HOME/.cargo/bin" ]] || PATH="$PATH:$HOME/.cargo/bin"
[[ "$PATH" =~ "$HOME/.yarn/bin" ]] || PATH="$PATH:$HOME/.yarn/bin"
[[ "$PATH" =~ "$HOME/.dotnet/tools" ]] || PATH="$PATH:$HOME/.dotnet/tools"
[[ "$PATH" =~ "$PYENV_ROOT/bin" ]] || PATH="$PATH:$PYENV_ROOT/bin"
[[ "$PATH" =~ "$PYENV_ROOT/shims" ]] || PATH="$PATH:$PYENV_ROOT/shims"
# [[ "$PATH" =~ "$HOME/.rbenv/bin" ]] || PATH="$PATH:$HOME/.rbenv/bin"
# [[ "$PATH" =~ "$HOME/.rbenv/shims" ]] || PATH="$PATH:$HOME/.rbenv/shims"
[[ "$PATH" =~ "$HOME/.pub-cache/bin" ]] || PATH="$PATH:$HOME/.pub-cache/bin" # pub (dart-devtools cli)
export PATH

# Environment variables
#
export INPUTRC="~/.inputrc" # gnu readline
export XDG_CONFIG_HOME="$HOME/.config" # needs to be set for some programs
export NVM_DIR=~/.nvm
#export QT_QPA_PLATFORMTHEME='qt5ct' # qgnomeplatform
#export XDG_CURRENT_DESKTOP=KDE
# export SCONSFLAGS="-j12" # scons has its own envvar for makeflags
export EDITOR=nvim
export VISUAL=nvim
export SUDO_EDITOR=nvim
export MOZ_USE_XINPUT2=1 # Enable touchpad gestures in Firefox
export MOZ_ENABLE_WAYLAND=1
# export BROWSER=firefox-nightly
export BROWSER=google-chrome-stable
# export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab # jupyter
export LEDGER_FILE="$HOME/Sync/ledger.dat" # hledger
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export MANPAGER="less -R --use-color -Dd+y -Du+m" # Enable color in manpages
export MANROFFOPT="-P -c"

# Setup ssh-agent
# if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#   ssh-agent -t 12h > "$XDG_RUNTIME_DIR/ssh-agent.env"
# fi
# if [[ ! "$SSH_AUTH_SOCK" ]]; then
#   source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
# fi

# Nix Single User (WSL2 compatible)
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
if [ -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then . ~/.nix-profile/etc/profile.d/hm-session-vars.sh; fi
