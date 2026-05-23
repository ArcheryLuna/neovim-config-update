local M = {}

function M.setup()
  require("which-key").setup({
    preset = "helix",
    delay = 300,
    plugins = {
      marks = true,
      registers = true,
      spelling = true,
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    spec = {
      { "<leader>b", group = "Buffers" },
      { "<leader>,", desc = "Previous buffer" },
      { "<leader>.", desc = "Next buffer" },
      { "<leader><", desc = "Move buffer left" },
      { "<leader>>", desc = "Move buffer right" },
      { "<leader>bp", desc = "Pin buffer" },
      { "<leader>bd", desc = "Sort by path" },
      { "<leader>bl", desc = "Sort by language" },
      { "<leader>bw", desc = "Sort by window" },
      { "<leader>cl", desc = "Close buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Delete" },
      { "<leader>e", group = "Diagnostics" },
      { "<leader>f", group = "Format" },
      { "<leader>j", group = "Location list" },
      { "<leader>k", group = "Location list" },
      { "<leader>n", group = "Explorer" },
      { "<leader>o", desc = "Recent files" },
      { "<leader>q", group = "Quit" },
      { "<leader>r", group = "Rename" },
      { "<leader>s", group = "Search" },
      { "<leader>u", desc = "Undotree" },
      { "<leader>w", group = "Write" },
      { "<leader>x", group = "Shell" },
      { "<leader>N", desc = "Find file" },
      { "<leader>cm", desc = "Mason" },
      { "<leader>ec", desc = "Edit config" },
      { "g", group = "Goto" },
      { "[", group = "Prev" },
      { "]", group = "Next" },
    },
  })
end

return M
