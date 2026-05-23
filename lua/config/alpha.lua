local M = {}

local function version_line()
  local v = vim.version()
  local label = string.format("v%d.%d.%d", v.major, v.minor, v.patch)
  if v.prerelease then
    label = label .. " (dev)"
  end
  return "Neovim " .. label
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

function M.setup()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")
  local fortune = require("alpha.fortune")

  local function btn(key, glyph, name, action)
    return dashboard.button(key, string.format("%s  %s", glyph, name), action, {
      desc = name,
    })
  end

  dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
    "             " .. version_line(),
  }
  dashboard.section.header.opts.hl = "AlphaHeader"

  dashboard.section.buttons.val = {
    btn("n", "󰝰", "New file", ":ene <BAR> startinsert <CR>"),
    btn("f", "󰍉", "Find file", function()
      vim.cmd("Neotree float filesystem reveal_force_cwd=true")
    end),
    btn("r", "󰋚", "Recent files", pick_recent),
    btn("e", "󰙅", "File explorer", ":Neotree toggle<CR>"),
    btn("c", "󰒓", "Edit config", ":edit " .. vim.fn.stdpath("config") .. "/init.lua<CR>"),
    btn("l", "󰒲", "Lazy", ":Lazy<CR>"),
    btn("q", "󰗼", "Quit", ":qa<CR>"),
  }
  dashboard.section.buttons.opts.hl = "AlphaButtons"

  dashboard.section.footer.val = fortune({ max_width = 56 })
    .. "\n\n  Press a key · leader = Space"
  dashboard.section.footer.opts.hl = "AlphaFooter"

  dashboard.opts.layout = {
    { type = "padding", val = 1 },
    dashboard.section.header,
    { type = "padding", val = 1 },
    dashboard.section.buttons,
    { type = "padding", val = 1 },
    dashboard.section.footer,
  }

  dashboard.opts.opts.noautocmd = true

  alpha.setup(dashboard.opts)
end

return M
