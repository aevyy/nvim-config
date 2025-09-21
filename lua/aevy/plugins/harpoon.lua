return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    
    harpoon:setup({
      settings = {
        save_on_toggle = true,
      },
    })

    local keymap = vim.keymap
    
    keymap.set("n", "<leader>ma", function() harpoon:list():add() end, { desc = "Add file to harpoon" })
    keymap.set("n", "<leader>mm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle harpoon menu" })
    
    -- Quick navigation to harpoon files
    keymap.set("n", "<leader>m1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
    keymap.set("n", "<leader>m2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
    keymap.set("n", "<leader>m3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
    keymap.set("n", "<leader>m4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })
    
    -- Navigate to previous & next buffers stored within Harpoon list
    keymap.set("n", "<leader>mp", function() harpoon:list():prev() end, { desc = "Previous harpoon file" })
    keymap.set("n", "<leader>mn", function() harpoon:list():next() end, { desc = "Next harpoon file" })
  end,
}
