_: {
  plugins.todo-comments = {
    enable = true;
    settings = {
      colors = {
        error = [
          "DiagnosticError"
          "ErrorMsg"
          "#ED8796"
        ];
        warning = [
          "DiagnosticWarn"
          "WarningMsg"
          "#EED49F"
        ];
        info = [
          "DiagnosticInfo"
          "#EED49F"
        ];
        default = [
          "Identifier"
          "#F5A97F"
        ];
        test = [
          "Identifier"
          "#8AADF4"
        ];
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "]t";
      action.__raw = ''function() require("todo-comments").jump_next() end'';
      options = {
        desc = "Next Todo Comment";
      };
    }
    {
      mode = "n";
      key = "[t";
      action.__raw = ''function() require("todo-comments").jump_prev() end'';
      options = {
        desc = "Previous Todo Comment";
      };
    }
    {
      mode = "n";
      key = "<leader>st";
      action.__raw = "function() require('todo-comments.snacks').pick() end";
      options = {
        desc = "Todo";
      };
    }
    {
      mode = "n";
      key = "<leader>sT";
      action.__raw = "function() require('todo-comments.snacks').pick({ keywords = { 'TODO', 'FIX', 'FIXME' } }) end";
      options = {
        desc = "Todo/Fix/Fixme";
      };
    }
    {
      mode = "n";
      key = "<leader>xt";
      action = "<cmd>Trouble todo toggle<cr>";
      options = {
        desc = "Todo (Trouble)";
      };
    }
    {
      mode = "n";
      key = "<leader>xT";
      action = "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>";
      options = {
        desc = "Todo/Fix/Fixme (Trouble)";
      };
    }
  ];
}
