# Telescope stays installed as a fallback picker (LazyVim `lazyvim_picker = "auto"`
# falls back to it), but all default finder keymaps live in utils/snacks.nix
# (Snacks.picker), like LazyVim.
{
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native = {
        enable = true;
      };
    };
    settings = {
      defaults = {
        layout_config = {
          horizontal = {
            prompt_position = "top";
          };
        };
        sorting_strategy = "ascending";
      };
    };
  };
}
