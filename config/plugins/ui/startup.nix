{
  plugins.alpha = {
    enable = true;

    layout = [
      {
        type = "padding";
        val = 2;
      }
      {
        opts = {
          hl = "Type";
          position = "center";
        };
        type = "text";
        val = [
          "                                                                       "
          "                                                                     "
          "       ████ ██████           █████      ██                     "
          "      ███████████             █████                             "
          "      █████████ ███████████████████ ███   ███████████   "
          "     █████████  ███    █████████████ █████ ██████████████   "
          "    █████████ ██████████ █████████ █████ █████ ████ █████   "
          "  ███████████ ███    ███ █████████ █████ █████ ████ █████  "
          " ██████  █████████████████████ ████ █████ █████ ████ ██████ "
          "                                                                       "
        ];
      }
      {
        type = "padding";
        val = 2;
      }
      {
        type = "padding";
        val = 2;
      }
      {
        opts = {
          hl = "Keyword";
          position = "center";
        };
        type = "text";
        val = "Inspiring quote here.";
      }
    ];
  };
  # plugins.startup = {
  #   enable = true;
  #   settings = {
  #     colors = {
  #       background = "#ffffff";
  #       folded_section = "#ffffff";
  #     };
  #
  #     header = {
  #       type = "text";
  #       oldfiles_directory = false;
  #       align = "center";
  #       fold_section = false;
  #       title = "Header";
  #       margin = 5;
  #       content = [
  #           "                                                                       "
  #           "                                                                     "
  #           "       ████ ██████           █████      ██                     "
  #           "      ███████████             █████                             "
  #           "      █████████ ███████████████████ ███   ███████████   "
  #           "     █████████  ███    █████████████ █████ ██████████████   "
  #           "    █████████ ██████████ █████████ █████ █████ ████ █████   "
  #           "  ███████████ ███    ███ █████████ █████ █████ ████ █████  "
  #           " ██████  █████████████████████ ████ █████ █████ ████ ██████ "
  #           "                                                                       "
  #       ];
  #       highlight = "Statement";
  #       default_color = "";
  #       oldfiles_amount = 0;
  #     };
  #
  #     body = {
  #       type = "mapping";
  #       oldfiles_directory = false;
  #       align = "center";
  #       fold_section = false;
  #       title = "Menu";
  #       margin = 5;
  #       content = [
  #         [
  #           " Find File"
  #           "Telescope find_files"
  #           "ff"
  #         ]
  #         [
  #           "󰍉 Find Word"
  #           "Telescope live_grep"
  #           "fr"
  #         ]
  #         [
  #           " Recent Files"
  #           "Telescope oldfiles"
  #           "fg"
  #         ]
  #         [
  #           " File Browser"
  #           "Telescope file_browser"
  #           "fe"
  #         ]
  #         [
  #           " Copilot Chat"
  #           "CopilotChat"
  #           "ct"
  #         ]
  #         [
  #           "󰧑 SecondBrain"
  #           "edit ~/projects/personal/SecondBrain"
  #           "sb"
  #         ]
  #       ];
  #       highlight = "string";
  #       default_color = "";
  #       oldfiles_amount = 0;
  #     };
  #
  #     options = {
  #       paddings = [
  #         1
  #         3
  #       ];
  #     };
  #
  #     parts = [
  #       "header"
  #       "body"
  #     ];
  #   };
  # };
}
