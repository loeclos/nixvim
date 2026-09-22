# LazyVim mini spec. See https://www.lazyvim.org/plugins/coding
# NOTE: indent guides/scopes come from snacks (indent/scope), not mini.indentscope.
{
  plugins.mini = {
    enable = true;

    modules = {
      bufremove = { };
      pairs = {
        modes = {
          insert = true;
          command = true;
          terminal = false;
        };
        skip_next = ''[%w%%%'%[%"%.%`%$]]'';
        skip_ts = [ "string" ];
        skip_unbalanced = true;
        markdown = true;
      };
      icons = {
        file = {
          ".keep" = {
            glyph = "󰊢";
            hl = "MiniIconsGrey";
          };
          "devcontainer.json" = {
            glyph = "";
            hl = "MiniIconsAzure";
          };
        };
        filetype = {
          dotenv = {
            glyph = "";
            hl = "MiniIconsYellow";
          };
        };
      };
      surround = {
        mappings = {
          add = "gsa";
          delete = "gsd";
          find = "gsf";
          find_left = "gsF";
          highlight = "gsh";
          replace = "gsr";
          update_n_lines = "gsn";
        };
      };
      ai = {
        n_lines = 500;
      };
    };
  };

  # Full LazyVim mini.ai textobjects (needs lua functions, so it lives here).
  # Runs after the plugin setup above and reconfigures mini.ai with the same opts.
  extraConfigLua = ''
    do
      local ok, ai = pcall(require, "mini.ai")
      if ok then
        ai.setup({
          n_lines = 500,
          custom_textobjects = {
            o = ai.gen_spec.treesitter({
              a = { "@block.outer", "@conditional.outer", "@loop.outer" },
              i = { "@block.inner", "@conditional.inner", "@loop.inner" },
            }),
            f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
            c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
            t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
            d = { "%f[%d]%d+" },
            e = {
              { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
              "^().*()$",
            },
            u = ai.gen_spec.function_call(),
            U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),
          },
        })
      end
    end
    -- LazyVim mini.icons mocks nvim-web-devicons
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  '';
}
