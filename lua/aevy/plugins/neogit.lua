return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = function()
    local neogit = require('neogit')
    
    neogit.setup({
      disable_signs = false,
      disable_hint = false,
      disable_context_highlighting = false,
      disable_commit_confirmation = false,
      disable_builtin_editor = false,
      disable_insert_on_commit = "auto",
      use_magit_keybindings = false,
      auto_refresh = true,
      auto_show_console = true,
      remember_settings = true,
      use_per_project_settings = true,
      ignored_settings = {
        "NeogitPushPopup--force-with-lease",
        "NeogitPushPopup--force",
        "NeogitPullPopup--rebase",
        "NeogitCommitPopup--allow-empty",
        "NeogitRevertPopup--no-edit",
      },
      console_timeout = 2000,
      auto_close_console = true,
      kind = "tab",
      status = {
        recent_commit_count = 10,
      },
      commit_editor = {
        kind = "tab",
      },
      commit_select_view = {
        kind = "tab",
      },
      commit_view = {
        kind = "vsplit",
        verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
      },
      log_view = {
        kind = "tab",
      },
      rebase_editor = {
        kind = "auto",
      },
      reflog_view = {
        kind = "tab",
      },
      merge_editor = {
        kind = "auto",
      },
      tag_editor = {
        kind = "auto",
      },
      preview_buffer = {
        kind = "split",
      },
      popup = {
        kind = "split",
      },
      signs = {
        hunk = { "", "" },
        item = { ">", "v" },
        section = { ">", "v" },
      },
      integrations = {
        telescope = true,
        diffview = true,
      },
      sections = {
        sequencer = {
          folded = false,
          hidden = false,
        },
        untracked = {
          folded = false,
          hidden = false,
        },
        unstaged = {
          folded = false,
          hidden = false,
        },
        staged = {
          folded = false,
          hidden = false,
        },
        stashes = {
          folded = true,
          hidden = false,
        },
        unpulled_upstream = {
          folded = true,
          hidden = false,
        },
        unmerged_upstream = {
          folded = false,
          hidden = false,
        },
        unpulled_pushRemote = {
          folded = true,
          hidden = false,
        },
        unmerged_pushRemote = {
          folded = false,
          hidden = false,
        },
        recent = {
          folded = true,
          hidden = false,
        },
        rebase = {
          folded = true,
          hidden = false,
        },
      },
      mappings = {
        commit_editor = {
          ["q"] = "Close",
          ["<c-c><c-c>"] = "Submit",
          ["<c-c><c-k>"] = "Abort",
        },
        rebase_editor = {
          ["p"] = "Pick",
          ["r"] = "Reword",
          ["e"] = "Edit",
          ["s"] = "Squash",
          ["f"] = "Fixup",
          ["x"] = "Execute",
          ["d"] = "Drop",
          ["b"] = "Break",
          ["q"] = "Close",
          ["<cr>"] = "OpenCommit",
          ["gk"] = "MoveUp",
          ["gj"] = "MoveDown",
          ["<c-c><c-c>"] = "Submit",
          ["<c-c><c-k>"] = "Abort",
        },
        finder = {
          ["<cr>"] = "Select",
          ["<c-c>"] = "Close",
          ["<esc>"] = "Close",
          ["<c-n>"] = "Next",
          ["<c-p>"] = "Previous",
          ["<down>"] = "Next",
          ["<up>"] = "Previous",
          ["<tab>"] = "MultiselectToggleNext",
          ["<s-tab>"] = "MultiselectTogglePrevious",
          ["<c-j>"] = "NOP",
        },
        popup = {
          ["?"] = "HelpPopup",
          ["A"] = "CherryPickPopup",
          ["D"] = "DiffPopup",
          ["M"] = "RemotePopup",
          ["P"] = "PushPopup",
          ["X"] = "ResetPopup",
          ["Z"] = "StashPopup",
          ["b"] = "BranchPopup",
          ["c"] = "CommitPopup",
          ["f"] = "FetchPopup",
          ["l"] = "LogPopup",
          ["m"] = "MergePopup",
          ["p"] = "PullPopup",
          ["r"] = "RebasePopup",
          ["t"] = "TagPopup",
          ["<c-c>"] = false,
          ["<esc>"] = false,
        },
        status = {
          ["q"] = "Close",
          ["I"] = "InitRepo",
          ["1"] = "Depth1",
          ["2"] = "Depth2",
          ["3"] = "Depth3",
          ["4"] = "Depth4",
          ["<tab>"] = "Toggle",
          ["x"] = "Discard",
          ["s"] = "Stage",
          ["S"] = "StageUnstaged",
          ["<c-s>"] = "StageAll",
          ["u"] = "Unstage",
          ["U"] = "UnstageStaged",
          ["$"] = "CommandHistory",
          ["Y"] = "YankSelected",
          ["<c-r>"] = "RefreshBuffer",
          ["<enter>"] = "GoToFile",
          ["<c-v>"] = "VSplitOpen",
          ["<c-x>"] = "SplitOpen",
          ["<c-t>"] = "TabOpen",
          ["{"] = "GoToPreviousHunkHeader",
          ["}"] = "GoToNextHunkHeader",
        },
      },
    })

    -- Set keymaps
    local keymap = vim.keymap
    keymap.set("n", "<leader>gs", neogit.open, { desc = "Open Neogit status" })
    keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { desc = "Open Neogit commit" })
    keymap.set("n", "<leader>gp", ":Neogit pull<CR>", { desc = "Open Neogit pull" })
    keymap.set("n", "<leader>gP", ":Neogit push<CR>", { desc = "Open Neogit push" })
    keymap.set("n", "<leader>gb", ":Neogit branch<CR>", { desc = "Open Neogit branch" })
    keymap.set("n", "<leader>gB", ":Telescope git_branches<CR>", { desc = "Telescope git branches" })
    
    -- Auto-setup easy quit for Neogit buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NeogitStatus",
      callback = function(event)
        vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", { buffer = event.buf, desc = "Close Neogit" })
      end,
    })
  end,
}
