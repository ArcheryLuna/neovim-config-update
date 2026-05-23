return {
  {
    "goolord/alpha-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "BlakeJC94/alpha-nvim-fortune",
    },
    event = "VimEnter",
    config = function()
      require("config.alpha").setup()
    end,
  },
}
