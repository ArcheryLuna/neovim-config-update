local M = {}

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function pick_recent()
  local files = {}
  for _, path in ipairs(vim.v.oldfiles) do
    if vim.fn.filereadable(path) == 1 then
      files[#files + 1] = vim.fn.fnamemodify(path, ":p")
    end
  end

  if #files == 0 then
    vim.notify("No recent files", vim.log.levels.INFO)
    return
  end

  vim.ui.select(files, { prompt = "Recent files", kind = "file" }, function(path)
    if path then
      vim.cmd.edit(vim.fn.fnameescape(path))
    end
  end)
end

function M.on_lsp_attach(event)
  local bufmap = function(mode, lhs, rhs, desc)
    map(mode, lhs, rhs, { buffer = event.buf, desc = desc })
  end

  bufmap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
  bufmap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
  bufmap("n", "gr", vim.lsp.buf.references, "List references")
  bufmap("n", "K", vim.lsp.buf.hover, "Hover documentation")
  bufmap("i", "<C-h>", vim.lsp.buf.signature_help, "Signature help")
  bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
  bufmap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
end

function M.setup()
  -- General
  map("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear search highlight" })
  map("n", "Q", "<nop>", { desc = "Disable Ex mode" })

  map("i", "<C-c>", "<Esc>", { desc = "Leave insert mode" })
  map("i", "jk", "<Esc>", { desc = "Leave insert mode" })

  map("n", "J", "mzJ`z", { desc = "Join lines" })
  map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
  map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

  map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
  map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
  map("n", "n", "nzzzv", { desc = "Next search match" })
  map("n", "N", "Nzzzv", { desc = "Previous search match" })

  map({ "n", "i", "v" }, "<Up>", "<nop>", { desc = "Disable arrow up" })
  map({ "n", "i", "v" }, "<Down>", "<nop>", { desc = "Disable arrow down" })
  map({ "n", "i", "v" }, "<Left>", "<nop>", { desc = "Disable arrow left" })
  map({ "n", "i", "v" }, "<Right>", "<nop>", { desc = "Disable arrow right" })

  -- Leader: files & buffers
  map("n", "<leader>w", "<cmd>write<cr>", { desc = "Write buffer" })
  map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
  map("n", "<leader>Q", "<cmd>quitall<cr>", { desc = "Quit Neovim" })
  map("n", "<leader>x", "<cmd>!chmod +x %<cr>", { desc = "Make file executable" })

  -- Barbar (buffers)
  map("n", "<leader>,", vim.cmd.BufferPrevious, { desc = "Buffer previous" })
  map("n", "<leader>.", vim.cmd.BufferNext, { desc = "Buffer next" })
  map("n", "<leader><", vim.cmd.BufferMovePrevious, { desc = "Move buffer left" })
  map("n", "<leader>>", vim.cmd.BufferMoveNext, { desc = "Move buffer right" })
  map("n", "<leader>bp", vim.cmd.BufferPin, { desc = "Pin buffer" })
  map("n", "<leader>cl", vim.cmd.BufferClose, { desc = "Close buffer" })
  map("n", "<C-s>", vim.cmd.BufferPick, { desc = "Pick buffer" })
  map("n", "<leader>bd", vim.cmd.BufferOrderByDirectory, { desc = "Sort buffers by path" })
  map("n", "<leader>bl", vim.cmd.BufferOrderByLanguage, { desc = "Sort buffers by language" })
  map("n", "<leader>bw", vim.cmd.BufferOrderByWindowNumber, { desc = "Sort buffers by window" })

  map("x", "<leader>p", [["_dP]], { desc = "Paste without yank" })
  map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })
  map("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })
  map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yank" })

  map({ "n", "v" }, "<leader>f", function()
    require("config.formatters").format({ async = true, bufnr = 0 })
  end, { desc = "Format buffer" })

  map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
    desc = "Replace word under cursor",
  })
  map("n", "<leader><leader>", function()
    vim.cmd.source("%")
  end, { desc = "Source current file" })

  -- Leader: navigation & lists
  map("n", "<leader>o", pick_recent, { desc = "Open recent file" })
  map("n", "<leader>n", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree" })
  map("n", "<leader>N", "<cmd>Neotree float filesystem reveal_force_cwd=true<cr>", {
    desc = "Find file (Neo-tree)",
  })
  map("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })

  map("n", "<C-k>", "<cmd>cnext<cr>zz", { desc = "Next quickfix item" })
  map("n", "<C-j>", "<cmd>cprev<cr>zz", { desc = "Previous quickfix item" })
  map("n", "<leader>k", "<cmd>lnext<cr>zz", { desc = "Next location item" })
  map("n", "<leader>j", "<cmd>lprev<cr>zz", { desc = "Previous location item" })

  -- Diagnostics (global)
  map("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, { desc = "Previous diagnostic" })
  map("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, { desc = "Next diagnostic" })
  map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnostic float" })

  -- Leader: tools
  map("n", "<leader>cm", "<cmd>Mason<cr>", { desc = "Open Mason" })
  map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy" })
  map("n", "<leader>ec", "<cmd>edit " .. vim.fn.stdpath("config") .. "/init.lua<cr>", {
    desc = "Edit Neovim config",
  })

  -- Tmux
  map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<cr>", { desc = "Tmux sessionizer" })
end

return M
