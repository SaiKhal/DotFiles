return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  -- No keybindings, just let it exist for xcodebuild
  config = function()
    require("telescope").setup({})
  end,
}
