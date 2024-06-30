{
  pkgs,
  ...
}: {
  xdg.configFile = {
    "tmuxp/localhost.yaml" = {
      enable = true;
      source = (pkgs.formats.yaml {}).generate "localhost.yaml" {
        session_name = "localhost";
        windows = [
          {
            window_name = "main";
            focus = true;
            options = {
              remain-on-exit = true;
            };
            panes = [
              {shell_command = ["yy"];}
            ];
          }
          {
            window_name = "cfg";
            start_directory = "~/nix-config";
            options = {
              remain-on-exit = true;
            };
            panes = [
              {
                shell_command = [
                  "${pkgs.neovim}/bin/nvim ."
                ];
              }
            ];
          }
          {
            window_name = "monitor";
            window_index = "0";
            options = {
              remain-on-exit = true;
            };
            panes = [
              {
                shell = "${pkgs.bottom}/bin/btm";
              }
            ];
          }
        ];
      };
    };
  };
}
