local cmd = vim.cmd

local options = {
  backup = false,						-- creates a backup file
  clipboard = 'unnamedplus',					-- allows neovim to access the system clipboard
  completeopt = { 'menuone', 'noselect', 'noinsert' },		-- mostly for cmp
  cursorline = true,						-- highlight the current line
  hidden = true,						-- buffer becomes hidden when abondoned
  inccommand = 'split',						-- shows the effects of text substitution as you type
  mouse = 'a',							-- allow the mouse to be used in neovim
  number = true,						-- show line numbers
  relativenumber = true,					-- show relative line numbers
  splitbelow = true,						-- force all horizontal splits to go below current window
  splitright = true,						-- force all vertical splits to go right of the current window
  title = true,							-- set title of window to filename [+=-] path
  ttimeoutlen = 0,						-- time waited for a mapped key sequence to complete (-1 default)
  ignorecase = true,						-- ignore case in search patterns
  smartindent = true,						-- make indenting smarter again
  updatetime = 300,						-- faster completion (4000ms default)
  numberwidth = 2, 						-- set number column width (4 default)
  tabstop = 2,							-- insert 2 spaces for a tab
  wrap = false,							-- display lines as one long ling
  scrolloff = 8,						  -- determines number of lines shown above/below cursor
  sidescrolloff = 8,						-- same
  expandtab = true,						-- Use spaces instead of tab
  shiftwidth = 2,						-- number of spaces to use during autoindent
  wildmenu = true,						-- shows command line completion in window just above command line
  termguicolors = true
}

for name, value in pairs(options) do
  vim.opt[name] = value
end

-- Remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]
-- Dont auto comment new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- Colorscheme
cmd [[colorscheme blue-moon]]
