# LazyVim default completion engine is blink.cmp.
# nvim-cmp is disabled; luasnip + friendly-snippets provide snippets.
{
  plugins = {
    blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "super-tab";
        };
        appearance = {
          nerd_font_variant = "mono";
        };
        completion = {
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
          };
          ghost_text.enabled = true;
        };
        fuzzy = {
          # pure-lua matching: no rust toolchain needed from Nix
          implementation = "lua";
        };
        signature.enabled = true;
        snippets.preset = "luasnip";
        # cmdline (":") completion menu, like LazyVim
        cmdline = {
          keymap = {
            preset = "cmdline";
          };
          completion = {
            menu = {
              auto_show = true;
            };
            ghost_text = {
              enabled = true;
            };
          };
        };
        sources.default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
        ];
      };
    };
    friendly-snippets.enable = true;

    # Disabled: replaced by blink.cmp above.
    cmp.enable = false;
    cmp-nvim-lsp.enable = false;
    cmp-buffer.enable = false;
    cmp-path.enable = false;
    cmp_luasnip.enable = false;
    cmp-cmdline.enable = false;
    cmp-emoji.enable = false;
  };
}
