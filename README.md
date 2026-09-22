# NixVim Configuration

This repo was originally based of `dc-tec/nixvim`; I think that we are to far gone from that point to simply be counted as the same.

This repo is alsp part of the [.dotfiles](https://github.com/loeclos/.dotfiles) project.

This configuration mirrors [LazyVim](https://www.lazyvim.org/configuration) as closely as
nixvim allows: same options, autocmds, keymaps, dashboard, and core plugin set
(snacks picker/explorer/dashboard, blink.cmp, tokyonight, trouble, flash, persistence,
grug-far, nvim-lint, ...).

## How to use

You can use this flake as an input:

```nix
{
    inputs = {
        nixvim.url = "github:loeclos/nixvim"
    };
}
```

You can then install the package either normally or through home-manager.

#### Normal:

```nix
environment.systemPackages = [
    inputs.nixvim.packages.x86_64-linux.default
];
```

#### Home-Manager

```nix
home-manager.users.<user>.home.packages = [
    inputs.nixvim.packages.x86_64-linux.default
];
```

## Plugins

### General Configuration

- `settings.nix`: LazyVim `options.lua` equivalent (options + globals).
- `keymaps.nix`: LazyVim `keymaps.lua` equivalent.
- `auto_cmds.nix`: LazyVim `autocmds.lua` equivalent.
- `file_types.nix`: Configures file type specific settings.

### Themes

- `default.nix`: tokyonight (LazyVim default colorscheme).

### Completion

- `cmp.nix`: blink.cmp (LazyVim default engine) + friendly-snippets.
- `schemastore.nix`: JSON/YAML schemas.
- `lspkind.nix`, `autopairs.nix`: disabled (blink.cmp / mini.pairs cover this, like LazyVim).

### Snippets

- `luasnip.nix`: LuaSnip snippet engine (used by blink.cmp).

### Editor Plugins and Configurations

- `flash.nix`, `trouble.nix`, `grug-far.nix`: LazyVim core.
- `ts-comments.nix`, `lazydev.nix`: LazyVim coding core.
- `treesitter.nix`: TreeSitter + textobjects (LazyVim move/select/swap keys).
- `todo-comments.nix`: snacks picker + Trouble sources.
- `noice.nix`: LazyVim noice spec.
- `navic.nix`: code context (shown via lualine).
- `neo-tree.nix`, `undotree.nix`, `illuminate.nix`, `indent-blankline.nix`: disabled in
  favour of the snacks explorer / picker.undo / snacks.words / snacks indent, like LazyVim.
- `emmet.nix`, `tailwindcss.nix`: extra language servers (not LazyVim core).

### UI Plugins

- `bufferline.nix`: LazyVim bufferline spec (Snacks.bufdelete, diagnostics indicator).
- `lualine.nix`: LazyVim lualine spec (auto theme, noice status, gitsigns diff, clock).
- Dashboard: snacks dashboard with the LazyVim header (see `utils/snacks.nix`).

### LSP

- `lsp.nix`: Neovim LSP client with LazyVim keymaps (snacks pickers, codelens, ...).
- `conform.nix`: formatting (LazyVim formatting core).
- `lint.nix`: nvim-lint (LazyVim linting core, binaries from Nix).
- `rust.nix`, `eslint.nix`: extra language support (not LazyVim core).
- `fidget.nix`: disabled (snacks notifier shows LSP progress, like LazyVim).

### Git

- `lazygit.nix`: `Snacks.lazygit` (`<leader>gg`/`<leader>gG`).
- `gitsigns.nix`: LazyVim signs + hunks keymaps.

### Utils

- `snacks.nix`: snacks.nvim core (indent/input/notifier/scope/scroll/words/picker/explorer/
  dashboard/bigfile/quickfile), LazyVim toggle keymaps, picker/explorer/scratch/git keymaps.
- `telescope.nix`: fallback picker only (`lazyvim_picker = "auto"` behaviour).
- `persistence.nix`: sessions (`<leader>qs`/`qS`/`ql`/`qd`).
- `whichkey.nix`: which-key groups.
- `mini.nix`: mini.ai / mini.pairs / mini.icons / mini.surround / mini.bufremove
  (LazyVim coding/UI specs; mini.icons mocks nvim-web-devicons).
- `web-devicons.nix`: disabled (mocked by mini.icons, like LazyVim).
- `toggleterm.nix`: floating terminal behind the LazyVim terminal keymaps
  (`<leader>ft`/`<leader>fT`/`<C-/>`).
- `obsidian.nix`, `markdown-preview.nix`, `extra_plugins.nix`: personal extras.

## Known deviations from LazyVim

Nix manages plugins declaratively, so there is no `lazy.nvim` UI:

- `<leader>l` (Lazy) shows a hint instead of opening lazy.nvim; the dashboard `l` key does the same.
- `<leader>cm` (Mason) does not exist; LSP/linter binaries come from Nix
  (`plugins/lsp/*.nix`, `extraPackages`).
- `<leader>gD` (git diff against origin) has no equivalent picker bound.
- Terminal keymaps are served by toggleterm instead of `Snacks.terminal`.
- Trouble symbols are not injected into lualine (`vim.g.trouble_lualine` is still set).
- The snacks picker `flash` integration (`<a-s>`/`s` inside the picker) is not configured.
- Extra language servers (rust, eslint, emmet, tailwind, helm, ...), obsidian,
  markdown-preview and toggleterm are personal additions on top of LazyVim core.

## References

This configuration has taken inspiration from the following contributors.

- [DC-Tec](https://github.com/dc-tec/nixvim)
- [Elythh](https://github.com/elythh/nixvim)
- [MikaelFangel](https://github.com/MikaelFangel/nixvim-config)
