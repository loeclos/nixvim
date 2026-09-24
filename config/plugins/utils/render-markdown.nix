# In-buffer Markdown rendering (LazyVim `lang.markdown` extra).
# See https://www.lazyvim.org/extras/lang/markdown
# Complements `markdown-preview.nix` (browser preview):
# render-markdown styles the buffer itself (headings, code blocks,
# checkboxes, tables, callouts), no external browser needed.
{
  plugins.render-markdown = {
    enable = true;
    settings = {
      file_types = [
        "markdown"
        "norg"
        "rmd"
        "org"
        "codecompanion"
      ];
      # Blink.cmp integration (LazyVim enables LSP completions by default).
      completions = {
        lsp = {
          enabled = true;
        };
      };
      # Match LazyVim defaults.
      code = {
        sign = false;
        width = "block";
        right_pad = 1;
      };
      heading = {
        sign = false;
        icons = [ ];
      };
      checkbox = {
        enabled = false;
      };
    };
  };

  # LazyVim toggle: `<leader>um` (Render Markdown) via Snacks.toggle.
  extraConfigLua = ''
    do
      local ok_rm, render_markdown = pcall(require, "render-markdown")
      local ok_snacks, Snacks = pcall(require, "snacks")
      if ok_rm and ok_snacks and Snacks.toggle then
        Snacks.toggle({
          name = "Render Markdown",
          get = render_markdown.get,
          set = render_markdown.set,
        }):map("<leader>um")
      end
    end
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>cP";
      action = "<cmd>RenderMarkdown preview<cr>";
      options = {
        desc = "Markdown Render Preview (side buffer)";
      };
    }
  ];
}
