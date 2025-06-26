local cmd = vim.cmd

local options = {
  backup = false,						-- creates a backup file (not in LazyVim defaults)
  completeopt = { 'menuone', 'noselect', 'noinsert' },		-- LazyVim uses "menu,menuone,noselect"
  hidden = true,						-- buffer becomes hidden when abandoned (not in LazyVim defaults)
  history = 1000,						-- not in LazyVim defaults
  hlsearch = true,						-- not in LazyVim defaults
  inccommand = 'split',					-- LazyVim uses 'nosplit'
  numberwidth = 2, 					-- not in LazyVim defaults (4 default)
  synmaxcol = 200,          				-- stop syntax highlighting at col 200 (not in LazyVim defaults)
  timeoutlen = 400,         				-- LazyVim uses 300 (or 1000 in vscode)
  title = true,							-- set title of window to filename (not in LazyVim defaults)
  ttimeoutlen = 0,						-- not in LazyVim defaults
  undodir = '~/.vim/undo-dir',				-- custom undo directory (LazyVim uses default)
  undoreload = 1000,					-- not in LazyVim defaults
  updatetime = 300,						-- LazyVim uses 200
  virtualedit = 'all',          				-- LazyVim uses 'block'
  wildmenu = true,						-- not in LazyVim defaults
}

for name, value in pairs(options) do
  vim.opt[name] = value
end