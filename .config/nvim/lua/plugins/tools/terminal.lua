return {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<A-\>]],
        direction = "horizontal",
        close_on_exit = true,
        start_in_insert = true,
      })
    end,
}