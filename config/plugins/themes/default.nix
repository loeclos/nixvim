# Personal theme choice: pure (https://github.com/loeclos/pure.nvim).
# Not packaged in nixpkgs, so it is pinned from GitHub below.
# LazyVim default would be tokyonight: https://www.lazyvim.org/plugins/colorscheme
{ pkgs, ... }:
let
  pure-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "pure.nvim";
    version = "2026-10-05";
    src = pkgs.fetchFromGitHub {
      owner = "loeclos";
      repo = "pure.nvim";
      rev = "cd12173d8840aa915faf1dbf8b46fd81e4e79795";
      hash = "sha256-uV3FP42/rI5RuFeoBSUv9nM6Bu5OH/YKpk/7PFECRtM=";
    };
  };
in
{
  colorschemes = {
    gruvbox.enable = false;
    tokyonight.enable = false;
  };

  colorscheme = "pure";

  extraPlugins = [
    pure-nvim
  ];
}
