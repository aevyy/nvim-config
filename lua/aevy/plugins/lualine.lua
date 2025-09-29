return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    -- Function to get colors from current theme
    local function get_theme_colors()
      local function get_hl_color(group, attr)
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        return hl[attr] and string.format("#%06x", hl[attr]) or nil
      end

      -- Get current theme name for special handling
      local theme_name = vim.g.colors_name or ""
      
      -- Try to get colors from various highlight groups for better theme compatibility
      local bg = get_hl_color('Normal', 'bg') or get_hl_color('StatusLine', 'bg') or '#1e1e1e'
      local fg = get_hl_color('Normal', 'fg') or get_hl_color('StatusLine', 'fg') or '#ffffff'
      
      -- Special handling for vim theme
      if theme_name == "vim" then
        local red = get_hl_color('ErrorMsg', 'fg') or get_hl_color('WarningMsg', 'fg') or get_hl_color('Title', 'fg') or '#dc322f'
        local green = get_hl_color('MoreMsg', 'fg') or get_hl_color('Question', 'fg') or '#859900'
        local yellow = get_hl_color('Search', 'bg') or get_hl_color('IncSearch', 'bg') or '#b58900'
        local blue = get_hl_color('ModeMsg', 'fg') or get_hl_color('Directory', 'fg') or '#268bd2'
        local purple = get_hl_color('Statement', 'fg') or get_hl_color('PreProc', 'fg') or '#6c71c4'
        local orange = get_hl_color('Number', 'fg') or get_hl_color('Constant', 'fg') or '#cb4b16'
        local comment = get_hl_color('Comment', 'fg') or '#93a1a1'
        
        return {
          bg = bg,
          fg = fg,
          red = red,
          green = green,
          yellow = yellow,
          blue = blue,
          purple = purple,
          orange = orange,
          comment = comment,
          statusline_bg = get_hl_color('StatusLine', 'bg') or bg,
          statusline_fg = get_hl_color('StatusLine', 'fg') or fg,
          inactive_bg = get_hl_color('StatusLineNC', 'bg') or comment,
          inactive_fg = get_hl_color('StatusLineNC', 'fg') or fg,
        }
      end
      
      -- Mode colors - try multiple sources for better compatibility
      local red = get_hl_color('DiagnosticError', 'fg') or get_hl_color('ErrorMsg', 'fg') or get_hl_color('Error', 'fg') or '#ff5555'
      local green = get_hl_color('DiagnosticOk', 'fg') or get_hl_color('String', 'fg') or get_hl_color('DiffAdd', 'fg') or '#50fa7b'
      local yellow = get_hl_color('DiagnosticWarn', 'fg') or get_hl_color('WarningMsg', 'fg') or get_hl_color('DiffChange', 'fg') or '#f1fa8c'
      local blue = get_hl_color('DiagnosticInfo', 'fg') or get_hl_color('Function', 'fg') or get_hl_color('Identifier', 'fg') or '#8be9fd'
      local purple = get_hl_color('DiagnosticHint', 'fg') or get_hl_color('Statement', 'fg') or get_hl_color('Keyword', 'fg') or '#bd93f9'
      local orange = get_hl_color('Number', 'fg') or get_hl_color('Constant', 'fg') or get_hl_color('Type', 'fg') or '#ffb86c'
      local comment = get_hl_color('Comment', 'fg') or get_hl_color('NonText', 'fg') or '#6272a4'
      
      -- Get statusline specific colors if available
      local statusline_bg = get_hl_color('StatusLine', 'bg') or bg
      local statusline_fg = get_hl_color('StatusLine', 'fg') or fg
      local inactive_bg = get_hl_color('StatusLineNC', 'bg') or comment
      local inactive_fg = get_hl_color('StatusLineNC', 'fg') or fg
      
      return {
        bg = bg,
        fg = fg,
        red = red,
        green = green,
        yellow = yellow,
        blue = blue,
        purple = purple,
        orange = orange,
        comment = comment,
        statusline_bg = statusline_bg,
        statusline_fg = statusline_fg,
        inactive_bg = inactive_bg,
        inactive_fg = inactive_fg,
      }
    end

    -- Function to create theme from current colorscheme
    local function create_lualine_theme()
      local colors = get_theme_colors()
      local theme_name = vim.g.colors_name or ""
      
      -- Helper function to darken colors
      local function darken(color, amount)
        local hex = color:gsub("#", "")
        local r = tonumber(hex:sub(1,2), 16)
        local g = tonumber(hex:sub(3,4), 16) 
        local b = tonumber(hex:sub(5,6), 16)
        
        r = math.max(0, math.floor(r * (1 - amount)))
        g = math.max(0, math.floor(g * (1 - amount)))
        b = math.max(0, math.floor(b * (1 - amount)))
        
        return string.format("#%02x%02x%02x", r, g, b)
      end
      
      -- Helper function to lighten colors
      local function lighten(color, amount)
        local hex = color:gsub("#", "")
        local r = tonumber(hex:sub(1,2), 16)
        local g = tonumber(hex:sub(3,4), 16)
        local b = tonumber(hex:sub(5,6), 16)
        
        r = math.min(255, math.floor(r + (255 - r) * amount))
        g = math.min(255, math.floor(g + (255 - g) * amount))
        b = math.min(255, math.floor(b + (255 - b) * amount))
        
        return string.format("#%02x%02x%02x", r, g, b)
      end
      
      -- Special handling for vim theme - use red as primary
      if theme_name == "vim" then
        return {
          normal = {
            a = { bg = "#dc322f", fg = "#ffffff", gui = "bold" },
            b = { bg = "#073642", fg = "#839496" },
            c = { bg = "#002b36", fg = "#586e75" },
          },
          insert = {
            a = { bg = "#859900", fg = "#ffffff", gui = "bold" },
            b = { bg = "#073642", fg = "#839496" },
            c = { bg = "#002b36", fg = "#586e75" },
          },
          visual = {
            a = { bg = "#cb4b16", fg = "#ffffff", gui = "bold" },
            b = { bg = "#073642", fg = "#839496" },
            c = { bg = "#002b36", fg = "#586e75" },
          },
          command = {
            a = { bg = "#b58900", fg = "#ffffff", gui = "bold" },
            b = { bg = "#073642", fg = "#839496" },
            c = { bg = "#002b36", fg = "#586e75" },
          },
          replace = {
            a = { bg = "#6c71c4", fg = "#ffffff", gui = "bold" },
            b = { bg = "#073642", fg = "#839496" },
            c = { bg = "#002b36", fg = "#586e75" },
          },
          inactive = {
            a = { bg = "#073642", fg = "#586e75" },
            b = { bg = "#073642", fg = "#586e75" },
            c = { bg = "#002b36", fg = "#586e75" },
          },
        }
      end
      
      -- Create attractive theme for other colorschemes
      local bg_dark = darken(colors.bg, 0.3)
      local bg_light = lighten(colors.bg, 0.1)
      
      return {
        normal = {
          a = { bg = colors.blue, fg = "#ffffff", gui = "bold" },
          b = { bg = darken(colors.blue, 0.6), fg = lighten(colors.blue, 0.4) },
          c = { bg = bg_light, fg = colors.fg },
        },
        insert = {
          a = { bg = colors.green, fg = "#000000", gui = "bold" },
          b = { bg = darken(colors.green, 0.6), fg = lighten(colors.green, 0.4) },
          c = { bg = bg_light, fg = colors.fg },
        },
        visual = {
          a = { bg = colors.purple, fg = "#ffffff", gui = "bold" },
          b = { bg = darken(colors.purple, 0.6), fg = lighten(colors.purple, 0.4) },
          c = { bg = bg_light, fg = colors.fg },
        },
        command = {
          a = { bg = colors.yellow, fg = "#000000", gui = "bold" },
          b = { bg = darken(colors.yellow, 0.6), fg = lighten(colors.yellow, 0.4) },
          c = { bg = bg_light, fg = colors.fg },
        },
        replace = {
          a = { bg = colors.red, fg = "#ffffff", gui = "bold" },
          b = { bg = darken(colors.red, 0.6), fg = lighten(colors.red, 0.4) },
          c = { bg = bg_light, fg = colors.fg },
        },
        inactive = {
          a = { bg = bg_dark, fg = colors.comment },
          b = { bg = bg_dark, fg = colors.comment },
          c = { bg = bg_dark, fg = colors.comment },
        },
      }
    end

    -- Setup lualine with auto-theme
    local function setup_lualine()
      lualine.setup({
        options = {
          theme = create_lualine_theme(),
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
          globalstatus = false, -- This makes it responsive to each split
          always_divide_middle = true,
          refresh = {
            statusline = 2000, -- Reduced frequency from 1000ms to 2000ms
            tabline = 2000,
            winbar = 2000,
          },
          disabled_filetypes = {
            statusline = { 'alpha', 'dashboard' },
            winbar = {},
          },
        },
        sections = {
          lualine_a = { 
            {
              'mode',
              fmt = function(str)
                return str:sub(1,1) -- Show only first letter of mode
              end,
            }
          },
          lualine_b = { 
            {
              'branch',
              icon = '',
              color = { gui = 'bold' },
            },
            {
              'diff',
              symbols = { added = ' ', modified = ' ', removed = ' ' },
            },
            {
              'diagnostics',
              symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            }
          },
          lualine_c = { 
            {
              'filename',
              path = 1, -- Show relative path
              symbols = {
                modified = ' ●',
                readonly = ' ',
                unnamed = '[No Name]',
              },
              on_click = function()
                vim.cmd('tabnew %')
              end,
              -- Simplified color function to reduce lag
              color = { fg = '#6c71c4', gui = 'bold,underline' },
            }
          },
          lualine_x = {
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              -- Simplified color to reduce computation
              color = { fg = '#cb4b16', gui = 'bold' },
            },
            {
              'encoding',
              fmt = function(str)
                return str:upper()
              end,
            },
            {
              'fileformat',
              symbols = {
                unix = '', -- e712
                dos = '',  -- e70f  
                mac = '', -- e711
              },
            },
            {
              'filetype',
              icon_only = false,
              colored = true,
            }
          },
          lualine_y = { 
            {
              'progress',
              color = { gui = 'bold' },
            }
          },
          lualine_z = { 
            {
              'location',
              color = { gui = 'bold' },
            }
          }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
      })
    end

    -- Setup initial lualine
    setup_lualine()

    -- Auto-update lualine theme when colorscheme changes
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("LualineThemeUpdate", { clear = true }),
      callback = function()
        -- Longer delay and debounce to prevent excessive updates
        vim.defer_fn(function()
          setup_lualine()
        end, 200)
      end,
    })

    -- Simplified theme tracking - only update on actual theme changes
    local last_theme = vim.g.colors_name
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("LualineThemeRefresh", { clear = true }),
      callback = function()
        local current_theme = vim.g.colors_name
        if current_theme and current_theme ~= last_theme then
          last_theme = current_theme
          vim.defer_fn(function()
            setup_lualine()
          end, 100)
        end
      end,
    })
  end,
}
