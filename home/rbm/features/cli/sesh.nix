{
  programs.sesh = {
    enable = true;
    enableAlias = true;
    enableTmuxIntegration = true;

    settings = {
      sort_order = [
        "tmux"
        "config"
      ];

      session = let
        eza = "eza -a --git --icons --color=always {}";
      in [
        {
          name = "localhost";
          startup_command = "smug start localhost -i";
        }

        {
          name = "notes";
          path = "~/Documents/Notebooks";
          startup_command = "smug start notes -i";
          preview-command = eza;
        }

        {
          name = "perseus";
          startup_command = "smug start perseus -i";
        }

        {
          name = "mcgeedia";
          startup_command = "smug start mcgeedia -i";
        }

        {
          name = "projects";
          path = "~/src/redbeardymcgee";
          startup_command = "smug start projects -i";
          preview_command = eza;
        }

        {
          name = "chat";
          startup_command = "smug start chat -i";
        }
      ];
    };
  };
}
