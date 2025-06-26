return {
    -- Core dependencies
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
  
    -- Icons
    "kyazdani42/nvim-web-devicons",
    "ryanoasis/vim-devicons",
  
    -- Text editing
    "tpope/vim-surround",
    "b3nj5m1n/kommentary",
    "jiangmiao/auto-pairs",
  
    -- Git integration
    "kdheepak/lazygit.nvim",

    -- Import all plugin categories
  { import = "plugins.ui" },
  { import = "plugins.tools" },
--   { import = "plugins.editor" },
--   { import = "plugins.lsp" },
--   { import = "plugins.lang" },
}
