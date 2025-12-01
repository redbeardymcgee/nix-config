{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/perseus.yaml" = {
      enable = true;
      source = (pkgs.formats.yaml {}).generate "perseus.yaml" {
        session_name = "srv  ";
        windows = let
          layout = "fd95,212x55,0,0{105x55,0,0,38,106x55,106,0,39}";
          options = {
            automatic-rename = false;
            remain-on-exit = true;
          };
        in [
          {
            inherit layout options;
            window_name = "src";
            focus = true;
            panes = [
              {
                focus = true;
                start_directory = "~/src/redbeardymcgee/quadlet-store/";
                # shell = "~/.nix-profile/bin/redvim";
              }

              {
                focus = true;
                shell_command = ["ssh -t perseus tmux attach"];
              }
            ];
          }
          {
            inherit options;
            window_name = "dox";
            panes = [
              {
                focus = true;
                start_directory = "~/src/redbeardymcgee/podbox-docs";
                shell = "~/.nix-profile/bin/redvim";
              }
            ];
          }
        ];
      };
    };
  };
}
