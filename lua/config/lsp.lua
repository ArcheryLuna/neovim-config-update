local M = {}

M.servers = {
  "clangd",
  "ts_ls",
  "eslint",
  "tailwindcss",
  "html",
  "cssls",
  "jsonls",
}

local diagnostic_signs = {
  [vim.diagnostic.severity.ERROR] = "E",
  [vim.diagnostic.severity.WARN] = "W",
  [vim.diagnostic.severity.HINT] = "H",
  [vim.diagnostic.severity.INFO] = "I",
}

local js_ts_filetypes = require("config.formatters").js_ts_filetypes

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

  -- C / C++
  vim.lsp.config("clangd", {
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
    },
    capabilities = {
      offsetEncoding = { "utf-16" },
    },
  })

  -- TypeScript / JavaScript / TSX / JSX (ts_ls)
  vim.lsp.config("ts_ls", {
    filetypes = js_ts_filetypes,
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
    filetypes = js_ts_filetypes,
    settings = {
      workingDirectories = { mode = "auto" },
    },
  })

  -- Web: HTML / CSS / Tailwind
  vim.lsp.config("html", {
    filetypes = { "html", "htm" },
    settings = {
      html = {
        format = { enable = false },
      },
    },
  })

  vim.lsp.config("cssls", {
    filetypes = { "css", "scss", "less" },
    settings = {
      css = { validate = true },
      scss = { validate = true },
      less = { validate = true },
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
      "jsx",
      "typescript",
      "typescriptreact",
      "tsx",
      "vue",
      "svelte",
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

  vim.lsp.config("jsonls", {
    filetypes = { "json", "jsonc" },
    settings = {
      json = { format = { enable = false } },
    },
  })

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = M.servers,
    handlers = {
      function(server)
        vim.lsp.enable(server)
      end,
    },
  })
end

return M
