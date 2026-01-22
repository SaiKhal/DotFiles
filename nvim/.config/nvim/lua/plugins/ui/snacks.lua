return {
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      opts = {
        -- Enable/disable features
        bigfile = { enabled = true },      -- Disable features in big files
        notifier = { enabled = true },     -- Better notifications
        quickfile = { enabled = true },    -- Fast file operations
        statuscolumn = { enabled = true }, -- Enhanced status column
        words = { enabled = true },        -- Highlight word under cursor
        
        -- Dashboard configuration
        dashboard = {
          enabled = true,
          sections = {
            { section = "header" },
            { section = "keys", gap = 1, padding = 1 },
            { section = "startup" },
          },
          preset = {
            header = [[
   ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
   ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
   ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
   ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
   ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
   ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
            keys = {
              { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
              { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
              { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
              { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
              { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
              { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
              { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
          },
        },
        
        -- Notification settings
        notifier = {
          enabled = true,
          timeout = 3000,
          width = { min = 40, max = 0.4 },
          height = { min = 1, max = 0.6 },
          margin = { top = 0, right = 1, bottom = 0 },
          padding = true,
          sort = { "level", "added" },
          level = vim.log.levels.TRACE,
          icons = {
            error = " ",
            warn = " ",
            info = " ",
            debug = " ",
            trace = " ",
          },
          keep = function(notif)
            return vim.fn.getcmdpos() > 0
          end,
          style = "compact",
        },
        
        -- Enhanced statuscolumn
        statuscolumn = {
          enabled = true,
          left = { "mark", "sign" },
          right = { "fold", "git" },
          folds = {
            open = false,
            git_hl = false,
          },
          git = {
            patterns = { "GitSign", "MiniDiffSign" },
          },
          refresh = 50,
        },
        
        -- Word highlighting
        words = {
          enabled = true,
          debounce = 200,
          notify_jump = false,
          notify_end = true,
          foldopen = true,
          jumplist = true,
          modes = { "n", "i", "c" },
        },
        
        -- Additional features
        scroll = {
          enabled = true,
          animate = {
            duration = { step = 15, total = 250 },
            easing = "linear",
          },
        },
        
        indent = {
          enabled = true,
          animate = {
            enabled = vim.g.snacks_animate ~= false,
            style = "out",
            easing = "linear",
            duration = {
              step = 20,
              total = 500,
            },
          },
          char = "│",
          only_scope = false,
          only_current = false,
          hl = {
            "SnacksIndent1",
            "SnacksIndent2", 
            "SnacksIndent3",
            "SnacksIndent4",
            "SnacksIndent5",
            "SnacksIndent6",
            "SnacksIndent7",
            "SnacksIndent8",
          }
        },
      },
      keys = {
        { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
        { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
        { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
        { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
        { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
        { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
        { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
        { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
        { "<c-_>", function() Snacks.terminal() end, desc = "which_key_ignore" },
        { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
        { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
      },
      init = function()
        vim.api.nvim_create_autocmd("User", {
          pattern = "VeryLazy",
          callback = function()
            -- Setup some globals for easier access
            _G.dd = function(...)
              Snacks.debug.inspect(...)
            end
            _G.bt = function()
              Snacks.debug.backtrace()
            end
            vim.print = _G.dd -- Override print to use snacks for `:=` command
          end,
        })
      end,
    },
}