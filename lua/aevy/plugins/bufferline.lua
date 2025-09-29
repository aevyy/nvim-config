return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
      separator_style = "slant",
      show_tab_indicators = false,
      show_tabs = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      enforce_regular_tabs = false,
      always_show_bufferline = false, -- Hide when only one tab
      themable = true,
    },
    highlights = {
      fill = {
        bg = "NONE", -- Make background transparent
      },
      background = {
        bg = "NONE",
      },
      tab = {
        bg = "NONE",
      },
      tab_selected = {
        bg = "NONE",
      },
      tab_separator = {
        bg = "NONE",
      },
      tab_separator_selected = {
        bg = "NONE",
      },
      separator = {
        bg = "NONE",
      },
      separator_selected = {
        bg = "NONE",
      },
      separator_visible = {
        bg = "NONE",
      },
    },
  },
}
