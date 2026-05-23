local M = {}

local diagnostic_signs = {
  [vim.diagnostic.severity.ERROR] = "E",
  [vim.diagnostic.severity.WARN] = "W",
  [vim.diagnostic.severity.HINT] = "H",
  [vim.diagnostic.severity.INFO] = "I",
}

function M.setup()
  vim.diagnostic.config({
    signs = { text = diagnostic_signs },
    virtual_text = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = true,
      header = "",
      prefix = "",
    },
  })

  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    },
  })

  -- TypeScript + JavaScript (ts_ls covers .ts, .tsx, .js, .jsx)
  vim.lsp.config("ts_ls", {
    filetypes = require("config.formatters").js_ts_filetypes,
    root_markers = { "package.json", "tsconfig.json", "jsconfig.json", "node_modules" },
    settings = {
      typescript = {
        format = { enable = false },
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
      javascript = {
        format = { enable = false },
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    },
  })

  vim.lsp.config("eslint", {
    filetypes = require("config.formatters").js_ts_filetypes,
    settings = {
      workingDirectories = { mode = "auto" },
    },
  })

  vim.lsp.config("tailwindcss", {
    filetypes = {
      "css",
      "scss",
      "sass",
      "html",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
      "heex",
    },
    root_markers = {
      "tailwind.config.js",
      "tailwind.config.ts",
      "tailwind.config.cjs",
      "tailwind.config.mjs",
      "postcss.config.js",
      "postcss.config.mjs",
      "package.json",
    },
    settings = {
      tailwindCSS = {
        includeLanguages = {
          typescript = "javascript",
          typescriptreact = "javascript",
        },
        experimental = {
          classRegex = {
            { "cva%(([^)]*)%)" },
            { "[\"'`]([^\"'`]*).*?[\"'`]" },
          },
        },
      },
    },
  })

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "ts_ls",
      "eslint",
      "tailwindcss",
      "pyright",
      "jsonls",
      "html",
      "cssls",
      "bashls",
      "rust_analyzer",
    },
    handlers = {
      function(server)
        vim.lsp.enable(server)
      end,
    },
  })
end

return M
