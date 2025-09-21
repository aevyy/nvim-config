-- Burgundy Elliot Colorscheme
-- Inspired by elliot.zone burgundy theme

-- Clear existing highlights
vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

-- Set colorscheme name
vim.g.colors_name = 'burgundy-elliot'

-- Enable termguicolors
vim.opt.termguicolors = true

-- Load lush if available, otherwise use basic highlights
local ok, lush = pcall(require, 'lush')
if ok then
  local hsl = lush.hsl
  
  -- Burgundy palette inspired by elliot.zone
  local colors = {
    bg = hsl("#1A0F0F"),        -- Deep burgundy-black
    fg = hsl("#E6D6D6"),        -- Warm cream
    red = hsl("#C85A5A"),       -- Rich burgundy red
    green = hsl("#7A8471"),     -- Muted olive green
    yellow = hsl("#D4A574"),    -- Warm gold
    blue = hsl("#6B7A9E"),      -- Dusty blue
    purple = hsl("#A67BA6"),    -- Soft purple
    cyan = hsl("#6B9E9E"),      -- Muted teal
    orange = hsl("#D4845A"),    -- Warm orange
    comment = hsl("#8B7A7A"),   -- Burgundy gray
    visual = hsl("#2D1A1A"),    -- Dark burgundy selection
    accent = hsl("#C85A7A"),    -- Burgundy-pink accent
  }

  -- Apply the lush theme
  lush(function()
    return {
      Normal { fg = colors.fg, bg = colors.bg },
      Comment { fg = colors.comment, gui = "italic" },
      String { fg = colors.green },
      Function { fg = colors.blue },
      Keyword { fg = colors.red },
      Type { fg = colors.yellow },
      Constant { fg = colors.orange },
      Number { fg = colors.accent },
      Boolean { fg = colors.accent },
      Identifier { fg = colors.purple },
      Statement { fg = colors.red },
      PreProc { fg = colors.cyan },
      Special { fg = colors.accent },
      Error { fg = colors.red },
      Warning { fg = colors.yellow },
      Visual { bg = colors.visual },
      CursorLine { bg = colors.bg.lighten(3) },
      LineNr { fg = colors.comment },
      SignColumn { bg = colors.bg },
      StatusLine { fg = colors.fg, bg = colors.bg.lighten(8) },
      TabLine { fg = colors.comment, bg = colors.bg },
      Search { bg = colors.accent.darken(20), fg = colors.fg },
      IncSearch { bg = colors.accent, fg = colors.bg },
      MatchParen { bg = colors.accent.darken(30), fg = colors.fg, gui = "bold" },
    }
  end)
else
  -- Fallback basic highlights if lush is not available
  vim.api.nvim_set_hl(0, 'Normal', { fg = '#E6D6D6', bg = '#1A0F0F' })
  vim.api.nvim_set_hl(0, 'Comment', { fg = '#8B7A7A', italic = true })
  vim.api.nvim_set_hl(0, 'String', { fg = '#7A8471' })
  vim.api.nvim_set_hl(0, 'Function', { fg = '#6B7A9E' })
  vim.api.nvim_set_hl(0, 'Keyword', { fg = '#C85A5A' })
  vim.api.nvim_set_hl(0, 'Type', { fg = '#D4A574' })
  vim.api.nvim_set_hl(0, 'Constant', { fg = '#D4845A' })
  vim.api.nvim_set_hl(0, 'Number', { fg = '#C85A7A' })
  vim.api.nvim_set_hl(0, 'Boolean', { fg = '#C85A7A' })
  vim.api.nvim_set_hl(0, 'Identifier', { fg = '#A67BA6' })
  vim.api.nvim_set_hl(0, 'Statement', { fg = '#C85A5A' })
  vim.api.nvim_set_hl(0, 'PreProc', { fg = '#6B9E9E' })
  vim.api.nvim_set_hl(0, 'Special', { fg = '#C85A7A' })
  vim.api.nvim_set_hl(0, 'Error', { fg = '#C85A5A' })
  vim.api.nvim_set_hl(0, 'Warning', { fg = '#D4A574' })
  vim.api.nvim_set_hl(0, 'Visual', { bg = '#2D1A1A' })
  vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#221414' })
  vim.api.nvim_set_hl(0, 'LineNr', { fg = '#8B7A7A' })
  vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#1A0F0F' })
  vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#E6D6D6', bg = '#2A1A1A' })
  vim.api.nvim_set_hl(0, 'TabLine', { fg = '#8B7A7A', bg = '#1A0F0F' })
end
