-- Diagnostic shortcuts instead of linting
return {
  -- No plugin needed - using built-in LSP diagnostics
  {
    "neovim/nvim-lspconfig", -- Already loaded, just adding config
    config = function()
      -- Diagnostic keymaps for red underlines and errors
      local keymap = vim.keymap
      
      -- Jump to diagnostic under cursor or next diagnostic
      keymap.set("n", "<leader>d", function()
        -- First try to open float for current position
        local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
        local diagnostics = vim.diagnostic.get(0, { lnum = current_line })
        
        if #diagnostics > 0 then
          vim.diagnostic.open_float(nil, { focus = false })
        else
          -- If no diagnostic on current line, go to next
          vim.diagnostic.goto_next()
        end
      end, { desc = "Show diagnostic or go to next" })
      
      -- Go to next diagnostic (red underline)
      keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      
      -- Go to previous diagnostic (red underline)  
      keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      
      -- Show all diagnostics in location list
      keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Show diagnostics list" })
      
      -- Show all diagnostics in telescope
      keymap.set("n", "<leader>da", "<cmd>Telescope diagnostics<CR>", { desc = "Show all diagnostics" })
      
      -- Configure diagnostics appearance
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●", -- Could be '■', '▎', 'x', '●'
          source = "if_many",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
      
      -- Define diagnostic signs
      local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" }, 
        { name = "DiagnosticSignHint", text = "󰠠" },
        { name = "DiagnosticSignInfo", text = "" },
      }
      
      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end
    end,
  },
}
