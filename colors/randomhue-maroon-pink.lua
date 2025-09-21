-- RandomHue Maroon-Pink-Brown Colorscheme
-- Your favorite maroonish-pinkish-brownish theme!

-- Clear existing highlights
vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

-- Set colorscheme name
vim.g.colors_name = 'randomhue-maroon-pink'

-- Enable termguicolors
vim.opt.termguicolors = true

-- Load lush if available, otherwise use basic highlights
local ok, lush = pcall(require, 'lush')
if ok then
  local hsl = lush.hsl
  
  -- RandomHue Maroon-Pink-Brown palette
  local colors = {
    bg = hsl("#2A1B1B"),        -- Deep maroon-brown background
    fg = hsl("#E8D5D5"),        -- Soft pinkish-cream foreground
    red = hsl("#D1999F"),       -- Dusty rose-pink
    green = hsl("#B5BD98"),     -- Muted sage with brown undertones
    yellow = hsl("#E6C794"),    -- Warm peachy-yellow
    blue = hsl("#9BB5C4"),      -- Soft dusty blue
    purple = hsl("#C4A7B8"),    -- Mauve-pink
    cyan = hsl("#A8C4B8"),      -- Muted mint with brown tint
    orange = hsl("#E8B8A8"),    -- Warm peach-brown
    comment = hsl("#9A8A8A"),   -- Pinkish-brown gray
    visual = hsl("#3A2B2B"),    -- Dark maroon selection
    accent = hsl("#D1A3A9"),    -- Beautiful dusty pink accent
  }

  -- Apply the lush theme
  lush(function()
    return {
      Normal { fg = colors.fg, bg = colors.bg },
      Comment { fg = colors.comment, gui = "italic" },
      String { fg = colors.green },
      Function { fg = colors.blue },
      Keyword { fg = colors.purple },
      Type { fg = colors.yellow },
      Constant { fg = colors.orange },
      Number { fg = colors.accent },
      Boolean { fg = colors.accent },
      Identifier { fg = colors.red },
      Statement { fg = colors.purple },
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
  vim.api.nvim_set_hl(0, 'Normal', { fg = '#E8D5D5', bg = '#2A1B1B' })
  vim.api.nvim_set_hl(0, 'Comment', { fg = '#9A8A8A', italic = true })
  vim.api.nvim_set_hl(0, 'String', { fg = '#B5BD98' })
  vim.api.nvim_set_hl(0, 'Function', { fg = '#9BB5C4' })
  vim.api.nvim_set_hl(0, 'Keyword', { fg = '#C4A7B8' })
  vim.api.nvim_set_hl(0, 'Type', { fg = '#E6C794' })
  vim.api.nvim_set_hl(0, 'Constant', { fg = '#E8B8A8' })
  vim.api.nvim_set_hl(0, 'Number', { fg = '#D1A3A9' })
  vim.api.nvim_set_hl(0, 'Boolean', { fg = '#D1A3A9' })
  vim.api.nvim_set_hl(0, 'Identifier', { fg = '#D1999F' })
  vim.api.nvim_set_hl(0, 'Statement', { fg = '#C4A7B8' })
  vim.api.nvim_set_hl(0, 'PreProc', { fg = '#A8C4B8' })
  vim.api.nvim_set_hl(0, 'Special', { fg = '#D1A3A9' })
  vim.api.nvim_set_hl(0, 'Error', { fg = '#D1999F' })
  vim.api.nvim_set_hl(0, 'Warning', { fg = '#E6C794' })
  vim.api.nvim_set_hl(0, 'Visual', { bg = '#3A2B2B' })
  vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#2D2020' })
  vim.api.nvim_set_hl(0, 'LineNr', { fg = '#9A8A8A' })
  vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#2A1B1B' })
  vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#E8D5D5', bg = '#322222' })
  vim.api.nvim_set_hl(0, 'TabLine', { fg = '#9A8A8A', bg = '#2A1B1B' })
end
