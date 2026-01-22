return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd("colorscheme catppuccin-mocha")
		end,
		mini = {
			enabled = true,
			indentscope_color = "", -- catppuccin color (eg. `lavender`) Default: text
		},
	},
	"shaunsingh/nord.nvim",
	"tssm/fairyfloss.vim",
	"kyazdani42/blue-moon",
	"arcticicestudio/nord-vim",
	"rebelot/kanagawa.nvim",
}
