# Personal theme choice: srcery (wired as an extra plugin since nixvim has no
# built-in srcery module). LazyVim default would be tokyonight.
# See https://www.lazyvim.org/plugins/colorscheme
{ pkgs, ... }:
{
  colorschemes = {
    gruvbox.enable = false;
    tokyonight.enable = false;
  };

  colorscheme = "srcery";

  extraPlugins = with pkgs.vimPlugins; [
    srcery-vim
  ];
}
