return {
  "sainnhe/gruvbox-material",
  priority = 1000,
  config = function()
    -- Configure gruvbox-material
    vim.g.gruvbox_material_background = 'medium'
    vim.g.gruvbox_material_foreground = 'material'
    vim.g.gruvbox_material_disable_italic_comment = 0
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_transparent_background = 0
    vim.g.gruvbox_material_visual = 'grey background'
    vim.g.gruvbox_material_menu_selection_background = 'orange'
    vim.g.gruvbox_material_sign_column_background = 'none'
    vim.g.gruvbox_material_spell_foreground = 'colored'
    vim.g.gruvbox_material_ui_contrast = 'high'
    vim.g.gruvbox_material_show_eob = 1
    vim.g.gruvbox_material_diagnostic_text_highlight = 1
    vim.g.gruvbox_material_diagnostic_line_highlight = 1
    vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
    vim.g.gruvbox_material_current_word = 'grey background'

    -- Apply the colorscheme
    vim.cmd.colorscheme('gruvbox-material')

    -- Universal highlight coordination that works with any theme
    local function setup_highlights()
      -- Get colors from the current colorscheme
      local function get_hl_color(group, attr)
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        return hl[attr] and string.format("#%06x", hl[attr]) or nil
      end

      -- Extract common colors from current theme
      local bg = get_hl_color('Normal', 'bg') or '#282828'
      local fg = get_hl_color('Normal', 'fg') or '#ebdbb2'
      local red = get_hl_color('ErrorMsg', 'fg') or '#fb4934'
      local green = get_hl_color('String', 'fg') or '#b8bb26'
      local yellow = get_hl_color('WarningMsg', 'fg') or '#fabd2f'
      local blue = get_hl_color('Function', 'fg') or '#83a598'
      local purple = get_hl_color('Statement', 'fg') or '#d3869b'
      local aqua = get_hl_color('Special', 'fg') or '#8ec07c'
      local orange = get_hl_color('Number', 'fg') or '#fe8019'
      local grey = get_hl_color('Comment', 'fg') or '#928374'
      
      -- Flash.nvim highlights
      vim.api.nvim_set_hl(0, 'FlashBackdrop', { fg = grey })
      vim.api.nvim_set_hl(0, 'FlashCurrent', { bg = orange, fg = bg, bold = true })
      vim.api.nvim_set_hl(0, 'FlashLabel', { bg = red, fg = bg, bold = true })
      vim.api.nvim_set_hl(0, 'FlashMatch', { bg = blue, fg = bg, bold = true })

      -- Hop.nvim highlights
      vim.api.nvim_set_hl(0, 'HopNextKey', { bg = red, fg = bg, bold = true })
      vim.api.nvim_set_hl(0, 'HopNextKey1', { bg = orange, fg = bg, bold = true })
      vim.api.nvim_set_hl(0, 'HopNextKey2', { bg = yellow, fg = bg, bold = true })
      vim.api.nvim_set_hl(0, 'HopUnmatched', { fg = grey })

      -- Rainbow delimiters
      vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = red })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = yellow })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = blue })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = orange })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = green })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = purple })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = aqua })

      -- Noice.nvim highlights
      vim.api.nvim_set_hl(0, 'NoicePopup', { bg = bg })
      vim.api.nvim_set_hl(0, 'NoicePopupBorder', { fg = grey })
      vim.api.nvim_set_hl(0, 'NoiceCmdlinePopup', { bg = bg })
      vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder', { fg = grey })
      vim.api.nvim_set_hl(0, 'NoiceCmdlineIcon', { fg = blue })

      -- Notify.nvim highlights
      vim.api.nvim_set_hl(0, 'NotifyERRORBorder', { fg = red })
      vim.api.nvim_set_hl(0, 'NotifyWARNBorder', { fg = yellow })
      vim.api.nvim_set_hl(0, 'NotifyINFOBorder', { fg = blue })
      vim.api.nvim_set_hl(0, 'NotifyDEBUGBorder', { fg = grey })
      vim.api.nvim_set_hl(0, 'NotifyTRACEBorder', { fg = purple })

      -- Incline.nvim highlights  
      vim.api.nvim_set_hl(0, 'InclineNormal', { bg = bg, fg = fg })
      vim.api.nvim_set_hl(0, 'InclineNormalNC', { bg = bg, fg = grey })

      -- Harpoon highlights
      vim.api.nvim_set_hl(0, 'HarpoonInactive', { fg = grey })
      vim.api.nvim_set_hl(0, 'HarpoonActive', { fg = orange })
      vim.api.nvim_set_hl(0, 'HarpoonNumberActive', { fg = orange, bold = true })
      vim.api.nvim_set_hl(0, 'HarpoonNumberInactive', { fg = grey })

      -- ToggleTerm highlights
      vim.api.nvim_set_hl(0, 'ToggleTermNormal', { bg = bg })
      vim.api.nvim_set_hl(0, 'ToggleTermNormalFloat', { bg = bg })
      vim.api.nvim_set_hl(0, 'ToggleTermFloatBorder', { fg = grey, bg = bg })

      -- Mini.nvim highlights
      vim.api.nvim_set_hl(0, 'MiniSurround', { bg = orange, fg = bg })
      vim.api.nvim_set_hl(0, 'MiniHipatternsFixme', { bg = red, fg = bg, bold = true })
      vim.api.nvim_set_hl(0, 'MiniHipatternsHack', { bg = orange, fg = bg, bold = true })
      vim.api.nvim_set_hl(0, 'MiniHipatternsTodo', { bg = blue, fg = bg, bold = true })
      vim.api.nvim_set_hl(0, 'MiniHipatternsNote', { bg = green, fg = bg, bold = true })

      -- Fidget highlights
      vim.api.nvim_set_hl(0, 'FidgetTitle', { fg = blue })
      vim.api.nvim_set_hl(0, 'FidgetTask', { fg = grey })

      -- Neogit highlights
      vim.api.nvim_set_hl(0, 'NeogitBranch', { fg = purple, bold = true })
      vim.api.nvim_set_hl(0, 'NeogitRemote', { fg = orange, bold = true })
      vim.api.nvim_set_hl(0, 'NeogitDiffAdd', { fg = green })
      vim.api.nvim_set_hl(0, 'NeogitDiffDelete', { fg = red })
      vim.api.nvim_set_hl(0, 'NeogitDiffContext', { fg = grey })

      -- Diffview highlights
      vim.api.nvim_set_hl(0, 'DiffviewPrimary', { fg = blue, bold = true })
      vim.api.nvim_set_hl(0, 'DiffviewSecondary', { fg = orange, bold = true })
      vim.api.nvim_set_hl(0, 'DiffviewFilePanelTitle', { fg = blue, bold = true })
      vim.api.nvim_set_hl(0, 'DiffviewFilePanelCounter', { fg = purple, bold = true })
      vim.api.nvim_set_hl(0, 'DiffviewFilePanelFileName', { fg = fg })

      -- Refactoring highlights
      vim.api.nvim_set_hl(0, 'RefactoringHighlight', { bg = yellow, fg = bg })

      -- Alpha dashboard highlights
      vim.api.nvim_set_hl(0, 'AlphaShortcut', { fg = orange, bold = true })
      vim.api.nvim_set_hl(0, 'AlphaHeader', { fg = blue })
      vim.api.nvim_set_hl(0, 'AlphaHeaderLabel', { fg = orange })
      vim.api.nvim_set_hl(0, 'AlphaFooter', { fg = green, italic = true })
      vim.api.nvim_set_hl(0, 'AlphaButtons', { fg = fg })

      -- Which-key highlights
      vim.api.nvim_set_hl(0, 'WhichKey', { fg = red, bold = true })
      vim.api.nvim_set_hl(0, 'WhichKeyGroup', { fg = orange, bold = true })
      vim.api.nvim_set_hl(0, 'WhichKeyDesc', { fg = blue })
      vim.api.nvim_set_hl(0, 'WhichKeySeperator', { fg = green })
      vim.api.nvim_set_hl(0, 'WhichKeySeparator', { fg = green })
      vim.api.nvim_set_hl(0, 'WhichKeyFloat', { bg = bg })
      vim.api.nvim_set_hl(0, 'WhichKeyValue', { fg = grey })

      -- Trouble highlights
      vim.api.nvim_set_hl(0, 'TroubleText', { fg = fg })
      vim.api.nvim_set_hl(0, 'TroubleCount', { fg = purple, bold = true })
      vim.api.nvim_set_hl(0, 'TroubleNormal', { bg = bg })

      -- Telescope enhancements
      vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = orange, bold = true })
      vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { fg = red, bold = true })
      vim.api.nvim_set_hl(0, 'TelescopePromptCounter', { fg = grey })
    end

    -- Apply highlights after any colorscheme loads
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = setup_highlights,
    })
    
    -- Apply highlights immediately
    setup_highlights()
  end,
}
