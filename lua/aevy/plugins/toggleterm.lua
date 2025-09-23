return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = nil, -- Disable global open_mapping to avoid conflicts
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = 'float',
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = 'curved',
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
      winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
          return term.name
        end
      },
    })

    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      -- Add q to close floating terminals in normal mode
      vim.keymap.set('n', 'q', [[<cmd>close<cr>]], opts)
    end

    -- Apply keymaps to all terminals except lazygit (which has its own)
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*",
      callback = function()
        local bufname = vim.fn.bufname()
        if not bufname:match("lazygit") then
          set_terminal_keymaps()
        end
      end,
    })

    local Terminal = require('toggleterm.terminal').Terminal

    -- Lazygit integration
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!")
        -- Set buffer-specific keymaps for lazygit (no jk mapping to avoid delays)
        local opts = { buffer = term.bufnr }
        vim.keymap.set("n", "q", "<cmd>close<CR>", opts)
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        -- No jk mapping for lazygit to avoid navigation delays
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      end,
      -- function to run on closing the terminal
      on_close = function(term)
        vim.cmd("startinsert!")
      end,
    })

    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end

    -- Node.js REPL
    local node = Terminal:new({
      cmd = "node",
      direction = "float",
      float_opts = {
        border = "double",
      },
    })

    function _NODE_TOGGLE()
      node:toggle()
    end

    -- Python REPL
    local python = Terminal:new({
      cmd = "python3",
      direction = "float",
      float_opts = {
        border = "double",
      },
    })

    function _PYTHON_TOGGLE()
      python:toggle()
    end

    -- Horizontal terminal
    local htop = Terminal:new({
      cmd = "htop",
      direction = "horizontal",
    })

    function _HTOP_TOGGLE()
      htop:toggle()
    end

    -- Set keymaps
    local keymap = vim.keymap
    
    -- Add explicit Ctrl+\ mapping for floating terminal
    keymap.set("n", "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })
    keymap.set("t", "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })
    
    keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })
    keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Toggle horizontal terminal" })
    keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "Toggle vertical terminal" })
    keymap.set("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Toggle Lazygit" })
    keymap.set("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", { desc = "Toggle Node.js REPL" })
    keymap.set("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", { desc = "Toggle Python REPL" })
    keymap.set("n", "<leader>tt", "<cmd>lua _HTOP_TOGGLE()<CR>", { desc = "Toggle htop" })
  end,
}
