require("fidget").setup({
  progress = {
    poll_rate = 0.1,               -- How frequently to update progress (seconds)
    suppress_on_insert = false,    -- Suppress new messages while in insert mode
    ignore_done_already = false,   -- Ignore new tasks that are already complete
    display = {
      render_limit = 16,           -- How many LSP messages to show at once
      done_ttl = 3,               -- How long a message should persist after completion
      done_icon = "✓",            -- Icon shown when all LSP progress tasks are complete
      done_style = "Constant",    -- Highlight group for completed task
      progress_icon = {
        pattern = "dots",         -- "dots" | "dots_negative" | "dots_snake" | "dots_pulse"
        period = 1,              -- Duration of the animation cycle
      },
      progress_style = "WarningMsg",  -- Highlight group for in-progress task
      progress_ttl = 10,
      group_style = "Title",         -- Highlight group for group name
      icon_style = "Question",       -- Highlight group for group icon
    },
    ignore = {                    -- List of LSP servers to ignore
      "null-ls",
      -- Add any other noisy LSP servers here
    },
    --ignore_progress_msgs = false, -- Ignore progress messages if the server sends too many
  },
  notification = {
    poll_rate = 10,               -- How frequently to check for new notifications
    filter = vim.log.levels.INFO, -- Minimum notifications level
    history_size = 128,           -- Number of notifications to retain in history
    override_vim_notify = false,  -- Use fidget for all notifications, not just LSP
    configs = {                   -- How to configure notification groups
      default = {
        name = "LSP",            -- Default group name
        icon = "✗",              -- Default group icon
        ttl = 3,                 -- Time to live for notifications (seconds)
        group_style = "Title",   -- Highlight group for the notification group
        icon_style = "Question", -- Highlight group for the notification icon
      },
      -- Add custom notification groups
      rust_analyzer = {
        name = "Rust",
        icon = "🦀",
      },
    },

    view = {
      stack_upwards = true,      -- Stack notifications from bottom to top
      icon_separator = " ",      -- Separator between group name and icon
      group_separator = "---",   -- Separator between notification groups
      group_separator_hl = "Comment",  -- Highlight group for the separator
    },
    window = {
      normal_hl = "Comment",     -- Highlight group for normal priority
      winblend = 0,             -- Window transparency (0-100)
      border = "none",          -- Border style: "none", "single", "double", "rounded"
      zindex = 45,              -- Window stacking priority
      max_width = 0,            -- Maximum window width (0 = unlimited)
      max_height = 0,           -- Maximum window height (0 = unlimited)
      x_padding = 1,            -- Padding from right edge
      y_padding = 0,            -- Padding from bottom edge
      align = "bottom",         -- Window alignment: "top", "bottom", "left", "right"
      relative = "editor",      -- Position relative to: "editor", "win", "cursor", "mouse"
    },
  },

  -- Optional: Configure logger for debugging
  -- logger = {
  --   level = vim.log.levels.WARN,  -- Minimum logging level
  --   float_precision = 0.01,       -- Decimal precision for floats
  --   path = "fidget.nvim.log",    -- Log file path (nil = no file logging)
  -- },
})

-- Optional: Add highlight customizations
vim.api.nvim_set_hl(0, "FidgetTask", { fg = "#6C7086" })
vim.api.nvim_set_hl(0, "FidgetTitle", { fg = "#89B4FA" })
