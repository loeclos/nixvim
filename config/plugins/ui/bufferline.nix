{
  plugins = {
    bufferline = {
      enable = true;
      settings = {
        options = {
          # stylua: ignore
          close_command.__raw = "function(n) Snacks.bufdelete(n) end";
          # stylua: ignore
          right_mouse_command.__raw = "function(n) Snacks.bufdelete(n) end";
          diagnostics = "nvim_lsp";
          always_show_bufferline = false;
          diagnostics_indicator.__raw = ''
            function(_, _, diag)
              local icons = { Error = " ", Warn = " " }
              local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                .. (diag.warning and icons.Warn .. diag.warning or "")
              return vim.trim(ret)
            end
          '';
          mode = "buffers";

          close_icon = " ";
          buffer_close_icon = "󰱝 ";
          modified_icon = "󰔯 ";

          offsets = [
            {
              filetype = "neo-tree";
              text = "Neo-tree";
              highlight = "Directory";
              text_align = "left";
            }
            {
              filetype = "snacks_layout_box";
            }
          ];
        };

        # Fix bufferline when restoring a session (LazyVim)
        extraConfigLua = ''
          vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
            callback = function()
              vim.schedule(function()
                pcall(nvim_bufferline)
              end)
            end,
          })
        '';

      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<S-h>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options = {
        desc = "Prev Buffer";
      };
    }
    {
      mode = "n";
      key = "<S-l>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options = {
        desc = "Next Buffer";
      };
    }
    {
      mode = "n";
      key = "[b";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options = {
        desc = "Prev Buffer";
      };
    }
    {
      mode = "n";
      key = "]b";
      action = "<cmd>BufferLineCycleNext<cr>";
      options = {
        desc = "Next Buffer";
      };
    }
    {
      mode = "n";
      key = "[B";
      action = "<cmd>BufferLineMovePrev<cr>";
      options = {
        desc = "Move buffer prev";
      };
    }
    {
      mode = "n";
      key = "]B";
      action = "<cmd>BufferLineMoveNext<cr>";
      options = {
        desc = "Move buffer next";
      };
    }
    {
      mode = "n";
      key = "<leader>bj";
      action = "<cmd>BufferLinePick<cr>";
      options = {
        desc = "Pick Buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>BufferLineTogglePin<cr>";
      options = {
        desc = "Toggle Pin";
      };
    }
    {
      mode = "n";
      key = "<leader>bP";
      action = "<Cmd>BufferLineGroupClose ungrouped<CR>";
      options = {
        desc = "Delete Non-Pinned Buffers";
      };
    }
    {
      mode = "n";
      key = "<leader>br";
      action = "<cmd>BufferLineCloseRight<cr>";
      options = {
        desc = "Delete Buffers to the Right";
      };
    }
    {
      mode = "n";
      key = "<leader>bl";
      action = "<cmd>BufferLineCloseLeft<cr>";
      options = {
        desc = "Delete Buffers to the Left";
      };
    }
  ];
}
