local M = {}

function M.setup()
  require("config.options").setup()
  require("config.keymaps").setup()
  require("config.autocmds").setup()
  require("config.lazy").setup()
end

M.setup()

return M
