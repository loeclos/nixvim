# Orgmode (Emacs Orgmode clone for Neovim).
# See https://nvim-orgmode.github.io
# and https://nix-community.github.io/nixvim/plugins/orgmode/index.html
{
  plugins.orgmode = {
    enable = true;
    settings = {
      org_agenda_files = "~/orgfiles/**/*";
      org_default_notes_file = "~/orgfiles/refile.org";
    };
  };
}
