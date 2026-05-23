# LSP & formatters

## Where things live

| Concern | Path |
|--------|------|
| Plugin specs (LSP) | `lua/plugins/lsp.lua` |
| Plugin specs (formatters) | `lua/plugins/formatters.lua` |
| LSP config, servers, keymaps | `lua/config/lsp.lua` |
| Prettier / conform | `lua/config/formatters.lua` |
| All keymaps | `lua/config/keymaps.lua` |
| Autocommands | `lua/config/autocmds.lua` |

## Stack

- **mason.nvim** — LSP servers + CLI tools
- **mason-lspconfig.nvim** — LSP ↔ Mason
- **mason-tool-installer.nvim** — Prettier, eslint_d
- **nvim-lspconfig** — server definitions (`vim.lsp.enable`)
- **conform.nvim** — format on save + `<leader>f`
- **blink.cmp** — completion

## TypeScript & JavaScript

| Tool | Role |
|------|------|
| `ts_ls` | Types, go-to-def, rename, completions |
| `eslint` | ESLint diagnostics + fixable rules from project config |
| `prettierd` / `prettier` | Format via conform (LSP format disabled on `ts_ls` to avoid fights) |

Filetypes: `javascript`, `javascriptreact`, `typescript`, `typescriptreact`, plus `.jsx` / `.tsx` variants.

Needs a project root (`package.json`, `tsconfig.json`, or `jsconfig.json`).

## Tailwind CSS

| Tool | Role |
|------|------|
| `tailwindcss` | Class completion, lint, `@apply` / variant hints in JS/TS/HTML/CSS |

Works best with `tailwind.config.*` or Tailwind in `package.json`. Class regex includes `cva()` and quoted strings for utility-in-JS patterns.

## Other LSP servers

`lua_ls`, `pyright`, `jsonls`, `html`, `cssls`, `bashls`, `rust_analyzer`

Edit `ensure_installed` in `lua/config/lsp.lua` or tools in `lua/plugins/formatters.lua`.

## Keymaps

All bindings live in `lua/config/keymaps.lua`. Press `<Space>` for which-key.

**LSP (buffer-local when attached):** `gd`, `gD`, `gi`, `gr`, `K`, `<leader>rn`, `<leader>ca`

**Diagnostics (global):** `[d`, `]d`, `<leader>e`

**Tools:** `<leader>f` format, `<leader>cm` Mason, `<leader>n` / `<leader>N` Neo-tree, `<leader>u` undotree

Format on save enabled for JS/TS (and other conform filetypes).

## Commands

- `:Mason` — servers & tools
- `:ConformInfo` — formatter for current buffer
- `:checkhealth vim.lsp` — LSP health

## First run

Open Neovim in a JS/TS project. Mason installs `ts_ls`, `eslint`, `tailwindcss`, and `prettierd`. Run `:Mason` if anything is missing.
