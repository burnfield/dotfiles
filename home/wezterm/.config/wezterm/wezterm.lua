local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "catppuccin-latte"
config.font = wezterm.font_with_fallback({
    "Comic Code",
})
config.font_size = 12
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
        key = "u",
        mods = "CTRL|SHIFT",
        action = wezterm.action.QuickSelectArgs({
            label = "open url",
            action = wezterm.action_callback(function(window, pane)
                local url = window:get_selection_text_for_pane(pane)
                wezterm.open_with(url)
            end),
        }),
    },
}

wezterm.on("gui-startup", function()
    local mux = wezterm.mux
    local tab1, _, window = mux.spawn_window({
        workspace = "src",
        cwd = wezterm.home_dir .. "/git/src",
        args = { os.getenv("SHELL"), "-l", "-c", wezterm.home_dir .. "/.local/bin/nvim" },
    })
    tab1:set_title("nvim")

    local tab2 = window:spawn_tab({ cwd = wezterm.home_dir .. "/git/src" })
    tab2:set_title("shell")

    local tab3 = window:spawn_tab({ cwd = wezterm.home_dir .. "/git/src" })
    tab3:set_title("shell")

    local tab4, _, window2 = mux.spawn_window({
        workspace = "dotfiles",
        cwd = wezterm.home_dir .. "/git/dotfiles",
        args = { os.getenv("SHELL"), "-l", "-c", wezterm.home_dir .. "/.local/bin/nvim" },
    })
    tab4:set_title("nvim")

    local tab5 = window2:spawn_tab({ cwd = wezterm.home_dir .. "/git/dotfiles" })
    tab5:set_title("shell")

    local tab6 = window2:spawn_tab({ cwd = wezterm.home_dir .. "/git/dotfiles" })
    tab6:set_title("shell")

    tab5:activate()

    mux.set_active_workspace("src")
    tab2:activate()
end)

return config
