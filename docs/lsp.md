# LSP & formatters

Modern stack for **Neovim 0.11+** — no lsp-zero, no null-ls. Uses `vim.lsp.enable`, **conform.nvim**, **blink.cmp**.

## Scope

| Area | LSP (Mason) | Format (conform) |
|------|-------------|------------------|
| C / C++ | `clangd` | `clang-format` |
| TypeScript / JavaScript / TSX / JSX | `ts_ls`, `eslint` | `prettierd` / `prettier` |
| HTML / CSS / JSON | `html`, `cssls`, `jsonls` | prettier |
| Tailwind | `tailwindcss` | — |

Not installed: Python, Rust, Lua LSP, Biome LSP, cmake, mypy, ruff, etc.

## Where things live

| Concern | Path |
|--------|------|
| Plugin specs | `lua/plugins/lsp.lua`, `lua/plugins/formatters.lua` |
| LSP servers | `lua/config/lsp.lua` |
| Formatters | `lua/config/formatters.lua` |
| Keymaps | `lua/config/keymaps.lua` |
| Autocommands | `lua/config/autocmds.lua` |

## LSP keymaps (buffer-local)

`gd` `gD` `gi` `gr` `K` `<C-h>` (insert) `<leader>rn` `<leader>ca`

## Global

`[d` `]d` `<leader>e` diagnostics · `<leader>f` format · `<leader>cm` Mason

## Commands

`:Mason` · `:ConformInfo` · `:checkhealth vim.lsp` · `:TSUpdate` · `:TSInstall tsx`

TSX highlighting needs the **tsx** treesitter parser (not plain `typescript`). Run `:TSInstall tsx` if `.tsx` files look uncolored.

## C projects

`clangd` wants `compile_commands.json` (CMake: `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`) or `compile_flags.txt`.

## First run

`:Lazy sync` then `:Mason` to confirm servers. Install `tree-sitter-cli` for treesitter parsers.
