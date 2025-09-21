-- Universal Theme Blending System
-- Ensures ALL components blend perfectly with ANY theme

return {
  "rktjmp/lush.nvim", -- Use lush as dependency
  priority = 8888, -- Very high priority, but after theme loading
  config = function()
    -- Function to extract theme colors
    local function get_theme_colors()
      local function get_hl_color(group, attr)
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        return hl[attr] and string.format("#%06x", hl[attr]) or nil
      end

      return {
        bg = get_hl_color('Normal', 'bg') or '#180000',
        fg = get_hl_color('Normal', 'fg') or '#953434',
        comment = get_hl_color('Comment', 'fg') or '#689879',
        string = get_hl_color('String', 'fg') or '#884444',
        function_color = get_hl_color('Function', 'fg') or '#bd3422',
        keyword = get_hl_color('Keyword', 'fg') or '#953434',
        type = get_hl_color('Type', 'fg') or '#975546',
        constant = get_hl_color('Constant', 'fg') or '#cf8080',
        error = get_hl_color('Error', 'fg') or '#bd3422',
        warning = get_hl_color('WarningMsg', 'fg') or '#884444',
      }
    end

    -- Function to blend all components with current theme
    local function blend_all_components()
      local colors = get_theme_colors()
      
      -- Calculate darker variants of background
      local function darken_hex(hex, amount)
        hex = hex:gsub("#", "")
        local r = tonumber(hex:sub(1,2), 16)
        local g = tonumber(hex:sub(3,4), 16) 
        local b = tonumber(hex:sub(5,6), 16)
        
        r = math.max(0, math.floor(r * (1 - amount)))
        g = math.max(0, math.floor(g * (1 - amount)))
        b = math.max(0, math.floor(b * (1 - amount)))
        
        return string.format("#%02x%02x%02x", r, g, b)
      end
      
      local bg_dark = darken_hex(colors.bg, 0.3)
      local bg_darker = darken_hex(colors.bg, 0.5)
      
      -- Fix empty spaces and whitespace
      vim.api.nvim_set_hl(0, 'NonText', { fg = bg_dark, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'EndOfBuffer', { fg = colors.bg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'Whitespace', { fg = bg_dark, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'SpecialKey', { fg = bg_dark, bg = colors.bg })
      
      -- Fix indent guides
      vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = bg_dark, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'IndentBlanklineSpaceChar', { fg = bg_dark, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'IndentBlanklineSpaceCharBlankline', { fg = bg_dark, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'IblIndent', { fg = bg_dark, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'IblWhitespace', { fg = bg_dark, bg = colors.bg })
      
      -- Fix file tree
      vim.api.nvim_set_hl(0, 'NvimTreeNormal', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'NvimTreeNormalNC', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'NvimTreeEndOfBuffer', { fg = colors.bg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'NvimTreeWinSeparator', { fg = bg_dark, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'NvimTreeStatusLine', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'NvimTreeStatusLineNC', { fg = colors.fg, bg = colors.bg })
      
      -- Fix separators and borders
      vim.api.nvim_set_hl(0, 'WinSeparator', { fg = bg_dark, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'VertSplit', { fg = bg_dark, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'FloatBorder', { fg = bg_dark, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'NormalFloat', { fg = colors.fg, bg = colors.bg })
      
      -- Telescope
      vim.api.nvim_set_hl(0, 'TelescopeNormal', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = bg_dark, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = bg_dark, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { fg = bg_dark, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { fg = bg_dark, bg = colors.bg })
      
      -- Which-key
      vim.api.nvim_set_hl(0, 'WhichKeyFloat', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'WhichKeyBorder', { fg = bg_dark, bg = colors.bg })
      
      -- Noice
      vim.api.nvim_set_hl(0, 'NoicePopup', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'NoicePopupBorder', { fg = bg_dark, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'NoiceCmdlinePopup', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder', { fg = bg_dark, bg = colors.bg })
      
      -- Notify
      vim.api.nvim_set_hl(0, 'NotifyERRORBody', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'NotifyWARNBody', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'NotifyINFOBody', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'NotifyDEBUGBody', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'NotifyTRACEBody', { fg = colors.fg, bg = colors.bg })
      
      -- ToggleTerm
      vim.api.nvim_set_hl(0, 'ToggleTermNormal', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'ToggleTermNormalFloat', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'ToggleTermFloatBorder', { fg = bg_dark, bg = colors.bg })
      
      -- Alpha dashboard
      vim.api.nvim_set_hl(0, 'AlphaHeader', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'AlphaButtons', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'AlphaFooter', { fg = colors.comment, bg = colors.bg })
      
      -- Completion menu
      vim.api.nvim_set_hl(0, 'Pmenu', { fg = colors.fg, bg = bg_dark })
      vim.api.nvim_set_hl(0, 'PmenuSel', { fg = colors.bg, bg = colors.fg })
      vim.api.nvim_set_hl(0, 'PmenuSbar', { fg = colors.fg, bg = bg_darker })
      vim.api.nvim_set_hl(0, 'PmenuThumb', { fg = colors.fg, bg = colors.fg })
      
      -- Flash/Hop
      vim.api.nvim_set_hl(0, 'FlashBackdrop', { fg = bg_dark, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'HopUnmatched', { fg = bg_dark, bg = colors.bg })
      
      -- Trouble
      vim.api.nvim_set_hl(0, 'TroubleNormal', { fg = colors.fg, bg = colors.bg })
      
      -- Fidget
      vim.api.nvim_set_hl(0, 'FidgetTitle', { fg = colors.comment, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'FidgetTask', { fg = colors.fg, bg = colors.bg })
      
      -- Incline
      vim.api.nvim_set_hl(0, 'InclineNormal', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'InclineNormalNC', { fg = colors.comment, bg = colors.bg })
    end

    -- Apply blending immediately after theme loads
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.defer_fn(blend_all_components, 50) -- Small delay to ensure theme is fully loaded
      end,
    })

    -- Also apply on VimEnter for initial load
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.defer_fn(blend_all_components, 300) -- Longer delay for initial load
      end,
    })
  end,
}
