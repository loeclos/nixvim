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
      rev = "82a386dda0fcc55b9a3dde8e14dc3ef155ac35e7";
      hash = "sha256-16/YFbio0Rc/g2NdlzALrIRr8Xg0dsIpRUdipYb0I50=";
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
