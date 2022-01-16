local execute = vim.api.nvim_command
local fn = vim.fn

-- Automatically install packer
local packer_install_dir = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local plug_url_format = 'https://github.com/%s'

local packer_repo = string.format(plug_url_format, 'wbthomason/packer.nvim')
local install_cmd = string.format('10split |term git clone --depth=1 %s %s', packer_repo, packer_install_dir)

if fn.empty(fn.glob(packer_install_dir)) > 0 then
  vim.api.nvim_echo({{'Installing packer.nvim', 'Type'}}, true, {})
  execute(install_cmd)
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

-- Autocommand that reloads neovim whenever you save plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use protected call so we dont error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a pop up womdpw
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

-- Install plugins here
packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Have packer manage itself
  use 'nvim-lua/popup.nvim'   -- An implementation of the Popup API from vim in Neovim
  use 'nvim-lua/plenary.nvim' -- Useful lua functions used by lots of plugins
  use 'nvim-telescope/telescope.nvim' -- Fuzzy finder
  use 'tssm/fairyfloss.vim'   -- Fairyfloss color scheme
  use 'kyazdani42/blue-moon'  -- Blue Moon color scheme
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'kyazdani42/nvim-tree.lua'    -- file explorer
  use 'tpope/vim-surround'     -- Vim surrond
  use 'tpope/vim-fugitive'    -- Git explorer
  use 'lewis6991/gitsigns.nvim' -- Git status in sidebar
  use 'TimUntersberger/neogit'     -- Git something
  use 'b3nj5m1n/kommentary'   -- Comment out text
  use 'jiangmiao/auto-pairs'     -- Auto insert/delete brackets/parens/qoutes



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after al plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
