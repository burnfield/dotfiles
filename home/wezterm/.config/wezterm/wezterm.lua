local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = "catppuccin-latte"
config.font = wezterm.font_with_fallback {
  'Comic Code',
}
config.font_size = 17
config.enable_wayland = true
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_decorations = "NONE"
config.warn_about_missing_glyphs = false

return config
