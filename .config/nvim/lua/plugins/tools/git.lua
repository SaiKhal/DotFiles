return {
    {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPre", "BufNewFile" },  -- Load when opening files
      opts = {},  -- Same as calling setup() with empty table
    },
  }