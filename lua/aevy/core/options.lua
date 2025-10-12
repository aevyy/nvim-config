vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true -- disable relative line numbers
opt.number = true -- disable line numbers

-- Tabs & indentation
opt.tabstop = 2 -- 4 spaces for tabs
opt.shiftwidth = 2 -- 4 spaces for indent width
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

-- command line
opt.cmdheight = 1 -- set command-line height to 0 (hidden until needed)

-- turn on termguicolorss for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "no"  -- hide sign column to save space

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line, or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical windot to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- scrolling
opt.scrolloff = 4 -- keep 8 lines above/below cursor when scrolling
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
