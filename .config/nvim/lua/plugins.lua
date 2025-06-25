-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  -- Core dependencies
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",

  -- Telescope and extensions
  "nvim-telescope/telescope.nvim",
  "cljoly/telescope-repo.nvim",

  -- Colorschemes
  "tssm/fairyfloss.vim",
  "kyazdani42/blue-moon",
  "arcticicestudio/nord-vim",

  -- Icons
  "kyazdani42/nvim-web-devicons",
  "ryanoasis/vim-devicons",

  -- Text editing
  "tpope/vim-surround",
  "b3nj5m1n/kommentary",
  "jiangmiao/auto-pairs",

  -- Git integration
  "kdheepak/lazygit.nvim",

  -- File tree
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        hijack_cursor = true,
        open_on_setup = true,
        open_on_tab = true,
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
        diagnostics = {
          enable = false,
        },
        view = {
          width = 30,
          side = "left",
          auto_resize = true,
          number = false,
        },
      })
    end,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<A-\>]],
        direction = "horizontal",
        close_on_exit = true,
        start_in_insert = true,
      })
    end,
  },

  -- Nord colorscheme with auto-apply
  {
    "shaunsingh/nord.nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme nord")
    end,
  },
})
