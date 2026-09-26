{ pkgs, ... }:
{
  # Go toolchain on neovim's PATH (used by gopls, which can't toolchain-switch).
  # Tracks `go_latest` so the editor matches project devshells.
  dependencies.go.package = pkgs.go_latest;

  plugins = {
    # Disabled: not part of LazyVim (diagnostics render via signs/virtual text,
    # formatting via conform).
    lsp-lines.enable = false;
    lsp-format.enable = false;
    helm = {
      enable = true;
    };
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        html = {
          enable = true;
        };
        lua_ls = {
          enable = true;
        };
        nil_ls = {
          enable = true;
        };
        vtsls = {
          enable = true;
        };
        marksman = {
          enable = true;
        };
        ty = {
          enable = true;
        };
        gopls = {
          enable = true;
        };
        clangd = {
          enable = true;
        };
        terraformls = {
          enable = true;
        };
        jsonls = {
          enable = true;
        };
        helm_ls = {
          enable = true;
          extraOptions = {
            settings = {
              "helm_ls" = {
                yamlls = {
                  path = "${pkgs.yaml-language-server}/bin/yaml-language-server";
                };
              };
            };
          };
        };
        yamlls = {
          enable = true;
          extraOptions = {
            settings = {
              yaml = {
                schemas = {
                  kubernetes = "'*.yaml";
                  "http://json.schemastore.org/github-workflow" = ".github/workflows/*";
                  "http://json.schemastore.org/github-action" = ".github/action.{yml,yaml}";
                  "http://json.schemastore.org/ansible-stable-2.9" = "roles/tasks/*.{yml,yaml}";
                  "http://json.schemastore.org/kustomization" = "kustomization.{yml,yaml}";
                  "http://json.schemastore.org/ansible-playbook" = "*play*.{yml,yaml}";
                  "http://json.schemastore.org/chart" = "Chart.{yml,yaml}";
                  "https://json.schemastore.org/dependabot-v2" = ".github/dependabot.{yml,yaml}";
                  "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" =
                    "*docker-compose*.{yml,yaml}";
                  "https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json" =
                    "*flow*.{yml,yaml}";
                };
              };
            };
          };
        };
      };

      keymaps = {
        silent = true;
        extra = [
          {
            action.__raw = "function() vim.cmd.LspInfo() end";
            key = "<leader>cl";
            options.desc = "Lsp Info";
          }
          {
            action.__raw = "function() Snacks.picker.lsp_definitions() end";
            key = "gd";
            options.desc = "Goto Definition";
          }
          {
            action.__raw = "function() Snacks.picker.lsp_references() end";
            key = "gr";
            options = {
              desc = "References";
              nowait = true;
            };
          }
          {
            action.__raw = "function() Snacks.picker.lsp_implementations() end";
            key = "gI";
            options.desc = "Goto Implementation";
          }
          {
            action.__raw = "function() Snacks.picker.lsp_type_definitions() end";
            key = "gy";
            options.desc = "Goto T[y]pe Definition";
          }
          {
            action.__raw = "function() Snacks.picker.lsp_declarations() end";
            key = "gD";
            options.desc = "Goto Declaration";
          }
          {
            action.__raw = "function() Snacks.picker.lsp_incoming_calls() end";
            key = "gai";
            options.desc = "C[a]lls Incoming";
          }
          {
            action.__raw = "function() Snacks.picker.lsp_outgoing_calls() end";
            key = "gao";
            options.desc = "C[a]lls Outgoing";
          }
          {
            action.__raw = "function() vim.lsp.buf.hover() end";
            key = "K";
            options.desc = "Hover";
          }
          {
            action.__raw = "function() vim.lsp.buf.signature_help() end";
            key = "gK";
            options.desc = "Signature Help";
          }
          {
            mode = "i";
            action.__raw = "function() vim.lsp.buf.signature_help() end";
            key = "<C-k>";
            options.desc = "Signature Help";
          }
          {
            mode = [
              "n"
              "x"
            ];
            action.__raw = "vim.lsp.buf.code_action";
            key = "<leader>ca";
            options.desc = "Code Action";
          }
          {
            mode = [
              "n"
              "x"
            ];
            action.__raw = "function() vim.lsp.codelens.run() end";
            key = "<leader>cc";
            options.desc = "Run Codelens";
          }
          {
            action.__raw = "function() vim.lsp.codelens.refresh() end";
            key = "<leader>cC";
            options.desc = "Refresh & Display Codelens";
          }
          {
            action.__raw = "vim.lsp.buf.rename";
            key = "<leader>cr";
            options.desc = "Rename";
          }
          {
            action.__raw = "function() Snacks.rename.rename_file() end";
            key = "<leader>cR";
            options.desc = "Rename File";
          }
          {
            action.__raw = ''
              function()
                vim.lsp.buf.code_action({
                  context = { only = { "source" }, diagnostics = {} },
                })
              end
            '';
            key = "<leader>cA";
            options.desc = "Source Action";
          }
          {
            action.__raw = ''
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = { only = { "source.organizeImports" }, diagnostics = {} },
                })
              end
            '';
            key = "<leader>co";
            options.desc = "Organize Imports";
          }
        ];
      };
    };
  };
  extraPlugins = with pkgs.vimPlugins; [
    ansible-vim
  ];

  extraConfigLua = ''
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
      config = config or {}
      config.border = _border
      return vim.lsp.handlers.hover(err, result, ctx, config)
    end

    vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
      config = config or {}
      config.border = _border
      return vim.lsp.handlers.signature_help(err, result, ctx, config)
    end

    vim.diagnostic.config{
      float={border=_border}
    };

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }
  '';
}
