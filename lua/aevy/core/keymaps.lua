vim.g.mapleader = " "

-- Disable space in normal mode to prevent leader key issues
vim.keymap.set("n", " ", "<Nop>", { silent = true })

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", {desc = "Exit insert mode with jk"})

-- Smart Enter key mappings
keymap.set("i", "<CR>", function()
  -- Check if we're in a completion menu
  if vim.fn.pumvisible() == 1 then
    return "<CR>"
  end
  -- Normal Enter: just new line, no comment continuation
  return "<CR>"
end, { desc = "Enter without comment continuation", expr = true })

keymap.set("i", "<S-CR>", function()
  local current_line = vim.api.nvim_get_current_line()
  local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
  local line_before_cursor = current_line:sub(1, cursor_col)
  
  -- If it's a comment line, continue the comment
  if line_before_cursor:match("^%s*//") then
    local indent = line_before_cursor:match("^(%s*)")
    return "<CR>" .. indent .. "// "
  elseif line_before_cursor:match("^%s*/%*") or line_before_cursor:match("^%s*%*") then
    -- Handle /* */ style comments
    local indent = line_before_cursor:match("^(%s*)")
    return "<CR>" .. indent .. " * "
  end
  
  -- Otherwise, reduce indentation (for ending blocks)
  local indent = current_line:match("^%s*")
  local reduced_indent = indent:gsub("  $", "") or indent:gsub("\t$", "") -- Remove 2 spaces or 1 tab
  return "<CR>" .. reduced_indent
end, { desc = "Shift+Enter: continue comments or reduce indentation", expr = true })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) --increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) --decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- window resizing with ctrl + arrow keys
keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Terminal toggle with Ctrl+\ (high priority mapping with autocmd to ensure it's set)
local function setup_terminal_toggle()
  local function toggle_float_term()
    vim.cmd("ToggleTerm direction=float")
  end

  vim.keymap.set("n", "<C-\\>", toggle_float_term, { desc = "Toggle floating terminal", noremap = true, silent = true })
  vim.keymap.set("t", "<C-\\>", toggle_float_term, { desc = "Toggle floating terminal", noremap = true, silent = true })
  vim.keymap.set("i", "<C-\\>", toggle_float_term, { desc = "Toggle floating terminal", noremap = true, silent = true })
end

-- Set the keybinding immediately
setup_terminal_toggle()

-- Also set it after all plugins are loaded to ensure no conflicts
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(setup_terminal_toggle, 100)
  end,
})
