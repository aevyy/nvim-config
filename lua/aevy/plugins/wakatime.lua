return {
  "wakatime/vim-wakatime",
  lazy = false, -- Load immediately to start tracking
  config = function()
    -- WakaTime will automatically prompt for API key on first use
    -- You can also set it manually with :WakaTimeApiKey
    -- or configure it in ~/.wakatime.cfg
    
    -- Optional: Set some WakaTime specific settings
    vim.g.wakatime_PythonBinary = '/usr/bin/python3' -- Adjust path if needed
    
    -- The plugin will automatically track:
    -- - Time spent in files
    -- - Languages used
    -- - Projects worked on
    -- - Editor usage patterns
  end,
}
