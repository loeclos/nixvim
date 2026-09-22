{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    lazygit
  ];

  plugins.snacks = {
    enable = true;
    settings = {
      bigfile.enabled = true;
      quickfile.enabled = true;
      # See https://www.lazyvim.org/plugins/ui#snacksnvim
      indent.enabled = true;
      input.enabled = true;
      notifier.enabled = true;
      scope.enabled = true;
      scroll.enabled = true;
      words.enabled = true;
      picker.enabled = true;
      explorer.enabled = true;
      # statuscolumn is set manually in settings.nix (like LazyVim options.lua)
      dashboard = {
        enabled = true;
        preset = {
          header = ''
            ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗
            ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║
            ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║
            ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║
            ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
            ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝'';
          keys = [
            {
              icon = " ";
              key = "f";
              desc = "Find File";
              action = ":lua Snacks.picker.files()";
            }
            {
              icon = " ";
              key = "n";
              desc = "New File";
              action = ":ene | startinsert";
            }
            {
              icon = " ";
              key = "g";
              desc = "Find Text";
              action = ":lua Snacks.picker.grep()";
            }
            {
              icon = " ";
              key = "r";
              desc = "Recent Files";
              action = ":lua Snacks.picker.recent()";
            }
            {
              icon = " ";
              key = "c";
              desc = "Config";
              action = ":lua Snacks.picker.files({cwd = vim.fn.stdpath('config')})";
            }
            {
              icon = " ";
              key = "s";
              desc = "Restore Session";
              section = "session";
              action = ":lua require('persistence').load()";
            }
            {
              icon = " ";
              key = "x";
              desc = "Plugin Specs";
              action = ":lua Snacks.picker.lazy()";
            }
            {
              icon = "󰒲 ";
              key = "l";
              desc = "Nix Plugins";
              action = ":lua vim.notify('Plugins are managed declaratively with Nix - see config/plugins', vim.log.levels.INFO)";
            }
            {
              icon = " ";
              key = "q";
              desc = "Quit";
              action = ":qa";
            }
          ];
        };
      };
    };
  };

  # LazyVim toggle keymaps + picker keymaps.
  # See https://www.lazyvim.org/configuration/general#keymaps
  extraConfigLua = ''
    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
    Snacks.toggle.diagnostics():map("<leader>ud")
    Snacks.toggle.line_number():map("<leader>ul")
    Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map("<leader>uc")
    Snacks.toggle.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }):map("<leader>uA")
    Snacks.toggle.treesitter():map("<leader>uT")
    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
    Snacks.toggle.dim():map("<leader>uD")
    Snacks.toggle.animate():map("<leader>ua")
    Snacks.toggle.indent():map("<leader>ug")
    Snacks.toggle.scroll():map("<leader>uS")
    Snacks.toggle.profiler():map("<leader>dpp")
    Snacks.toggle.profiler_highlights():map("<leader>dph")
    if vim.lsp.inlay_hint then
      Snacks.toggle.inlay_hints():map("<leader>uh")
    end
    Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
    Snacks.toggle.zen():map("<leader>uz")
    Snacks.toggle.new({
      id = "autoformat_global",
      name = "Auto Format (global)",
      get = function() return not vim.g.disable_autoformat end,
      set = function(state) vim.g.disable_autoformat = not state end,
    }):map("<leader>uf")
    Snacks.toggle.new({
      id = "autoformat_buffer",
      name = "Auto Format (buffer)",
      get = function() return not vim.b.disable_autoformat end,
      set = function(state) vim.b.disable_autoformat = not state end,
    }):map("<leader>uF")
  '';

  keymaps = [
    # notifier (LazyVim snacks.nvim UI keys)
    {
      mode = "n";
      key = "<leader>n";
      action.__raw = "function() Snacks.picker.notifications() end";
      options.desc = "Notification History";
    }
    {
      mode = "n";
      key = "<leader>un";
      action.__raw = "function() Snacks.notifier.hide() end";
      options.desc = "Dismiss All Notifications";
    }
    # scratch buffers
    {
      mode = "n";
      key = "<leader>.";
      action.__raw = "function() Snacks.scratch() end";
      options.desc = "Toggle Scratch Buffer";
    }
    {
      mode = "n";
      key = "<leader>S";
      action.__raw = "function() Snacks.scratch.select() end";
      options.desc = "Select Scratch Buffer";
    }
    {
      mode = "n";
      key = "<leader>dps";
      action.__raw = "function() Snacks.profiler.scratch() end";
      options.desc = "Profiler Scratch Buffer";
    }
    # run lua
    {
      mode = [
        "n"
        "x"
      ];
      key = "<localleader>r";
      action.__raw = "function() Snacks.debug.run() end";
      options.desc = "Run Lua";
    }

    # top pickers & explorer (LazyVim picker example config)
    {
      mode = "n";
      key = "<leader><space>";
      action.__raw = "function() Snacks.picker.smart() end";
      options.desc = "Smart Find Files";
    }
    {
      mode = "n";
      key = "<leader>,";
      action.__raw = "function() Snacks.picker.buffers() end";
      options.desc = "Buffers";
    }
    {
      mode = "n";
      key = "<leader>/";
      action.__raw = "function() Snacks.picker.grep() end";
      options.desc = "Grep";
    }
    {
      mode = "n";
      key = "<leader>:";
      action.__raw = "function() Snacks.picker.command_history() end";
      options.desc = "Command History";
    }
    {
      mode = "n";
      key = "<leader>e";
      action.__raw = "function() Snacks.explorer() end";
      options.desc = "File Explorer";
    }
    {
      mode = "n";
      key = "<leader>E";
      action.__raw = "function() Snacks.explorer({ cwd = vim.uv.cwd() }) end";
      options.desc = "File Explorer (cwd)";
    }
    # find
    {
      mode = "n";
      key = "<leader>fb";
      action.__raw = "function() Snacks.picker.buffers() end";
      options.desc = "Buffers";
    }
    {
      mode = "n";
      key = "<leader>fB";
      action.__raw = "function() Snacks.picker.buffers({ hidden = true, unloaded = true }) end";
      options.desc = "Buffers (all)";
    }
    {
      mode = "n";
      key = "<leader>fc";
      action.__raw = "function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end";
      options.desc = "Find Config File";
    }
    {
      mode = "n";
      key = "<leader>fe";
      action.__raw = "function() Snacks.explorer() end";
      options.desc = "Explorer Snacks (root dir)";
    }
    {
      mode = "n";
      key = "<leader>fE";
      action.__raw = "function() Snacks.explorer({ cwd = vim.uv.cwd() }) end";
      options.desc = "Explorer Snacks (cwd)";
    }
    {
      mode = "n";
      key = "<leader>ff";
      action.__raw = "function() Snacks.picker.files() end";
      options.desc = "Find Files";
    }
    {
      mode = "n";
      key = "<leader>fF";
      action.__raw = "function() Snacks.picker.files({ cwd = vim.uv.cwd() }) end";
      options.desc = "Find Files (cwd)";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action.__raw = "function() Snacks.picker.git_files() end";
      options.desc = "Find Git Files";
    }
    {
      mode = "n";
      key = "<leader>fp";
      action.__raw = "function() Snacks.picker.projects() end";
      options.desc = "Projects";
    }
    {
      mode = "n";
      key = "<leader>fr";
      action.__raw = "function() Snacks.picker.recent() end";
      options.desc = "Recent";
    }
    {
      mode = "n";
      key = "<leader>fR";
      action.__raw = "function() Snacks.picker.recent({ filter = { cwd = true } }) end";
      options.desc = "Recent (cwd)";
    }

    # git pickers
    {
      mode = "n";
      key = "<leader>gb";
      action.__raw = "function() Snacks.picker.git_log_line() end";
      options.desc = "Git Blame Line";
    }
    {
      mode = "n";
      key = "<leader>gB";
      action.__raw = "function() Snacks.gitbrowse() end";
      options = {
        desc = "Git Browse (open)";
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>gY";
      action.__raw = "function() Snacks.gitbrowse({ open = function(url) vim.fn.setreg('+', url) end, notify = false }) end";
      options = {
        desc = "Git Browse (copy)";
      };
    }
    {
      mode = "n";
      key = "<leader>gd";
      action.__raw = "function() Snacks.picker.git_diff() end";
      options.desc = "Git Diff (Hunks)";
    }
    {
      mode = "n";
      key = "<leader>gs";
      action.__raw = "function() Snacks.picker.git_status() end";
      options.desc = "Git Status";
    }
    {
      mode = "n";
      key = "<leader>gS";
      action.__raw = "function() Snacks.picker.git_stash() end";
      options.desc = "Git Stash";
    }
    {
      mode = "n";
      key = "<leader>gf";
      action.__raw = "function() Snacks.picker.git_log_file() end";
      options.desc = "Git Current File History";
    }
    {
      mode = "n";
      key = "<leader>gl";
      action.__raw = "function() Snacks.picker.git_log({ cwd = Nixvim.root() }) end";
      options.desc = "Git Log";
    }
    {
      mode = "n";
      key = "<leader>gL";
      action.__raw = "function() Snacks.picker.git_log() end";
      options.desc = "Git Log (cwd)";
    }
    {
      mode = "n";
      key = "<leader>gi";
      action.__raw = "function() Snacks.picker.gh_issue() end";
      options.desc = "GitHub Issues (open)";
    }
    {
      mode = "n";
      key = "<leader>gI";
      action.__raw = "function() Snacks.picker.gh_issue({ state = 'all' }) end";
      options.desc = "GitHub Issues (all)";
    }
    {
      mode = "n";
      key = "<leader>gp";
      action.__raw = "function() Snacks.picker.gh_pr() end";
      options.desc = "GitHub Pull Requests (open)";
    }
    {
      mode = "n";
      key = "<leader>gP";
      action.__raw = "function() Snacks.picker.gh_pr({ state = 'all' }) end";
      options.desc = "GitHub Pull Requests (all)";
    }

    # grep
    {
      mode = "n";
      key = "<leader>sb";
      action.__raw = "function() Snacks.picker.lines() end";
      options.desc = "Buffer Lines";
    }
    {
      mode = "n";
      key = "<leader>sB";
      action.__raw = "function() Snacks.picker.grep_buffers() end";
      options.desc = "Grep Open Buffers";
    }
    {
      mode = "n";
      key = "<leader>sg";
      action.__raw = "function() Snacks.picker.grep() end";
      options.desc = "Grep";
    }
    {
      mode = "n";
      key = "<leader>sG";
      action.__raw = "function() Snacks.picker.grep({ cwd = vim.uv.cwd() }) end";
      options.desc = "Grep (cwd)";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>sw";
      action.__raw = "function() Snacks.picker.grep_word() end";
      options.desc = "Visual selection or word";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>sW";
      action.__raw = "function() Snacks.picker.grep_word({ cwd = vim.uv.cwd() }) end";
      options.desc = "Visual selection or word (cwd)";
    }

    # search
    {
      mode = "n";
      key = "<leader>s\"";
      action.__raw = "function() Snacks.picker.registers() end";
      options.desc = "Registers";
    }
    {
      mode = "n";
      key = "<leader>s/";
      action.__raw = "function() Snacks.picker.search_history() end";
      options.desc = "Search History";
    }
    {
      mode = "n";
      key = "<leader>sa";
      action.__raw = "function() Snacks.picker.autocmds() end";
      options.desc = "Autocmds";
    }
    {
      mode = "n";
      key = "<leader>sc";
      action.__raw = "function() Snacks.picker.command_history() end";
      options.desc = "Command History";
    }
    {
      mode = "n";
      key = "<leader>sC";
      action.__raw = "function() Snacks.picker.commands() end";
      options.desc = "Commands";
    }
    {
      mode = "n";
      key = "<leader>sd";
      action.__raw = "function() Snacks.picker.diagnostics() end";
      options.desc = "Diagnostics";
    }
    {
      mode = "n";
      key = "<leader>sD";
      action.__raw = "function() Snacks.picker.diagnostics_buffer() end";
      options.desc = "Buffer Diagnostics";
    }
    {
      mode = "n";
      key = "<leader>sh";
      action.__raw = "function() Snacks.picker.help() end";
      options.desc = "Help Pages";
    }
    {
      mode = "n";
      key = "<leader>sH";
      action.__raw = "function() Snacks.picker.highlights() end";
      options.desc = "Highlights";
    }
    {
      mode = "n";
      key = "<leader>si";
      action.__raw = "function() Snacks.picker.icons() end";
      options.desc = "Icons";
    }
    {
      mode = "n";
      key = "<leader>sj";
      action.__raw = "function() Snacks.picker.jumps() end";
      options.desc = "Jumps";
    }
    {
      mode = "n";
      key = "<leader>sk";
      action.__raw = "function() Snacks.picker.keymaps() end";
      options.desc = "Keymaps";
    }
    {
      mode = "n";
      key = "<leader>sl";
      action.__raw = "function() Snacks.picker.loclist() end";
      options.desc = "Location List";
    }
    {
      mode = "n";
      key = "<leader>sm";
      action.__raw = "function() Snacks.picker.marks() end";
      options.desc = "Marks";
    }
    {
      mode = "n";
      key = "<leader>sM";
      action.__raw = "function() Snacks.picker.man() end";
      options.desc = "Man Pages";
    }
    {
      mode = "n";
      key = "<leader>sp";
      action.__raw = "function() Snacks.picker.lazy() end";
      options.desc = "Search for Plugin Spec";
    }
    {
      mode = "n";
      key = "<leader>so";
      action = "<cmd>Telescope vim_options<cr>";
      options.desc = "Options";
    }
    {
      mode = "n";
      key = "<leader>sq";
      action.__raw = "function() Snacks.picker.qflist() end";
      options.desc = "Quickfix List";
    }
    {
      mode = "n";
      key = "<leader>sR";
      action.__raw = "function() Snacks.picker.resume() end";
      options.desc = "Resume";
    }
    {
      mode = "n";
      key = "<leader>su";
      action.__raw = "function() Snacks.picker.undo() end";
      options.desc = "Undo History";
    }
    {
      mode = "n";
      key = "<leader>uC";
      action.__raw = "function() Snacks.picker.colorschemes() end";
      options.desc = "Colorschemes";
    }

    # word references (LazyVim uses snacks.words; ]]/[[ are provided by it)
    {
      mode = "n";
      key = "<a-n>";
      action.__raw = "function() Snacks.words.jump(1) end";
      options.desc = "Next Reference";
    }
    {
      mode = "n";
      key = "<a-p>";
      action.__raw = "function() Snacks.words.jump(-1) end";
      options.desc = "Prev Reference";
    }

    # LSP pickers (LazyVim picker example config)
    {
      mode = "n";
      key = "<leader>ss";
      action.__raw = "function() Snacks.picker.lsp_symbols() end";
      options.desc = "LSP Symbols";
    }
    {
      mode = "n";
      key = "<leader>sS";
      action.__raw = "function() Snacks.picker.lsp_workspace_symbols() end";
      options.desc = "LSP Workspace Symbols";
    }
  ];
}
