_: {
  imports = [
    # General Configuration
    ./settings.nix
    ./keymaps.nix
    ./auto_cmds.nix
    ./file_types.nix

    # Themes (LazyVim default: tokyonight)
    ./plugins/themes

    # Completion (LazyVim default: blink.cmp)
    ./plugins/cmp/cmp.nix
    ./plugins/cmp/lspkind.nix
    ./plugins/cmp/autopairs.nix
    ./plugins/cmp/schemastore.nix

    # Snippets
    ./plugins/snippets/luasnip.nix

    # Editor plugins and configurations
    ./plugins/editor/ts-comments.nix
    ./plugins/editor/lazydev.nix
    ./plugins/editor/emmet.nix
    ./plugins/editor/neo-tree.nix
    ./plugins/editor/treesitter.nix
    ./plugins/editor/undotree.nix
    ./plugins/editor/illuminate.nix
    ./plugins/editor/indent-blankline.nix
    ./plugins/editor/tailwindcss.nix
    ./plugins/editor/todo-comments.nix
    ./plugins/editor/navic.nix
    ./plugins/editor/noice.nix
    ./plugins/editor/flash.nix
    ./plugins/editor/trouble.nix
    ./plugins/editor/grug-far.nix

    # UI plugins (dashboard comes from snacks)
    ./plugins/ui/bufferline.nix
    ./plugins/ui/lualine.nix

    # LSP and formatting
    ./plugins/lsp/eslint.nix
    ./plugins/lsp/lsp.nix
    ./plugins/lsp/conform.nix
    ./plugins/lsp/rust.nix
    ./plugins/lsp/fidget.nix
    ./plugins/lsp/lint.nix

    # Git
    ./plugins/git/lazygit.nix
    ./plugins/git/gitsigns.nix

    # Utils
    ./plugins/utils/snacks.nix
    ./plugins/utils/telescope.nix
    ./plugins/utils/whichkey.nix
    ./plugins/utils/extra_plugins.nix
    ./plugins/utils/mini.nix
    ./plugins/utils/markdown-preview.nix
    ./plugins/utils/obsidian.nix
    ./plugins/utils/toggleterm.nix
    ./plugins/utils/web-devicons.nix
    ./plugins/utils/persistence.nix
  ];
}
