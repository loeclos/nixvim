{
  plugins.which-key = {
    enable = true;
    settings = {
      # side column popup with border (instead of the wide bottom bar)
      preset = "helix";
      win = {
        border = "rounded";
      };
      spec = [
        {
          __unkeyed-1 = "<leader><tab>";
          group = "tabs";
        }
        {
          __unkeyed-1 = "<leader>b";
          group = "buffer";
        }
        {
          __unkeyed-1 = "<leader>c";
          group = "code";
        }
        {
          __unkeyed-1 = "<leader>d";
          group = "debug";
        }
        {
          __unkeyed-1 = "<leader>f";
          group = "file/find";
        }
        {
          __unkeyed-1 = "<leader>g";
          group = "git";
        }
        {
          __unkeyed-1 = "<leader>gh";
          group = "hunks";
        }
        {
          __unkeyed-1 = "<leader>q";
          group = "quit/session";
        }
        {
          __unkeyed-1 = "<leader>s";
          group = "search";
        }
        {
          __unkeyed-1 = "<leader>sn";
          group = "noice";
        }
        {
          __unkeyed-1 = "<leader>u";
          group = "ui";
        }
        {
          __unkeyed-1 = "<leader>w";
          group = "windows";
        }
        {
          __unkeyed-1 = "<leader>x";
          group = "diagnostics/quickfix";
        }
        {
          __unkeyed-1 = "[";
          group = "prev";
        }
        {
          __unkeyed-1 = "]";
          group = "next";
        }
        {
          __unkeyed-1 = "g";
          group = "goto";
        }
        {
          __unkeyed-1 = "gs";
          group = "surround";
        }
        {
          __unkeyed-1 = "z";
          group = "fold";
        }
      ];
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>?";
      action.__raw = ''
        function()
          require("which-key").show({ global = false })
        end
      '';
      options = {
        desc = "Buffer Keymaps (which-key)";
      };
    }
    {
      mode = "n";
      key = "<C-w><space>";
      action.__raw = ''
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end
      '';
      options = {
        desc = "Window Hydra Mode (which-key)";
      };
    }
  ];
}
