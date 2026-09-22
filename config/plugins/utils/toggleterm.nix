_: {
  plugins.toggleterm = {
    enable = true;
    settings = {
      size = 20;
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>ft";
      action.__raw = ''
        function()
          require("toggleterm").toggle(1, nil, Nixvim.root(), "float")
        end
      '';
      options = {
        desc = "Terminal (Root Dir)";
      };
    }
    {
      mode = "n";
      key = "<leader>fT";
      action.__raw = ''
        function()
          require("toggleterm").toggle(2, nil, vim.uv.cwd(), "float")
        end
      '';
      options = {
        desc = "Terminal (cwd)";
      };
    }
    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-/>";
      action = "<cmd>ToggleTerm<cr>";
      options = {
        desc = "Terminal (Root Dir)";
      };
    }
    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-_>";
      action = "<cmd>ToggleTerm<cr>";
      options = {
        desc = "which_key_ignore";
      };
    }
  ];
}
