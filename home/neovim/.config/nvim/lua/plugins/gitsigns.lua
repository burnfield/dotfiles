return {
  "lewis6991/gitsigns.nvim",
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { desc = "Next change" })

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { desc = "Previous change" })

      -- Actions
      -- TODO: OSKAR FIXA DESCRIPTOINS
      map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage" })
      map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset" })

      map("v", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Stage" })

      map("v", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Reset" })

      map("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end, { desc = "Blame line" })

      map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff" })

      map("n", "<leader>hD", function()
        gitsigns.diffthis("~")
      end, { desc = "Diff" })

      map("n", "<leader>hQ", function()
        gitsigns.setqflist("all")
      end, { desc = "Set quickfix" })
      map("n", "<leader>hq", gitsigns.setqflist, { desc = "Set quickfix" })

      -- Toggles
      map(
        "n",
        "<leader>tb",
        gitsigns.toggle_current_line_blame,
        { desc = "Blame " }
      )
      map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Deleted" })
      map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Word diff" })

      -- Text object
      map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Diff" })
    end,
  },
}
