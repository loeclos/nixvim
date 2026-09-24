# Browser-based live preview (LazyVim `lang.markdown` extra).
# See https://www.lazyvim.org/extras/lang/markdown
# Complements `render-markdown.nix` (in-buffer rendering): this opens a
# GitHub-flavoured live preview in your default browser.
_: {
  plugins = {
    markdown-preview = {
      enable = true;
      settings = {
        # No `browser` override: use the system default ($BROWSER /
        # xdg-open / open) so this works on NixOS and Darwin.
        echo_preview_url = 1;
        theme = "dark";
        preview_options = {
          disable_filename = 0;
          disable_sync_scroll = 0;
          sync_scroll_type = "middle";
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>cp";
      action = "<cmd>MarkdownPreviewToggle<cr>";
      options = {
        desc = "Markdown Preview (browser)";
      };
    }
  ];
}
