#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# colors from kanagawa color scheme (https://github.com/rebelot/kanagawa.nvim)


#-- Bg Shades
sumiInk0="#16161D"
sumiInk1b="#181820"
sumiInk1="#1F1F28"
sumiInk2="#2A2A37"
sumiInk3="#363646"
sumiInk4="#54546D"

#-- Popup and Floats
waveBlue1="#223249"
waveBlue2="#2D4F67"

#-- Diff and Git
winterGreen="#2B3328"
winterYellow="#49443C"
winterRed="#43242B"
winterBlue="#252535"
autumnGreen="#76946A"
autumnRed="#C34043"
autumnYellow="#DCA561"

#-- Diag
samuraiRed="#E82424"
roninYellow="#FF9E3B"
waveAqua1="#6A9589"
dragonBlue="#658594"

#-- Fg and Comments
oldWhite="#C8C093"
fujiWhite="#DCD7BA"
fujiGray="#727169"
springViolet1="#938AA9"

oniViolet="#957FB8"
crystalBlue="#7E9CD8"
springViolet2="#9CABCA"
springBlue="#7FB4CA"
lightBlue="#A3D4D5" #-- unused yet
waveAqua2="#7AA89F" #-- improve lightness: desaturated greenish Aqua

waveAqua2="#68AD99"
waveAqua4="#7AA880"
waveAqua5="#6CAF95"
waveAqua3="#68AD99"

springGreen="#98BB6C"
boatYellow1="#938056"
boatYellow2="#C0A36E"
carpYellow="#E6C384"

sakuraPink="#D27E99"
waveRed="#E46876"
peachRed="#FF5D62"
surimiOrange="#FFA066"
katanaGray="#717C7C"

# normal
color0=#090618
color1=#C34043
color2=#76946A
color3=#C0A36E
color4=#7E9CD8
color5=#957FB8
color6=#6A9589
color7=#C8C093

# bright
color8=#727169
color9=#E82424
color10=#98BB6C
color11=#E6C384
color12=#7FB4CA
color13=#938AA9
color14=#7AA89F
color15=#DCD7BA

color00="1f/1f/28" # Base 00 - Black
color01="C3/40/43" # Base 08 - Red
color02="76/94/6A" # Base 0B - Green
color03="C0/A3/6E" # Base 0A - Yellow
color04="7E/9C/D8" # Base 0D - Blue
color05="95/7F/B8" # Base 0E - Magenta
color06="6A/95/89" # Base 0C - Cyan
color07="C8/C0/93" # Base 05 - White
color08="72/71/69" # Base 03 - Bright Black
color09="E8/24/24" # Base 08 - Bright Red
color10="98/BB/6C" # Base 0B - Bright Green
color11="E6/C3/84" # Base 0A - Bright Yellow
color12="7F/B4/CA" # Base 0D - Bright Blue
color13="93/8A/A9" # Base 0E - Bright Magenta
color14="7A/A8/9F" # Base 0C - Bright Cyan
color15="DC/D7/BA" # Base 07 - Bright White
color16="ff/a0/66" # Base 09
color17="9b/70/3f" # Base 0F
color18="2a/2a/37" # Base 01
color19="36/36/46" # Base 02
color20="c8/c0/93" # Base 04
color21="c3/c3/c3" # Base 06
color_foreground=$color07 # Base 05
color_background=$color00 # Base 00

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

# 256 color space
put_template 16 $color16
put_template 17 $color17
put_template 18 $color18
put_template 19 $color19
put_template 20 $color20
put_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg a7a7a7 # foreground
  put_template_custom Ph 1e1e1e # background
  put_template_custom Pi a7a7a7 # bold color
  put_template_custom Pj 464b50 # selection color
  put_template_custom Pk a7a7a7 # selected text color
  put_template_custom Pl a7a7a7 # cursor
  put_template_custom Pm 1e1e1e # cursor text
else
  put_template_var 10 $color_foreground
  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
    put_template_var 11 $color_background
    if [ "${TERM%%-*}" = "rxvt" ]; then
      put_template_var 708 $color_background # internal border (rxvt)
    fi
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
