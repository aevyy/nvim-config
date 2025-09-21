return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300 -- Wait 300ms before showing which-key popup
  end,
  opts = {
    preset = "classic",
    delay = 500, -- Additional delay before showing which-key popup (500ms)
    spec = {
      { "<leader>f", group = "file/find" },
      { "<leader>s", group = "split" },
      { "<leader>t", group = "tab/terminal" },
      { "<leader>m", group = "harpoon/mark" },
      { "<leader>w", group = "window" },
    },
  },
}
