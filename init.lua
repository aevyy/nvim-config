-- FORCE THEME LOADING FIRST - BEFORE ANYTHING ELSE
local function load_saved_theme()
  local config_dir = vim.fn.stdpath("config")
  local colorscheme_file = config_dir .. "/colorscheme.txt"
  local file = io.open(colorscheme_file, "r")
  if file then
    local saved_colorscheme = file:read("*line")
    file:close()
    if saved_colorscheme and saved_colorscheme ~= "" then
      saved_colorscheme = saved_colorscheme:gsub("%s+", "") -- Remove whitespace
      -- Try to load the theme immediately
      pcall(vim.cmd, "colorscheme " .. saved_colorscheme)
    end
  end
end

-- Try to load theme before loading plugins
pcall(load_saved_theme)

require("aevy.core")
require("aevy.lazy")
