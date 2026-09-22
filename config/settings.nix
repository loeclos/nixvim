{ pkgs, ... }:
{
  config = {
    extraConfigLuaPre =
      # lua
      ''
        -- LazyVim icons (see https://www.lazyvim.org/configuration)
        vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
        vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
        vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint", linehl = "", numhl = "" })
        vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
      '';

    extraConfigLuaPost =
      # lua
      ''
        vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
      '';

    clipboard = {
      providers.wl-copy.enable = pkgs.stdenv.isLinux;
    };

    globals = {
      autoformat = true;
      snacks_animate = true;
      lazyvim_picker = "auto";
      lazyvim_cmp = "auto";
      ai_cmp = true;
      root_spec = [
        "lsp"
        [
          ".git"
          "lua"
        ]
        "cwd"
      ];
      root_lsp_ignore = [ "copilot" ];
      deprecation_warnings = false;
      trouble_lualine = true;
      markdown_recommended_style = 0;
    };

    opts = {
      autowrite = true;
      clipboard = "unnamedplus";
      completeopt = [
        "menu"
        "menuone"
        "noselect"
      ];
      conceallevel = 2;
      confirm = true;
      cursorline = true;
      expandtab = true;
      fillchars = {
        foldopen = "";
        foldclose = "";
        fold = " ";
        foldsep = " ";
        diff = "╱";
        eob = " ";
      };
      foldlevel = 99;
      foldmethod = "indent";
      foldtext = "";
      formatoptions = "jcroqlnt";
      grepformat = "%f:%l:%c:%m";
      grepprg = "rg --vimgrep";
      ignorecase = true;
      inccommand = "nosplit";
      jumpoptions = "view";
      laststatus = 3;
      linebreak = true;
      list = true;
      mouse = "a";
      number = true;
      pumblend = 10;
      pumheight = 10;
      relativenumber = true;
      ruler = false;
      scrolloff = 4;
      sessionoptions = [
        "buffers"
        "curdir"
        "tabpages"
        "winsize"
        "help"
        "globals"
        "skiprtp"
        "folds"
      ];
      shiftround = true;
      shiftwidth = 2;
      showmode = false;
      sidescrolloff = 8;
      signcolumn = "yes";
      smartcase = true;
      smartindent = true;
      smoothscroll = true;
      spelllang = [ "en" ];
      splitbelow = true;
      splitkeep = "screen";
      splitright = true;
      statuscolumn = "%!v:lua.require'snacks'.statuscolumn()";
      tabstop = 2;
      softtabstop = 2;
      termguicolors = true;
      timeoutlen = 300;
      undofile = true;
      undolevels = 10000;
      updatetime = 200;
      virtualedit = "block";
      wildmode = "longest:full,full";
      winminwidth = 5;
      wrap = false;
    };
  };
}
