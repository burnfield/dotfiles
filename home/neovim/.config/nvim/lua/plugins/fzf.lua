local cmd = function(o)
  return {
    o[1],
    "<cmd>FzfLua " .. o[2] .. "<cr>",
    silent = true,
    desc = o[3],
    o[4],
  }
end
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    winopts = {
      height = 0.3,
      width = 1,
      row = 1,
      backdrop = 100,
    },
  },
  keys = {
    cmd({ "<leader>f", "git_files", "GFiles" }),
    cmd({ "<leader>F", "files", "Files" }),
    cmd({ "<leader>b", "buffers", "Buffers" }),
    cmd({ "<leader>m", "marks", "Marks" }),
    cmd({ "<leader>*", "grep_project", "Rg" }),
    cmd({ "<leader><leader>", "resume", "Last fzf" }),
    cmd({
      "<c-x><c-f>",
      "complete_path",
      "Fuzzy complete path",
      mode = { "n", "v", "i" },
    }),
  },
}
