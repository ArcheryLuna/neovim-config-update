return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "prettierd",
        "prettier",
        "eslint_d",
      },
      auto_update = false,
      run_on_start = true,
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    opts = {},
    config = function()
      require("config.formatters").setup()
    end,
  },
}
