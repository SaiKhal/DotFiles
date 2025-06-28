return {
	-- Core dependencies
	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",

	-- Import all plugin categories
	{ import = "plugins.ui" },
	{ import = "plugins.tools" },
	{ import = "plugins.editing" },
	{ import = "plugins.lsp" },
	--   { import = "plugins.lang" },
}
