-- Custom autocommands that extend LazyVim's defaults
-- LazyVim's default autocmds: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Create custom augroup for our autocmds
local custom_group = augroup("CustomAutocmds", { clear = true })

-- Remove whitespace on save
autocmd("BufWritePre", {
  group = custom_group,
  pattern = "*",
  command = [[:%s/\s\+$//e]],
  desc = "Remove trailing whitespace on save",
})

-- Don't auto comment new lines
autocmd("BufEnter", {
  group = custom_group,
  pattern = "*",
  command = [[set fo-=c fo-=r fo-=o]],
  desc = "Disable auto-commenting on new lines",
})