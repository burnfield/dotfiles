local config = {}

config.color_scheme = "catppuccin-latte"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_frame = {
  font_size = 10,
}

-- domains/workspaces
config.unix_domains = {
  {
    name = "unix",
  },
}
config.default_gui_startup_args = { "connect", "unix" }

return config
