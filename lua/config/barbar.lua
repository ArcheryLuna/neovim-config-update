local M = {}

function M.setup()
  require("barbar").setup({
    animation = true,
    clickable = true,
    auto_hide = 1,
    exclude_ft = { "alpha", "neo-tree" },
    highlight_visible = true,
    tabpages = true,
    insert_at_end = false,
    maximum_padding = 1,
    minimum_padding = 1,
    icons = {
      buffer_index = false,
      filetype = { enabled = true },
      separator = { left = "▎", right = "" },
      modified = { button = "●" },
      pinned = { button = "󰐃", filename = true },
      inactive = { button = "×" },
      visible = { button = "×" },
    },
    sidebar_filetypes = {
      ["neo-tree"] = {
        text = "Neo-tree",
        align = "left",
      },
    },
  })
end

return M
