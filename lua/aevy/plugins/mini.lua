return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    -- Better Around/Inside textobjects
    require('mini.ai').setup({
      n_lines = 500,
      custom_textobjects = {
        o = require('mini.ai').gen_spec.treesitter({
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        }, {}),
        f = require('mini.ai').gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
        c = require('mini.ai').gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
      },
    })

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    require('mini.surround').setup({
      mappings = {
        add = 'gsa',            -- Add surrounding in Normal and Visual modes
        delete = 'gsd',         -- Delete surrounding
        find = 'gsf',           -- Find surrounding (to the right)
        find_left = 'gsF',      -- Find surrounding (to the left)
        highlight = 'gsh',      -- Highlight surrounding
        replace = 'gsr',        -- Replace surrounding
        update_n_lines = 'gsn', -- Update `n_lines`

        suffix_last = 'l',      -- Suffix to search with "prev" method
        suffix_next = 'n',      -- Suffix to search with "next" method
      },
    })

    -- Skip statusline setup since we're using lualine

    -- Highlight patterns in text
    require('mini.hipatterns').setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
        todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
        note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
      },
    })

    -- Move any selection in any direction
    require('mini.move').setup({
      mappings = {
        -- Move visual selection in Visual mode
        left = '<M-h>',
        right = '<M-l>',
        down = '<M-j>',
        up = '<M-k>',

        -- Move current line in Normal mode
        line_left = '<M-h>',
        line_right = '<M-l>',
        line_down = '<M-j>',
        line_up = '<M-k>',
      },
    })
  end,
}
