-- NUCLEAR LSP WARNING KILLER - LOADS FIRST TO SUPPRESS ALL WARNINGS

-- Save original functions before any plugins load
local original_notify = vim.notify
local original_echo = vim.api.nvim_echo
local original_err_writeln = vim.api.nvim_err_writeln
local original_print = print

-- Nuclear warning suppression function
local function suppress_lsp_warnings(msg)
  if type(msg) == "string" then
    local lower_msg = string.lower(msg)
    return lower_msg:match("lspconfig") or 
           lower_msg:match("deprecated") or 
           lower_msg:match("framework") or 
           lower_msg:match("vim%.lsp%.config") or 
           lower_msg:match("feature will be removed") or 
           lower_msg:match("nvim%-lspconfig") or
           lower_msg:match("warning") and lower_msg:match("lsp")
  end
  return false
end

-- Override vim.notify globally
vim.notify = function(msg, level, opts)
  if suppress_lsp_warnings(msg) then
    return -- Completely ignore
  end
  original_notify(msg, level, opts)
end

-- Override vim.api.nvim_echo
vim.api.nvim_echo = function(chunks, history, opts)
  if chunks then
    for _, chunk in ipairs(chunks) do
      if type(chunk) == "table" and chunk[1] and suppress_lsp_warnings(chunk[1]) then
        return -- Ignore warning echoes
      end
    end
  end
  original_echo(chunks, history, opts)
end

-- Override vim.api.nvim_err_writeln
vim.api.nvim_err_writeln = function(str)
  if suppress_lsp_warnings(str) then
    return -- Ignore error writes
  end
  original_err_writeln(str)
end

-- Override print
print = function(...)
  local args = {...}
  for _, arg in ipairs(args) do
    if suppress_lsp_warnings(tostring(arg)) then
      return -- Ignore printed warnings
    end
  end
  original_print(...)
end

-- Also suppress vim.health warnings
if vim.health then
  local original_health_warn = vim.health.warn
  vim.health.warn = function(msg)
    if suppress_lsp_warnings(msg) then
      return
    end
    original_health_warn(msg)
  end
end

-- Create an autocmd to restore overrides after plugins load (but keep suppression)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Keep the suppression active even after startup
    vim.notify = function(msg, level, opts)
      if suppress_lsp_warnings(msg) then
        return
      end
      original_notify(msg, level, opts)
    end
  end,
})
