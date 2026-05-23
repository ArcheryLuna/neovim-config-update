# Neovim config

Modular Lua config for Neovim 0.9+.

## Layout

```
.
├── init.lua              # Entry: require("config")
├── docs/                 # Documentation (not loaded by Neovim)
├── lazy-lock.json        # lazy.nvim lockfile
└── lua/
    ├── config/
    │   ├── init.lua      # Bootstrap (options → keymaps → autocmds → lazy)
    │   ├── lazy.lua      # lazy.nvim bootstrap
    │   ├── options.lua   # vim.opt / vim.g defaults
    │   ├── keymaps.lua   # Global keymaps
    │   ├── lsp.lua       # LSP servers + attach keymaps
    │   ├── formatters.lua
    │   └── which-key.lua
    └── plugins/          # lazy.nvim specs (imported by lazy)
```

## Local overrides

Add `lua/local/` (gitignored) for machine-specific settings without committing them.

## LSP & formatters

TS/JS (`ts_ls` + `eslint`), Tailwind (`tailwindcss`), Prettier via conform. See [lsp.md](lsp.md).

## Which-key

Press `<Space>` (leader) to see key hints. Config: `lua/config/which-key.lua`.

## Adding plugins

1. Add specs in `lua/plugins/init.lua` or `lua/plugins/*.lua`
2. Bootstrap: `require("config.lazy").setup()` in `lua/config/init.lua`
