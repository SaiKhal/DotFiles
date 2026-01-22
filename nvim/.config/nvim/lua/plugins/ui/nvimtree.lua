 -- File tree
 return {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    keys = {
      { "<leader>t", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Tree" },
    },
    config = function()
      require("nvim-tree").setup({
        hijack_cursor = true,
        open_on_tab = true,
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
        diagnostics = {
          enable = false,
        },
        view = {
          adaptive_size = true,
          width = 30,
          side = "left",
          number = false,
        },
      })
    end,
}