{
  programs.sesh = {
    enable = true;
    enableAlias = true;
    enableTmuxIntegration = true;

    settings = {
      sort_order = [
        "tmux"
        "zoxide"
      ];

      session = [
        {
          name = "localhost";
          startup_command = "smug start localhost";
        }

        {
          name = "notes";
          path = "~/Documents/Notebooks";
          startup_command = "smug start notes";
          preview-command = "ls {}";
        }

        {
          name = "perseus";
          startup_command = "smug start perseus";
        }

        {
          name = "mcgeedia";
          startup_command = "smug start mcgeedia";
        }

        {
          name = "projects";
          startup_command = "smug start projects";
          preview_command = "ls {}";
        }

        {
          name = "chat";
          startup_command = "smug start chat";
        }
      ];
    };
  };
}
