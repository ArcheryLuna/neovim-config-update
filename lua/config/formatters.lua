local M = {}

local prettier = { "prettierd", "prettier", stop_after_first = true }

local js_ts = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx",
}

function M.setup()
  require("conform").setup({
    formatters_by_ft = {
      javascript = prettier,
      javascriptreact = prettier,
      ["javascript.jsx"] = prettier,
      typescript = prettier,
      typescriptreact = prettier,
      ["typescript.tsx"] = prettier,
      json = prettier,
      jsonc = prettier,
      html = prettier,
      css = prettier,
      scss = prettier,
      markdown = prettier,
      yaml = prettier,
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

M.js_ts_filetypes = js_ts

return M
