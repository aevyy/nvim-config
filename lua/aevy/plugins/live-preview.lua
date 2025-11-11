return {
  "brianhuster/live-preview.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("live-preview").setup({
      port = 5500, -- Port for live preview server
      autokill = true, -- Auto-kill server when buffer is closed
      browser = "default", -- Use default browser (change to "firefox", "chrome", etc. if needed)
      dynamic_root = true, -- Automatically detect project root
      sync_scroll = true, -- Sync scroll between editor and browser
    })
  end,
}
