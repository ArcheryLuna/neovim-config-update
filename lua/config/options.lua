local M = {}

function M.setup()
  vim.g.mapleader = " "
  vim.g.maplocalleader = "\\"

  vim.opt.number = true
  vim.opt.relativenumber = true

  vim.opt.cursorline = true
  vim.opt.scrolloff = 8
  vim.opt.colorcolumn = "0"

  vim.opt.tabstop = 4
  vim.opt.softtabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.expandtab = true
  vim.opt.smartindent = true

  vim.opt.wrap = false
  vim.opt.isfname:append("@-@")

  vim.opt.swapfile = false
  vim.opt.backup = false
  vim.opt.undofile = true
  vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

  vim.opt.termguicolors = true
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

  vim.opt.updatetime = 50
end

return M
