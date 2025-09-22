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

      -- Extract colors from current theme
      local bg = get_hl_color('Normal', 'bg') or '#1e1e1e'
      local fg = get_hl_color('Normal', 'fg') or '#ffffff'
      local red = get_hl_color('ErrorMsg', 'fg') or '#ff5555'
      local green = get_hl_color('String', 'fg') or '#50fa7b'
      local yellow = get_hl_color('WarningMsg', 'fg') or '#f1fa8c'
      local blue = get_hl_color('Function', 'fg') or '#8be9fd'
      local purple = get_hl_color('Statement', 'fg') or '#bd93f9'
      local orange = get_hl_color('Number', 'fg') or '#ffb86c'
      local comment = get_hl_color('Comment', 'fg') or '#6272a4'
      
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
      }
    end

    -- Function to create theme from current colorscheme
    local function create_lualine_theme()
      local colors = get_theme_colors()
      
      return {
        normal = {
          a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
          b = { bg = colors.comment, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        insert = {
          a = { bg = colors.green, fg = colors.bg, gui = "bold" },
          b = { bg = colors.comment, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        visual = {
          a = { bg = colors.purple, fg = colors.bg, gui = "bold" },
          b = { bg = colors.comment, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        command = {
          a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
          b = { bg = colors.comment, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        replace = {
          a = { bg = colors.red, fg = colors.bg, gui = "bold" },
          b = { bg = colors.comment, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        inactive = {
          a = { bg = colors.comment, fg = colors.fg },
          b = { bg = colors.comment, fg = colors.fg },
          c = { bg = colors.comment, fg = colors.fg },
        },
      }
    end

    -- Setup lualine with auto-theme
    local function setup_lualine()
      lualine.setup({
        options = {
          theme = create_lualine_theme(),
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 
            {
              'filename',
              on_click = function()
                vim.cmd('tabnew %')
              end,
              color = function()
                local colors = get_theme_colors()
                return { fg = colors.blue, gui = 'bold,underline' }
              end,
            }
          },
          lualine_x = {
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = function()
                local colors = get_theme_colors()
                return { fg = colors.orange }
              end,
            },
            'encoding',
            'fileformat',
            'filetype'
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
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
      callback = function()
        -- Small delay to ensure colorscheme is fully loaded
        vim.defer_fn(function()
          setup_lualine()
        end, 100)
      end,
    })
  end,
}
