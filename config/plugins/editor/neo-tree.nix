# Disabled: LazyVim core uses the snacks explorer (see utils/snacks.nix
# <leader>fe/<leader>fE/<leader>e/<leader>E), neo-tree is only a LazyVim extra.
# Re-enable this and remove the snacks explorer keymaps to go back to neo-tree.
{
  plugins.neo-tree.enable = false;
}
