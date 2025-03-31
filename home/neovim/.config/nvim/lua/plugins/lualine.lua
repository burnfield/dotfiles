local breadcrumbs = function()
  local ts_utils = require("nvim-treesitter.ts_utils")
  return require("nvim-treesitter").statusline({
    indicator_size = 60,
    type_patterns = { "class", "function", "method" },
    transform_fn = function(_line, node)
      return vim.treesitter.get_node_text(
        ts_utils.get_named_children(node)[1],
        0
      )
    end,
    separator = "->",
    allow_duplicates = false,
  })
end

local winbar = {
  lualine_a = { { "filename", file_status = false, shorting_target = 20 } },
  lualine_b = { { breadcrumbs } },
  lualine_z = {
    { "filetype", icon_only = true, separator = "", padding = 0 },
    {
      "lsp_status",
      icon = "",
      ignore_lsp = { "ruff" },
      separator = "",
      draw_empty = " ",
      padding = { right = 1 },
    },
  },
}

-- TODO(Oskar): add lazy status
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    options = {
      globalstatus = true,
    },
    sections = {
      lualine_c = { { "filename", path = 3 } },
    },
    winbar = winbar,
    inactive_winbar = winbar,
  },
}
