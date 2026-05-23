local M = {}

local prettier = { "prettierd", "prettier", stop_after_first = true }
local clang = { "clang_format", "clang-format", stop_after_first = true }

M.js_ts_filetypes = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx",
  "tsx",
}

function M.setup()
  require("conform").setup({
    formatters_by_ft = {
      -- JS / TS
      javascript = prettier,
      javascriptreact = prettier,
      ["javascript.jsx"] = prettier,
      typescript = prettier,
      typescriptreact = prettier,
      ["typescript.tsx"] = prettier,
      tsx = prettier,
      jsx = prettier,
      -- Web
      html = prettier,
      css = prettier,
      scss = prettier,
      json = prettier,
      jsonc = prettier,
      -- C / C++
      c = clang,
      cpp = clang,
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  })
end

function M.format(opts)
  return require("conform").format(opts)
end

return M
