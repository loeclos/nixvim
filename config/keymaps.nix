{
  globals = {
    mapleader = " ";
    maplocalleader = "\\";
  };

  extraConfigLuaPre =
    # lua
    ''
      _G.Nixvim = _G.Nixvim or {}

      function Nixvim.root()
        -- LazyVim root_spec = { "lsp", { ".git", "lua" }, "cwd" }
        local buf = vim.api.nvim_get_current_buf()
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
          if client.name ~= "copilot" and client.config and client.config.root_dir then
            return client.config.root_dir
          end
        end
        local path = vim.api.nvim_buf_get_name(0)
        if path == "" then
          return vim.uv.cwd()
        end
        local found = vim.fs.find({ ".git", "lua" }, { path = vim.fs.dirname(path), upward = true })[1]
        if found then
          -- found is either <root>/.git or <root>/lua, both live directly under root
          return vim.fn.fnamemodify(found, ":h")
        end
        return vim.uv.cwd()
      end

      function Nixvim.diagnostic_goto(next, severity)
        return function()
          local opts = {
            count = (next and 1 or -1) * vim.v.count1,
            severity = severity and vim.diagnostic.severity[severity] or nil,
            float = true,
          }
          if vim.diagnostic.jump then
            vim.diagnostic.jump(opts)
          else
            vim.diagnostic[next and "goto_next" or "goto_prev"]({ severity = opts.severity })
          end
        end
      end

    '';

  keymaps = [
    # better up/down
    {
      mode = [
        "n"
        "x"
      ];
      key = "j";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        expr = true;
        silent = true;
        desc = "Down";
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<Down>";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        expr = true;
        silent = true;
        desc = "Down";
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "k";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        expr = true;
        silent = true;
        desc = "Up";
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<Up>";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        expr = true;
        silent = true;
        desc = "Up";
      };
    }

    # Move to window using the <ctrl> hjkl keys
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options = {
        desc = "Go to Left Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options = {
        desc = "Go to Lower Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options = {
        desc = "Go to Upper Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options = {
        desc = "Go to Right Window";
        remap = true;
      };
    }

    # Resize window using <ctrl> arrow keys
    {
      mode = "n";
      key = "<C-Up>";
      action = "<cmd>resize +2<cr>";
      options = {
        desc = "Increase Window Height";
      };
    }
    {
      mode = "n";
      key = "<C-Down>";
      action = "<cmd>resize -2<cr>";
      options = {
        desc = "Decrease Window Height";
      };
    }
    {
      mode = "n";
      key = "<C-Left>";
      action = "<cmd>vertical resize -2<cr>";
      options = {
        desc = "Decrease Window Width";
      };
    }
    {
      mode = "n";
      key = "<C-Right>";
      action = "<cmd>vertical resize +2<cr>";
      options = {
        desc = "Increase Window Width";
      };
    }

    # Move Lines
    {
      mode = "n";
      key = "<A-j>";
      action = "<cmd>execute 'move .+' . v:count1<cr>==";
      options = {
        desc = "Move Down";
      };
    }
    {
      mode = "n";
      key = "<A-k>";
      action = "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==";
      options = {
        desc = "Move Up";
      };
    }
    {
      mode = "i";
      key = "<A-j>";
      action = "<esc><cmd>m .+1<cr>==gi";
      options = {
        desc = "Move Down";
      };
    }
    {
      mode = "i";
      key = "<A-k>";
      action = "<esc><cmd>m .-2<cr>==gi";
      options = {
        desc = "Move Up";
      };
    }
    {
      mode = "v";
      key = "<A-j>";
      action = '':<C-u>execute "'<,'>move '>+" . v:count1<cr>gv=gv'';
      options = {
        desc = "Move Down";
      };
    }
    {
      mode = "v";
      key = "<A-k>";
      action = '':<C-u>execute "'<,'>move '<-" . (v:count1 + 1)<cr>gv=gv'';
      options = {
        desc = "Move Up";
      };
    }

    # buffers
    {
      mode = "n";
      key = "<leader>bb";
      action = "<cmd>e #<cr>";
      options = {
        desc = "Switch to Other Buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>`";
      action = "<cmd>e #<cr>";
      options = {
        desc = "Switch to Other Buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>bd";
      action.__raw = "function() require('mini.bufremove').delete(0, false) end";
      options = {
        desc = "Delete Buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>bo";
      action.__raw = ''
        function()
          local current = vim.api.nvim_get_current_buf()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if buf ~= current and vim.bo[buf].buflisted then
              require("mini.bufremove").delete(buf, false)
            end
          end
        end
      '';
      options = {
        desc = "Delete Other Buffers";
      };
    }
    {
      mode = "n";
      key = "<leader>bi";
      action.__raw = ''
        function()
          local visible = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            visible[vim.api.nvim_win_get_buf(win)] = true
          end
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[buf].buflisted and not visible[buf] then
              require("mini.bufremove").delete(buf, false)
            end
          end
        end
      '';
      options = {
        desc = "Delete Invisible Buffers";
      };
    }
    {
      mode = "n";
      key = "<leader>bD";
      action = "<cmd>:bd<cr>";
      options = {
        desc = "Delete Buffer and Window";
      };
    }

    {
      mode = [
        "i"
      ];
      key = "jj";
      action = "stopinsert";
      options = {
        desc = "Escape";
      };
    }

    # Clear search and stop snippet on escape
    {
      mode = [
        "i"
        "n"
        "s"
      ];
      key = "<esc>";
      action.__raw = ''
        function()
          vim.cmd("noh")
          local ok, luasnip = pcall(require, "luasnip")
          if ok and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] then
            luasnip.unlink_current()
          end
          return "<esc>"
        end
      '';
      options = {
        expr = true;
        desc = "Escape and Clear hlsearch";
      };
    }
    {
      mode = "n";
      key = "<leader>ur";
      action = "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>";
      options = {
        desc = "Redraw / Clear hlsearch / Diff Update";
      };
    }

    # https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
    {
      mode = "n";
      key = "n";
      action = "'Nn'[v:searchforward].'zv'";
      options = {
        expr = true;
        desc = "Next Search Result";
      };
    }
    {
      mode = "x";
      key = "n";
      action = "'Nn'[v:searchforward]";
      options = {
        expr = true;
        desc = "Next Search Result";
      };
    }
    {
      mode = "o";
      key = "n";
      action = "'Nn'[v:searchforward]";
      options = {
        expr = true;
        desc = "Next Search Result";
      };
    }
    {
      mode = "n";
      key = "N";
      action = "'nN'[v:searchforward].'zv'";
      options = {
        expr = true;
        desc = "Prev Search Result";
      };
    }
    {
      mode = "x";
      key = "N";
      action = "'nN'[v:searchforward]";
      options = {
        expr = true;
        desc = "Prev Search Result";
      };
    }
    {
      mode = "o";
      key = "N";
      action = "'nN'[v:searchforward]";
      options = {
        expr = true;
        desc = "Prev Search Result";
      };
    }

    # Add undo break-points
    {
      mode = "i";
      key = ",";
      action = ",<c-g>u";
    }
    {
      mode = "i";
      key = ".";
      action = ".<c-g>u";
    }
    {
      mode = "i";
      key = ";";
      action = ";<c-g>u";
    }

    # save file
    {
      mode = [
        "i"
        "x"
        "n"
        "s"
      ];
      key = "<C-s>";
      action = "<cmd>w<cr><esc>";
      options = {
        desc = "Save File";
      };
    }

    # keywordprg
    {
      mode = "n";
      key = "<leader>K";
      action = "<cmd>norm! K<cr>";
      options = {
        desc = "Keywordprg";
      };
    }

    # better indenting
    {
      mode = "x";
      key = "<";
      action = "<gv";
    }
    {
      mode = "x";
      key = ">";
      action = ">gv";
    }

    # commenting
    {
      mode = "n";
      key = "gco";
      action = "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      options = {
        desc = "Add Comment Below";
      };
    }
    {
      mode = "n";
      key = "gcO";
      action = "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      options = {
        desc = "Add Comment Above";
      };
    }

    # new file
    {
      mode = "n";
      key = "<leader>fn";
      action = "<cmd>enew<cr>";
      options = {
        desc = "New File";
      };
    }

    # location list
    {
      mode = "n";
      key = "<leader>xl";
      action.__raw = ''
        function()
          local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
          if not success and err then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      '';
      options = {
        desc = "Location List";
      };
    }

    # quickfix list
    {
      mode = "n";
      key = "<leader>xq";
      action.__raw = ''
        function()
          local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
          if not success and err then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      '';
      options = {
        desc = "Quickfix List";
      };
    }
    # NOTE: [q/]q are trouble-aware and live in plugins/editor/trouble.nix.

    # formatting
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>cf";
      action.__raw = ''
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end
      '';
      options = {
        desc = "Format";
      };
    }

    # diagnostic
    {
      mode = "n";
      key = "<leader>cd";
      action.__raw = "vim.diagnostic.open_float";
      options = {
        desc = "Line Diagnostics";
      };
    }
    {
      mode = "n";
      key = "]d";
      action.__raw = "Nixvim.diagnostic_goto(true)";
      options = {
        desc = "Next Diagnostic";
      };
    }
    {
      mode = "n";
      key = "[d";
      action.__raw = "Nixvim.diagnostic_goto(false)";
      options = {
        desc = "Prev Diagnostic";
      };
    }
    {
      mode = "n";
      key = "]e";
      action.__raw = ''Nixvim.diagnostic_goto(true, "ERROR")'';
      options = {
        desc = "Next Error";
      };
    }
    {
      mode = "n";
      key = "[e";
      action.__raw = ''Nixvim.diagnostic_goto(false, "ERROR")'';
      options = {
        desc = "Prev Error";
      };
    }
    {
      mode = "n";
      key = "]w";
      action.__raw = ''Nixvim.diagnostic_goto(true, "WARN")'';
      options = {
        desc = "Next Warning";
      };
    }
    {
      mode = "n";
      key = "[w";
      action.__raw = ''Nixvim.diagnostic_goto(false, "WARN")'';
      options = {
        desc = "Prev Warning";
      };
    }

    # quit
    {
      mode = "n";
      key = "<leader>qq";
      action = "<cmd>qa<cr>";
      options = {
        desc = "Quit All";
      };
    }

    # highlights under cursor
    {
      mode = "n";
      key = "<leader>ui";
      action.__raw = "vim.show_pos";
      options = {
        desc = "Inspect Pos";
      };
    }
    {
      mode = "n";
      key = "<leader>uI";
      action.__raw = ''
        function()
          vim.treesitter.inspect_tree()
          vim.api.nvim_input("I")
        end
      '';
      options = {
        desc = "Inspect Tree";
      };
    }

    # windows
    {
      mode = "n";
      key = "<leader>-";
      action = "<C-W>s";
      options = {
        desc = "Split Window Below";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<leader>|";
      action = "<C-W>v";
      options = {
        desc = "Split Window Right";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<leader>wd";
      action = "<C-W>c";
      options = {
        desc = "Delete Window";
        remap = true;
      };
    }

    # tabs
    {
      mode = "n";
      key = "<leader><tab>l";
      action = "<cmd>tablast<cr>";
      options = {
        desc = "Last Tab";
      };
    }
    {
      mode = "n";
      key = "<leader><tab>o";
      action = "<cmd>tabonly<cr>";
      options = {
        desc = "Close Other Tabs";
      };
    }
    {
      mode = "n";
      key = "<leader><tab>f";
      action = "<cmd>tabfirst<cr>";
      options = {
        desc = "First Tab";
      };
    }
    {
      mode = "n";
      key = "<leader><tab><tab>";
      action = "<cmd>tabnew<cr>";
      options = {
        desc = "New Tab";
      };
    }
    {
      mode = "n";
      key = "<leader><tab>]";
      action = "<cmd>tabnext<cr>";
      options = {
        desc = "Next Tab";
      };
    }
    {
      mode = "n";
      key = "<leader><tab>d";
      action = "<cmd>tabclose<cr>";
      options = {
        desc = "Close Tab";
      };
    }
    {
      mode = "n";
      key = "<leader><tab>[";
      action = "<cmd>tabprevious<cr>";
      options = {
        desc = "Previous Tab";
      };
    }
  ];
}
