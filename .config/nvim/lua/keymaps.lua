local opts = { noremap = true }

local term_opts = { silent = true }

-- Shortern function name
local keymap = vim.api.nvim_set_keymap

-- Remap leader key
keymap("", "<Space>", "<Nop>", opts)      -- Set Space to Nop
vim.g.mapleader = " "                     -- Set leader to space
vim.g.maplocalleader = " "

-- Modes
-- * normal       = "n"
-- * insert       = "i"
-- * visual       = "v"
-- * visual_block = "x"
-- * terminal     = "t"
-- * command      = "c"


-- Normal Mode --
-- Window navigation --
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)
keymap("n", ",,", "<C-^>", opts)        -- Switch back to last buffer

-- Resize with arrows --
keymap("n", "<A-Up>", ":resize +2<CR>", opts)
keymap("n", "<A-Down>", ":resize -2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":resize +2<CR>", opts)

-- Move to start/end of line easily
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)

-- Escape --
keymap("n", "<ESC>", ":noh<CR>", term_opts)

-- Telescope --
keymap("n", "<leader>ff", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>fg", ":Telescope repo list<cr>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<cr>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<cr>", opts)

-- Nvim tree --
keymap("n", "<leader>t", ":NvimTreeToggle<CR>", opts)


-- Visual Mode --
-- Stay in indent mode when tabbing --
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Keep A in paste regi when pasting A over B --
keymap("v", "p", '"_dP', opts)


-- Visual Block Mode --
-- Move text up and down --
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)


-- Insert Mode --
-- Quicker ESC --
keymap("i", "jk", "<ESC>", opts)


-- Terminal Mode --
-- Window Navigation --
keymap("t", "<A-h>", "<C-\\><C-n><C-w>h", term_opts)
keymap("t", "<A-j>", "<C-\\><C-n><C-w>j", term_opts)
keymap("t", "<A-k>", "<C-\\><C-n><C-w>k", term_opts)
keymap("t", "<A-l>", "<C-\\><C-n><C-w>l", term_opts)
keymap("t", "<ESC>", "<C-\\><C-n>", term_opts)
keymap("t", "jj", "<C-\\><C-n>", term_opts)

