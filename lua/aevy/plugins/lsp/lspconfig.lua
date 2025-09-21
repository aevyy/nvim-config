return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- Aggressively suppress ALL lspconfig warnings
    local old_notify = vim.notify
    local old_warn = vim.api.nvim_echo
    local old_print = print
    
    -- Override all notification methods
    vim.notify = function(msg, level, opts)
      if type(msg) == "string" then
        local lower_msg = msg:lower()
        if lower_msg:match("lspconfig") or 
           lower_msg:match("deprecated") or
           lower_msg:match("framework") or
           lower_msg:match("vim%.lsp%.config") or
           lower_msg:match("feature will be removed") or
           lower_msg:match("nvim%-lspconfig") then
          return -- Completely ignore
        end
      end
      old_notify(msg, level, opts)
    end
    
    -- Override vim.api.nvim_echo to catch warnings
    vim.api.nvim_echo = function(chunks, history, opts)
      for _, chunk in ipairs(chunks or {}) do
        if type(chunk) == "table" and chunk[1] then
          local text = tostring(chunk[1]):lower()
          if text:match("lspconfig") or text:match("deprecated") or text:match("framework") then
            return -- Ignore warning echoes
          end
        end
      end
      old_warn(chunks, history, opts)
    end
    
    -- Override print as last resort
    print = function(...)
      local args = {...}
      for _, arg in ipairs(args) do
        if type(arg) == "string" and (arg:match("lspconfig") or arg:match("deprecated")) then
          return -- Ignore printed warnings
        end
      end
      old_print(...)
    end

    -- Import required modules
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Restore all notification methods
    vim.notify = old_notify
    vim.api.nvim_echo = old_warn
    print = old_print

    local keymap = vim.keymap

    -- LSP attach autocmd for keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- LSP keybindings
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP references" }))
        keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP definitions" }))
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP implementations" }))
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP type definitions" }))
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "See available code actions" }))
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Smart rename" }))
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", vim.tbl_extend("force", opts, { desc = "Show buffer diagnostics" }))
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show line diagnostics" }))
        keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" }))
        keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" }))
        keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show documentation for what is under cursor" }))
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", vim.tbl_extend("force", opts, { desc = "Restart LSP" }))
      end,
    })

    -- Configure diagnostics
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.INFO] = "",
          [vim.diagnostic.severity.HINT] = "󰠠",
        },
      },
      virtual_text = {
        prefix = "●",
      },
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Get capabilities for autocompletion
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Server configurations
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            completion = { callSnippet = "Replace" },
            telemetry = { enable = false },
          },
        },
      },
      clangd = {},
      bashls = {},
      dockerls = {},
      cmake = {},
    }

    -- Setup each server
    for server_name, config in pairs(servers) do
      local server_config = vim.tbl_deep_extend("force", {
        capabilities = capabilities,
      }, config)

      lspconfig[server_name].setup(server_config)
    end
  end,
}