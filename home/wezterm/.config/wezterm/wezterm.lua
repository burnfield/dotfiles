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

-- Extend QuickSelect (shift+ctrl+space) to match Bazel targets:
--   //foo/bar  //foo/bar:baz  //foo/bar/...  foo/bar/...  @repo//foo/bar:baz
config.quick_select_patterns = {
  [[@?[a-zA-Z0-9_-]*//[a-zA-Z0-9_./-]+(?::[a-zA-Z0-9_.+/-]+|/\.\.\.)?]],
  [[[a-zA-Z][a-zA-Z0-9_/-]*/\.\.\.]],
}

-- ctrl+shift+u: QuickSelect a URL and open it in the browser
config.keys = {
  {
    key = 'u',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.QuickSelectArgs {
      label = 'open url',
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.open_with(url)
      end),
    },
  },
}

return config
