vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- Tabs & indentation
opt.tabstop = 4 -- 4 spaces for tabs
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true -- smart indentation for programming languages
opt.cindent = true -- C-style indentation for better code formatting

-- comment formatting
opt.formatoptions:remove({ "c", "r", "o" }) -- disable automatic comment continuation

opt.wrap = true -- enable line wrapping
opt.breakindent = true -- visually indent wrapped lines
opt.showbreak = '↪ ' -- marker for wrapped lines

-- search settings
opt.ignorecase = true -- ignore case when searvhing
opt.smartcase = true -- if I include mixed case in my search, assumems yI want case-sensetive

opt.cursorline = false -- disable cursor line highlighting, show only cursor

-- turn on termguicolorss for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"  -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line, or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical windot to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- scrolling
opt.scrolloff = 8 -- keep 8 lines above/below cursor when scrolling
opt.sidescrolloff = 0 -- disable horizontal scroll offset

-- Prevent auto-indenting when typing ':' in C/C++ (e.g. typing 'std::')
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "objc", "h", "hpp" },
	callback = function()
		-- Remove ':' from cinkeys to stop automatic reindent on '::'
		local cinkeys = vim.bo.cinkeys or ""
		cinkeys = cinkeys:gsub(":", "")
		vim.bo.cinkeys = cinkeys
	end,
})
