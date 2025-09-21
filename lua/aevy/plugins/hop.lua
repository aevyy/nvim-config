return {
  'phaazon/hop.nvim',
  event = "VeryLazy",
  branch = 'v2',
  config = function()
    local hop = require('hop')
    hop.setup({
      keys = 'etovxqpdygfblzhckisuran',
      jump_on_sole_occurrence = true,
      case_insensitive = true,
      create_hl_autocmd = true,
      current_line_only = false,
      inclusive_jump = false,
      uppercase_labels = false,
      multi_windows = true,
      hint_position = require'hop.hint'.HintPosition.BEGIN,
    })

    -- Leader-based hops only to avoid conflicts with Flash
    vim.keymap.set('n', '<leader>jw', ':HopWord<CR>', { desc = 'Hop to word' })
    vim.keymap.set('n', '<leader>jl', ':HopLine<CR>', { desc = 'Hop to line' })
    vim.keymap.set('n', '<leader>jc', ':HopChar1<CR>', { desc = 'Hop to character' })
    vim.keymap.set('n', '<leader>jp', ':HopPattern<CR>', { desc = 'Hop to pattern' })
  end,
}
