{ pkgs, ... }:
{
  plugins = {
    rustaceanvim = {
      enable = true;
      settings = {
        server = {
          default_settings = {
            rust-analyzer = {
              check = {
                command = "clippy";
              };
              cargo = {
                allFeatures = true;
                buildScripts = {
                  enable = true;
                };
              };
              procMacro = {
                enable = true;
              };
              diagnostics = {
                enable = true;
              };
            };
          };
        };
      };
    };
    crates = {
      enable = true;
    };
  };
}
