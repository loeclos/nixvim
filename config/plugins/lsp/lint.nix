# LazyVim linting core via nvim-lint.
# See https://www.lazyvim.org/plugins/linting
# (LazyVim installs these through mason; here Nix provides the binaries.)
{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    ruff
    markdownlint-cli2
    hadolint
    yamllint
    shellcheck
  ];

  plugins.lint = {
    enable = true;
    lintersByFt = {
      dockerfile = [ "hadolint" ];
      markdown = [ "markdownlint-cli2" ];
      python = [ "ruff" ];
      sh = [ "shellcheck" ];
      yaml = [ "yamllint" ];
    };
  };

  autoGroups = {
    lazyvim_lint = {
      clear = true;
    };
  };

  autoCmd = [
    {
      group = "lazyvim_lint";
      event = [
        "BufEnter"
        "BufWritePost"
        "InsertLeave"
      ];
      pattern = "*";
      callback = {
        __raw = ''
          function()
            require("lint").try_lint()
          end
        '';
      };
    }
  ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>cL";
      action.__raw = ''
        function()
          require("lint").try_lint()
        end
      '';
      options.desc = "Lint File";
    }
  ];
}
