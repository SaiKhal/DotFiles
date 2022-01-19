local cmd = vim.cmd

local options = {
  backup = false,						-- creates a backup file
  clipboard = 'unnamedplus',					-- allows neovim to access the system clipboard
  completeopt = { 'menuone', 'noselect', 'noinsert' },		-- mostly for cmp
  cursorline = true,						-- highlight the current line
  expandtab = true,						-- Use spaces instead of tab
  hidden = true,						-- buffer becomes hidden when abondoned
  history = 1000,
  hlsearch = true,
  ignorecase = true,						-- ignore case in search patterns
  inccommand = 'split',						-- shows the effects of text substitution as you type
  mouse = 'a',							-- allow the mouse to be used in neovim
  number = true,						-- show line numbers
  numberwidth = 2, 						-- set number column width (4 default)
  relativenumber = true,					-- show relative line numbers
  scrolloff = 8,						  -- determines number of lines shown above/below cursor
  shiftwidth = 2,						-- number of spaces to use during autoindent
  sidescrolloff = 8,						-- same
  smartcase = true,
  smartindent = true,						-- make indenting smarter again
  splitbelow = true,						-- force all horizontal splits to go below current window
  splitright = true,						-- force all vertical splits to go right of the current window
  synmaxcol = 200,          -- stop syntax highlighting at col 200 to speed up vim
  tabstop = 2,							-- insert 2 spaces for a tab
  termguicolors = true,
  timeoutlen = 400,         -- go fast
  title = true,							-- set title of window to filename [+=-] path
  ttimeoutlen = 0,						-- time waited for a mapped key sequence to complete (-1 default)
  undodir = '~/.vim/undo-dir',
  undofile = true,
  undolevels = 1000,
  undoreload = 1000,
  updatetime = 300,						-- faster completion (4000ms default)
  virtualedit = 'all',          -- move cursor anywhere
  wildmenu = true,						-- shows command line completion in window just above command line
  wrap = false,							-- display lines as one long ling
}

for name, value in pairs(options) do
  vim.opt[name] = value
end

-- Remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]
-- Dont auto comment new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- Colorscheme
cmd [[colorscheme nord]]
