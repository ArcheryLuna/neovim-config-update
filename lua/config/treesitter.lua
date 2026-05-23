local M = {}

-- C + TS/JS/TSX/JSX + web (+ lua/vim for editing this config)
M.parsers = {
  "c",
  "cpp",
  "typescript",
  "tsx",
  "javascript",
  "html",
  "css",
  "json",
  "lua",
  "vim",
  "vimdoc",
  "query",
}

local highlight_by_ft = {
  typescriptreact = "tsx",
  typescript = "typescript",
  javascriptreact = "javascript",
  javascript = "javascript",
}

function M.attach_highlight(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  local lang = highlight_by_ft[ft] or vim.treesitter.language.get_lang(ft)
  if not lang then
    return
  end
  pcall(vim.treesitter.start, buf, lang)
end

function M.setup()
  require("nvim-treesitter").setup()

  local group = vim.api.nvim_create_augroup("config.treesitter", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = {
      "typescript",
      "typescriptreact",
      "tsx",
      "javascript",
      "javascriptreact",
      "jsx",
      "html",
      "css",
      "json",
      "c",
      "cpp",
      "lua",
      "vim",
    },
    callback = function(args)
      M.attach_highlight(args.buf)
    end,
  })

  if vim.fn.executable("tree-sitter") ~= 1 then
    vim.notify(
      "tree-sitter CLI missing — parsers won't compile. Install: sudo pacman -S tree-sitter-cli",
      vim.log.levels.WARN
    )
    return
  end

  require("nvim-treesitter").install(M.parsers)
end

return M
