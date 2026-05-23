local M = {}

M.parsers = {
  "typescript",
  "javascript",
  "c",
  "go",
  "python",
  "html",
  "css",
  "cpp",
  "c_sharp",
  "java",
  "lua",
  "vim",
  "vimdoc",
  "query",
}

function M.setup()
  require("nvim-treesitter").setup()

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
