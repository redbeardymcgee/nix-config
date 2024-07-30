{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/projects.yaml" = let
      opts = {
        automatic-rename = false;
        remain-on-exit = true;
      };
    in {
      enable = true;

      source = (pkgs.formats.yaml {}).generate "projects.yaml" {
        session_name = "proj  ";

        windows = [
          {
            window_name = "bookworm";
            start_directory = "/mnt/2tb/repos/justaguylinux/bookworm-scripts";
            options = opts;
            panes = [{shell_command = ["nvim ."];}];
          }
          {
            window_name = "sway";
            start_directory = "/mnt/2tb/repos/justaguylinux/sway";
            options = opts;
            panes = [{shell_command = ["nvim ."];}];
          }
          {
            window_name = "shmux";
            start_directory = "/mnt/2tb/repos/shmux";
            options = opts;
            panes = [{shell_command = ["nvim ."];}];
          }
          {
            window_name = "kixvim";
            start_directory = "/mnt/2tb/repos/kixvim";
            options = opts;
            panes = [{shell_command = ["nvim ."];}];
          }
          {
            window_name = "monitor";
            window_index = 0;
            options = opts;
            panes = [{shell = "~/.nix-profile/bin/btm";}];
          }
        ];
      };
    };
  };
}
