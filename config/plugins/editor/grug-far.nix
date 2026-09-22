# LazyVim search & replace via grug-far.
{
  plugins.grug-far = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>sr";
      action.__raw = ''
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = { filesFilter = ext and ext ~= "" and "*." .. ext or nil },
          })
        end
      '';
      options.desc = "Search and Replace";
    }
    {
      mode = "x";
      key = "<leader>sr";
      action = "<cmd>lua require('grug-far').with_visual_selection()<cr>";
      options.desc = "Search and Replace";
    }
  ];
}
