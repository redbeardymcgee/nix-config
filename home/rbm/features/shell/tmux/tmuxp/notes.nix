{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/notes.yaml" = {
      enable = true;

      source = (pkgs.formats.yaml {}).generate "notes.yaml" {
        session_name = "notes 󱞁";
        windows = let
          layout = "fd95,212x55,0,0{105x55,0,0,38,106x55,106,0,39}";
          options = {
            automatic-rename = false;
            remain-on-exit = true;
          };
        in [
          {
            inherit layout options;
            window_name = "misc";
            start_directory = "$XDG_DOCUMENTS_DIR/Notebooks/Misc";
            focus = true;
            panes = [
              {
                focus = true;
                shell = "~/.nix-profile/bin/redvim";
              }
            ];
          }
        ];
      };
    };
  };
}
