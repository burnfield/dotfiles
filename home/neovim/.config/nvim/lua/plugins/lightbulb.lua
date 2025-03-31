return {
  "kosayoda/nvim-lightbulb",
  lazy = true,
  event = "LspAttach",
  opts = {
    autocmd = { enabled = true },
    virtual_text = { enabled = true },
    sign = { enabled = false },
  }
}
