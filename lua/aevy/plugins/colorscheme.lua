return {
  -- Aco theme (dark terminal theme)
  {
    "Mofiqul/vscode.nvim",
    name = "aco",
    config = function()
      require('vscode').setup({
        style = "dark",
        transparent = false,
        italic_comments = true,
        disable_nvimtree_bg = false,
        color_overrides = {
          vscBack = '#0f0f23',
          vscFront = '#d4d4d4',
          },
        bufferline = {
        },
      })
    end,
  },

  -- Birds of Paradise theme
  {
    "mhartington/oceanic-next",
    name = "birds-of-paradise",
    config = function()
      vim.g.oceanic_next_terminal_bold = 1
      vim.g.oceanic_next_terminal_italic = 1
    end,
  },

  -- Belafonte theme (inspired by terminal theme)
  {
    "bluz71/vim-nightfly-colors",
    name = "belafonte",
    config = function()
      vim.g.nightflyTransparent = false
      vim.g.nightflyVirtualTextColor = true
      vim.g.nightflyUndercurls = true
    end,
  },

  -- Dracula theme (classic terminal theme)
  {
    "Mofiqul/dracula.nvim",
    config = function()
      require("dracula").setup({
        colors = {
          bg = "#1e1f29",
          fg = "#f8f8f2",
          selection = "#44475a",
          comment = "#6272a4",
          red = "#ff5555",
          orange = "#ffb86c",
          yellow = "#f1fa8c",
          green = "#50fa7b",
          purple = "#bd93f9",
          cyan = "#8be9fd",
          pink = "#ff79c6",
          bright_red = "#ff6e6e",
          bright_green = "#69ff94",
          bright_yellow = "#ffffa5",
          bright_blue = "#d6acff",
          bright_magenta = "#ff92df",
          bright_cyan = "#a4ffff",
          bright_white = "#ffffff",
          menu = "#21222c",
          visual = "#3e4452",
          gutter_fg = "#4b5263",
          nontext = "#3b4048",
        },
        show_end_of_buffer = false,
        transparent_bg = false,
        lualine_bg_color = "#44475a",
        italic_comment = true,
      })
    end,
  },

  -- Monokai Pro (terminal inspired)
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup({
        transparent_background = false,
        terminal_colors = true,
        devicons = true,
        filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
        inc_search = "background",
        background_clear = {},
        plugins = {
          bufferline = {
            underline_selected = false,
            underline_visible = false,
          },
          indent_blankline = {
            context_highlight = "default",
            context_start_underline = false,
          },
        },
      })
    end,
  },

  -- Terminal-inspired Gruvbox Material (keeping as it's popular)
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_background = 'hard' -- hard for terminal feel
      vim.g.gruvbox_material_foreground = 'material'
      vim.g.gruvbox_material_transparent_background = 0
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_ui_contrast = 'high'
    end,
  },

  -- Tokyo Night Storm (terminal-style)
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        style = "storm", -- storm has better terminal feel
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = { "qf", "help", "terminal" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = false,
      })
    end,
  },

  -- Cyberdream (futuristic terminal theme)
  {
    "scottmckendry/cyberdream.nvim",
    config = function()
      require("cyberdream").setup({
        transparent = false,
        italic_comments = true,
        hide_fillchars = false,
        borderless_telescope = true,
        terminal_colors = true,
      })
    end,
  },

  -- Onedark (Atom-inspired terminal theme)
  {
    "navarasu/onedark.nvim",
    config = function()
      require('onedark').setup({
        style = 'dark', -- dark, darker, cool, deep, warm, warmer
        transparent = false,
        term_colors = true,
        ending_tildes = false,
        cmp_itemkind_reverse = false,
        toggle_style_key = nil,
        toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'},
        code_style = {
          comments = 'italic',
          keywords = 'none',
          functions = 'none',
          strings = 'none',
          variables = 'none'
        },
        lualine = {
          transparent = false,
        },
        colors = {},
        highlights = {},
        diagnostics = {
          darker = true,
          undercurl = true,
          background = true,
        },
      })
    end,
  },

  -- Theme persistence system (highest priority)
  {
    "folke/tokyonight.nvim", -- Use any theme as dependency
    priority = 9999, -- Highest priority to load after all other themes
    config = function()
      local config_dir = vim.fn.stdpath("config")
      local colorscheme_file = config_dir .. "/colorscheme.txt"
      
      -- Function to save colorscheme preference
      local function save_colorscheme(colorscheme)
        if colorscheme and colorscheme ~= "" then
          local file = io.open(colorscheme_file, "w")
          if file then
            file:write(colorscheme)
            file:close()
            -- Removed print message for silent operation
          end
        end
      end

      -- Function to load saved colorscheme
      local function load_saved_colorscheme()
        local file = io.open(colorscheme_file, "r")
        if file then
          local saved_colorscheme = file:read("*line")
          file:close()
          if saved_colorscheme then
            return saved_colorscheme:gsub("%s+", "")
          end
        end
        return nil
      end

      -- Set up global function for manual saving
      _G.save_current_colorscheme = function()
        if vim.g.colors_name then
          save_colorscheme(vim.g.colors_name)
        end
      end

      -- Create autocommand to save colorscheme when it changes
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("ColorschemeAutoSave", { clear = true }),
        pattern = "*",
        callback = function()
          -- Small delay to ensure colorscheme is fully loaded
          vim.defer_fn(function()
            if vim.g.colors_name then
              save_colorscheme(vim.g.colors_name)
            end
          end, 50)
        end,
      })

      -- Load saved colorscheme on startup
      local saved_colorscheme = load_saved_colorscheme()
      if saved_colorscheme and saved_colorscheme ~= "" then
        -- Use defer_fn to ensure this runs after all other theme setups
        vim.defer_fn(function()
          pcall(vim.cmd, "colorscheme " .. saved_colorscheme)
        end, 100)
      end

      -- Add keymap for manual saving
      vim.keymap.set("n", "<leader>cs", ":lua save_current_colorscheme()<CR>", 
        { desc = "Save current colorscheme as default" })
    end,
  },

  -- Default colorscheme setup (lower priority)
  {
    "sainnhe/gruvbox-material",
    priority = 1000, -- Lower priority than persistence system
    config = function()
      -- Configure gruvbox-material but don't auto-load if we have a saved theme
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_foreground = 'material'
      vim.g.gruvbox_material_transparent_background = 0
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_ui_contrast = 'high'
      
      -- Only set as default if no saved theme exists
      local config_dir = vim.fn.stdpath("config")
      local colorscheme_file = config_dir .. "/colorscheme.txt"
      local file = io.open(colorscheme_file, "r")
      if not file then
        -- No saved theme, use gruvbox-material as default
        vim.defer_fn(function()
          pcall(vim.cmd, "colorscheme gruvbox-material")
        end, 50)
      else
        file:close()
      end
    end,
  },
}
