return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    local notify = require("notify")
    
    notify.setup({
      background_colour = "#000000",
      fps = 30,
      icons = {
        DEBUG = "[DEBUG]",
        ERROR = "[ERROR]",
        INFO = "[INFO]",
        TRACE = "[TRACE]",
        WARN = "[WARN]"
      },
      level = 2,
      minimum_width = 50,
      render = "compact",
      stages = "fade_in_slide_out",
      timeout = 3000,
      top_down = true
    })
    
    vim.notify = notify
  end,
}
