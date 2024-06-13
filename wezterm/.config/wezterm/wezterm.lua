local wezterm = require 'wezterm'
local mux = wezterm.mux

local config = {
  max_fps = 120,
  font = wezterm.font_with_fallback({
    'JetBrains Mono',
    'JetBrainsMono Nerd Font',
  }),
  font_size = 12.0,
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

  colors = {
    cursor_fg = '#22212c',
    cursor_bg = '#f8f8f2',
  },

  bold_brightens_ansi_colors = false,
  front_end = 'OpenGL',
  enable_tab_bar = false,
  enable_scroll_bar = false,

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}

return config
