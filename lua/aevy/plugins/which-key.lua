return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 200 -- Reduce delay for faster response
  end,
  opts = {
    preset = "classic",
    delay = 0, -- No delay for leader keys
    spec = {
      { "<leader>f", group = "file/find" },
      { "<leader>s", group = "split" },
      { "<leader>t", group = "tab/terminal" },
      { "<leader>m", group = "harpoon/mark" },
    },
  },
}
