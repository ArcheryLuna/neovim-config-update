local M = {}

function M.setup()
  local augroup = vim.api.nvim_create_augroup("config", { clear = true })

  vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    desc = "Highlight yanked text",
    callback = function()
      vim.hl.on_yank({ higroup = "IncSearch", timeout = 500 })
    end,
  })

  vim.api.nvim_create_autocmd("VimResized", {
    group = augroup,
    desc = "Equalize window heights on resize",
    callback = function()
      vim.cmd("tabdo wincmd =")
    end,
  })

  vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    desc = "Restore cursor position",
    callback = function(args)
      if vim.bo[args.buf].buftype ~= "" or vim.b[args.buf].alpha then
        return
      end
      local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
      local lcount = vim.api.nvim_buf_line_count(args.buf)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "alpha",
    desc = "Alpha dashboard buffer options",
    callback = function()
      vim.b.alpha = true
      vim.opt_local.foldenable = false
      vim.opt_local.list = false
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = "no"
    end,
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup,
    desc = "Buffer LSP keymaps",
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client or client.server_capabilities == nil then
        return
      end
      require("config.keymaps").on_lsp_attach(args)
    end,
  })
end

return M
