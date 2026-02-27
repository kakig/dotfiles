local wezterm = require 'wezterm'
local mux = wezterm.mux

local font_size = 14.0

local is_darwin = function()
  return wezterm.target_triple:find("darwin") ~= nil
end

if is_darwin() then
  font_size = 18.0
end

local config = {
  max_fps = 60,
  font = wezterm.font_with_fallback({
    'MesloLGM Nerd Font',
    'JetBrains Mono',
    'JetBrainsMono Nerd Font',
  }),
  font_size = font_size,
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

  colors = {
    cursor_fg = '#F5F5F5',
    cursor_bg = '#1F1F1F',
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
