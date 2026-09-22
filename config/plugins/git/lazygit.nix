# LazyVim drives lazygit through Snacks (see https://www.lazyvim.org/keymaps#general).
{
  keymaps = [
    {
      mode = "n";
      key = "<leader>gg";
      action.__raw = ''
        function()
          Snacks.lazygit({ cwd = Nixvim.root() })
        end
      '';
      options = {
        desc = "Lazygit (Root Dir)";
      };
    }
    {
      mode = "n";
      key = "<leader>gG";
      action.__raw = ''
        function()
          Snacks.lazygit()
        end
      '';
      options = {
        desc = "Lazygit (cwd)";
      };
    }
  ];
}
