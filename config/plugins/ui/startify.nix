{ ... }:
{
  plugins.startify = {
    enable = true;

    settings = {
      # --- Header ---
      custom_header = [
        "                                                                       "
        "                                                                     "
        "       ████ ██████           █████      ██                     "
        "      ███████████             █████                             "
        "      █████████ ███████████████████ ███   ███████████   "
        "     █████████  ███    █████████████ █████ ██████████████   "
        "    █████████ ██████████ █████████ █████ █████ ████ █████   "
        "  ███████████ ███    ███ █████████ █████ █████ ████ █████  "
        " ██████  █████████████████████ ████ █████ █████ ████ ██████ "
        "                                                                       "
      ];

      # --- Footer ---
      custom_footer = [
        "Inspiring quote here."
      ];

      # --- Lists shown on the start screen ---
      lists = [
        {
          type = "files";
          header = [ "   Recent Files" ];
        }
        {
          type = "dir";
          header = [ { __raw = "'   MRU ' .. vim.uv.cwd()"; } ];
        }
        {
          type = "sessions";
          header = [ "   Sessions" ];
        }
        {
          type = "bookmarks";
          header = [ "   Bookmarks" ];
        }
        {
          type = "commands";
          header = [ "   Commands" ];
        }
      ];

      # --- Bookmarks (replaces the alpha "New file" / "Quit" buttons) ---
      commands = [
        {
          n = [
            "  New file"
            "enew"
          ];
        }
        {
          q = [
            " Quit Neovim"
            "qa"
          ];
        }
      ];

      # --- Behaviour tweaks ---
      files_number = 10;
      change_to_dir = false; # don't cd on file open (common preference)
      change_to_vcs_root = false;
      session_autoload = false;
      fortune_use_unicode = true; # nicer cowsay box if UTF-8
    };
  };
}
