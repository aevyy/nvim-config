return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("refactoring").setup({
      prompt_func_return_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      prompt_func_param_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      printf_statements = {},
      print_var_statements = {},
      show_success_message = false, -- shows a message with information about the refactor on success
                                    -- i.e. [Refactor] Inlined 3 variable occurrences
    })

    -- load refactoring Telescope extension
    require("telescope").load_extension("refactoring")

    local keymap = vim.keymap

    -- Extract function supports only visual mode
    keymap.set("x", "<leader>re", ":Refactor extract ")
    keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")

    -- Extract variable supports only visual mode
    keymap.set("x", "<leader>rv", ":Refactor extract_var ")

    -- Inline func supports only normal
    keymap.set("n", "<leader>rI", ":Refactor inline_func")

    -- Inline var supports both normal and visual mode
    keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

    -- Extract block supports only normal mode
    keymap.set("n", "<leader>rb", ":Refactor extract_block")
    keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")

    -- You can also use below = true here to to change the position of the printf
    -- statement (or set two remaps for either one). This remap must be made in normal mode.
    keymap.set("n", "<leader>rp", function() require('refactoring').debug.printf({below = false}) end)

    -- Print var
    keymap.set({"x", "n"}, "<leader>rv", function() require('refactoring').debug.print_var() end)
    -- Supports both visual and normal mode

    keymap.set("n", "<leader>rc", function() require('refactoring').debug.cleanup({}) end)
    -- Supports only normal mode

    -- Telescope refactoring helper
    keymap.set(
      {"n", "x"},
      "<leader>rr",
      function() require('telescope').extensions.refactoring.refactors() end
    )
  end,
}
