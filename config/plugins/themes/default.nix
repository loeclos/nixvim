# Personal theme choice: kape (https://github.com/kape-theme/nvim).
# Not packaged in nixpkgs, so it is pinned from GitHub below.
# LazyVim default would be tokyonight: https://www.lazyvim.org/plugins/colorscheme
{ pkgs, ... }:
let
  kape-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "kape-nvim";
    version = "2026-06-24";
    src = pkgs.fetchFromGitHub {
      owner = "kape-theme";
      repo = "nvim";
      rev = "ea0235dfd3745344dde4f19e337afd1316eb8c7d";
      hash = "sha256-7aeO7gs+RC0qif5PwSKB/+1hGL5AhzLSfA5J2uO62cI=";
    };
  };
in
{
  colorschemes = {
    gruvbox.enable = false;
    tokyonight.enable = false;
  };

  colorscheme = "kape";

  extraPlugins = [
    kape-nvim
  ];
}
