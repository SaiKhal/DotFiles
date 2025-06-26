return {
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      config = function()
        local wk = require("which-key")
        
        -- Updated setup - removed deprecated options
        wk.setup({
          -- New key configuration (replaces popup_mappings)
          keys = {
            scroll_down = "<c-d>",
            scroll_up = "<c-u>",
          },
          -- New window configuration (replaces window)
          win = {
            border = "rounded",
            position = "bottom",
            margin = { 1, 0, 1, 0 },
            padding = { 2, 2, 2, 2 },
          },
        })
        
        -- Updated mapping syntax (new spec format)
        wk.add({
          { "<leader>f", group = "file" },
          { "<leader>g", group = "git" },
          { "<leader>l", group = "lsp" },
          { "<leader>s", group = "search" },
          
          -- You can also add specific mappings:
        --   { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        --   { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
        --   { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        })
      end,
    },
  }