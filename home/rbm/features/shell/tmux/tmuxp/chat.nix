{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/chat.yaml" = {
      enable = true;

      source = (pkgs.formats.yaml {}).generate "chat.yaml" {
        session_name = "chat 󰭹 ";
        windows = let
          layout = "fd95,212x55,0,0{105x55,0,0,38,106x55,106,0,39}";
          options = {
            automatic-rename = false;
            remain-on-exit = true;
          };
        in [
          {
            inherit layout options;
            window_name = "matrix";
            panes = [
              {
                shell = "~/.nix-profile/bin/iamb";
                focus = true;
              }
            ];
          }
          {
            inherit layout options;
            window_name = "signal";
            focus = true;
            panes = [
              {
                shell = "~/.nix-profile/bin/gurk";
                focus = true;
              }
            ];
          }
        ];
      };
    };
  };
}
