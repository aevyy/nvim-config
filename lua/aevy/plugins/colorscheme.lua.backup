return {
  -- TokyoNight theme
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      local bg = "#011628"
      local bg_dark = "#011423"
      local bg_highlight = "#143652"
      local bg_search = "#0A64AC"
      local bg_visual = "#275378"
      local fg = "#CBE0F0"
      local fg_dark = "#B4D0E9"
      local fg_gutter = "#627E97"
      local border = "#547998"

      require("tokyonight").setup({
        style = "night",
        on_colors = function(colors)
          colors.bg = bg
          colors.bg_dark = bg_dark
          colors.bg_float = bg_dark
          colors.bg_highlight = bg_highlight
          colors.bg_popup = bg_dark
          colors.bg_search = bg_search
          colors.bg_sidebar = bg_dark
          colors.bg_statusline = bg_dark
          colors.bg_visual = bg_visual
          colors.border = border
          colors.fg = fg
          colors.fg_dark = fg_dark
          colors.fg_float = fg
          colors.fg_gutter = fg_gutter
          colors.fg_sidebar = fg_dark
        end,
      })
    end,
  },

  -- Catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        transparent_background = false,
      })
    end,
  },

  -- Gruvbox theme
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        contrast = "hard", -- can be "hard", "soft" or empty string
        transparent_mode = false,
      })
    end,
  },

  -- Gruvbox Material theme
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_background = 'medium' -- 'hard', 'medium', 'soft'
      vim.g.gruvbox_material_foreground = 'material' -- 'material', 'mix', 'original'
      vim.g.gruvbox_material_transparent_background = 0
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
    end,
  },

  -- Nord theme
  {
    "shaunsingh/nord.nvim",
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = false
    end,
  },

  -- Kanagawa theme
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
        theme = "wave", -- Load "wave" theme when 'background' option is not set
      })
    end,
  },

  -- Rose Pine theme
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "moon", -- auto, main, moon, or dawn
        dark_variant = "moon",
        disable_background = false,
        disable_float_background = false,
      })
    end,
  },

  -- Nightfox theme
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          transparent = false,
        },
      })
    end,
  },

  -- Set default colorscheme with persistence
  {
    "folke/tokyonight.nvim",
    priority = 1001, -- Higher priority to ensure it loads last
    config = function()
      -- Function to save colorscheme preference
      local function save_colorscheme(colorscheme)
        local config_dir = vim.fn.stdpath("config")
        local colorscheme_file = config_dir .. "/colorscheme.txt"
        local file = io.open(colorscheme_file, "w")
        if file then
          file:write(colorscheme)
          file:close()
        end
      end

      -- Function to load saved colorscheme
      local function load_saved_colorscheme()
        local config_dir = vim.fn.stdpath("config")
        local colorscheme_file = config_dir .. "/colorscheme.txt"
        local file = io.open(colorscheme_file, "r")
        if file then
          local saved_colorscheme = file:read("*line")
          file:close()
          return saved_colorscheme
        end
        return "tokyonight" -- default fallback
      end

      -- Create autocommand to save colorscheme when it changes
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          save_colorscheme(vim.g.colors_name)
        end,
      })

      -- Load the saved colorscheme or default
      local saved_colorscheme = load_saved_colorscheme()
      pcall(vim.cmd, "colorscheme " .. saved_colorscheme)
    end,
  },
}
