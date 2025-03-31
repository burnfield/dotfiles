local config = function()
  local configs = require("nvim-treesitter.configs")

  configs.setup({
    ensure_installed = {
      "rust",
      "c",
      "lua",
      "vim",
      "python",
      "query",
      "markdown",
      "markdown_inline",
      "yaml",
      "cpp",
    },
    sync_install = false,
    auto_install = false,
    highlight = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = { query = "@function.outer", desc = "AroundFunction" },
          ["if"] = { query = "@function.inner", desc = "InsideFunction" },
          ["ac"] = { query = "@class.outer", desc = "AroundClass" },
          ["ic"] = { query = "@class.inner", desc = "InsideClass" },
          ["aa"] = { query = "@assignment.outer", desc = "AroundAssignment" },
          ["ia"] = { query = "@assignment.inner", desc = "InsideAssignment" },
          ["ai"] = {
            query = "@conditional.outer",
            desc = "AroundConditional",
          },
          ["ii"] = {
            query = "@conditional.inner",
            desc = "InsideConditional",
          },
        },
        include_surrounding_whitespace = function(o)
          return o.query_string:match("@*.outer") and o.selection_mode == "V"
        end,
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = { query = "@function.outer", desc = "Next method" },
          ["]]"] = { query = "@class.outer", desc = "Next class" },
          ["]a"] = { query = "@assignment.outer", desc = "Next assignment" },
          ["]i"] = { query = "@conditional.outer", desc = "Next conditional" },
        },
        goto_next_end = {
          ["]M"] = { query = "@function.outer", desc = "Next method end" },
          ["]["] = { query = "@class.outer", desc = "Next class end" },
          ["]A"] = {
            query = "@assignment.outer",
            desc = "Next assignment end",
          },
          ["]I"] = {
            query = "@conditional.outer",
            desc = "Next conditional end",
          },
        },
        goto_previous_start = {
          ["[m"] = { query = "@function.outer", desc = "Previous method" },
          ["[["] = { query = "@class.outer", desc = "Previous class" },
          ["[a"] = {
            query = "@assignment.outer",
            desc = "Previous assignment",
          },
          ["[i"] = {
            query = "@conditional.outer",
            desc = "Previous conditional",
          },
        },
        goto_previous_end = {
          ["[M"] = { query = "@function.outer", desc = "Previous method end" },
          ["[]"] = { query = "@class.outer", desc = "Previous class end" },
          ["[A"] = {
            query = "@assignment.outer",
            desc = "Previous assignment end",
          },
          ["[I"] = {
            query = "@conditional.outer",
            desc = "Previous conditional end",
          },
        },
      },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        scope_incremental = false,
        node_incremental = "<c-space>",
        node_decremental = "<bs>",
      },
    },
    indent = {
      true,
    },
  })
end

return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  keys = {},
  build = ":TSUpdate",
  config = config,
}
