# LazyVim lualine spec. See https://www.lazyvim.org/plugins/ui#lualinenvim
_: {
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        theme = "auto";
        globalstatus = true;
        disabledFiletypes = {
          statusline = [
            "dashboard"
            "alpha"
            "ministarter"
            "snacks_dashboard"
          ];
        };
      };
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [
          {
            __unkeyed-1 = "diagnostics";
            symbols = {
              error = " ";
              warn = " ";
              info = " ";
              hint = " ";
            };
          }
          {
            __unkeyed-1 = "filetype";
            icon_only = true;
            separator = "";
            padding = {
              left = 1;
              right = 0;
            };
          }
          {
            __unkeyed-1 = "filename";
            path = 1;
          }
        ];
        lualine_x = [
          {
            __unkeyed-1.__raw = ''
              function() return require("noice").api.status.command.get() end
            '';
            cond.__raw = ''
              function() return package.loaded["noice"] and require("noice").api.status.command.has() end
            '';
            color.__raw = ''
              function() return { fg = Snacks.util.color("Statement") } end
            '';
          }
          {
            __unkeyed-1.__raw = ''
              function() return require("noice").api.status.mode.get() end
            '';
            cond.__raw = ''
              function() return package.loaded["noice"] and require("noice").api.status.mode.has() end
            '';
            color.__raw = ''
              function() return { fg = Snacks.util.color("Constant") } end
            '';
          }
          {
            __unkeyed-1 = "diff";
            symbols = {
              added = " ";
              modified = " ";
              removed = " ";
            };
            source.__raw = ''
              function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end
            '';
          }
        ];
        lualine_y = [
          {
            __unkeyed-1 = "progress";
            separator = " ";
            padding = {
              left = 1;
              right = 0;
            };
          }
          {
            __unkeyed-1 = "location";
            padding = {
              left = 0;
              right = 1;
            };
          }
        ];
        lualine_z = [
          {
            __unkeyed-1.__raw = ''
              function()
                return " " .. os.date("%R")
              end
            '';
          }
        ];
      };
      extensions = [
        "neo-tree"
        "lazy"
        "fzf"
      ];
    };
  };
}
