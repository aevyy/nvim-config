return {
  {
    -- Better window navigation with automatic resizing
    "mrjones2014/smart-splits.nvim",
    config = function()
      require('smart-splits').setup({
        ignored_filetypes = {
          'nofile',
          'quickfix',
          'qf',
          'prompt',
        },
        ignored_buftypes = { 'nofile' },
        default_amount = 3,
        at_edge = 'wrap',
        float_win_behavior = 'previous',
        move_cursor_same_row = false,
        cursor_follows_swapped_bufs = false,
        resize_mode = {
          quit_key = '<ESC>',
          resize_keys = { 'h', 'j', 'k', 'l' },
          silent = false,
          hooks = {
            on_enter = nil,
            on_leave = nil,
          },
        },
        ignored_events = {
          'BufEnter',
          'WinEnter',
        },
        multiplexer_integration = nil,
        disable_multiplexer_nav_when_zoomed = true,
        kitty_password = nil,
        log_level = 'info',
      })

      -- Enhanced window navigation
      local keymap = vim.keymap
      keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left, { desc = 'Move to left window' })
      keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down, { desc = 'Move to window below' })
      keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up, { desc = 'Move to window above' })
      keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right, { desc = 'Move to right window' })
      
      -- Smart resizing
      keymap.set('n', '<A-h>', require('smart-splits').resize_left, { desc = 'Resize window left' })
      keymap.set('n', '<A-j>', require('smart-splits').resize_down, { desc = 'Resize window down' })
      keymap.set('n', '<A-k>', require('smart-splits').resize_up, { desc = 'Resize window up' })
      keymap.set('n', '<A-l>', require('smart-splits').resize_right, { desc = 'Resize window right' })
      
      -- Window swapping - removed <leader><leader> keymaps to avoid conflict with file finder
      keymap.set('n', '<leader>wh', require('smart-splits').swap_buf_left, { desc = 'Swap buffer left' })
      keymap.set('n', '<leader>wj', require('smart-splits').swap_buf_down, { desc = 'Swap buffer down' })
      keymap.set('n', '<leader>wk', require('smart-splits').swap_buf_up, { desc = 'Swap buffer up' })
      keymap.set('n', '<leader>wl', require('smart-splits').swap_buf_right, { desc = 'Swap buffer right' })
    end,
  },

  {
    -- Enhanced buffer navigation
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          themable = true,
          numbers = "none",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          indicator = {
            icon = "▎",
            style = "icon",
          },
          buffer_close_icon = "󰅖",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 30,
          max_prefix_length = 30,
          truncate_names = true,
          tab_size = 21,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          show_duplicate_prefix = true,
          persist_buffer_sort = true,
          separator_style = "thin",
          enforce_regular_tabs = true,
          always_show_bufferline = true,
          hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
          },
          sort_by = 'insert_after_current',
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "left",
              separator = true
            }
          },
        },
      })

      -- Buffer navigation keymaps
      local keymap = vim.keymap
      keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
      keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
      keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>", { desc = "Pin/unpin buffer" })
      keymap.set("n", "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete non-pinned buffers" })
      keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Delete other buffers" })
      keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", { desc = "Delete buffers to the right" })
      keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Delete buffers to the left" })
      keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
    end,
  },

  {
    -- Better quickfix and location list navigation
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require('bqf').setup({
        auto_enable = true,
        auto_resize_height = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { '┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█' },
          show_title = false,
        },
        func_map = {
          vsplit = '<C-v>',
          ptogglemode = 'z,',
          stoggleup = '<S-Tab>',
          stoggledown = '<Tab>',
          pscrollup = '<C-b>',
          pscrolldown = '<C-f>',
          prevfile = '<C-p>',
          nextfile = '<C-n>',
        },
      })
    end,
  },

  {
    -- Seamless terminal integration
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
          border = 'curved',
          width = function()
            return math.floor(vim.o.columns * 0.8)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.8)
          end,
        },
      })

      -- Enhanced terminal keymaps
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      -- Quick terminal access
      local keymap = vim.keymap
      keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })
      keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Toggle horizontal terminal" })
      keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "Toggle vertical terminal" })
    end,
  },
}
