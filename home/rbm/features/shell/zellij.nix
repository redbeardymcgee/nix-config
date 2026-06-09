{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      # copy_command = "wl-copy";
      # default_layout = "";
      ui.pane_frames = {
        hide_session_name = true;
      };
      show_startup_tips = false;
      show_release_notes = false;

      keybinds = {
        _props.clear-defaults = true;

        pane._children = [
          {
            bind = {
              _args = ["e"];
            };
          }
        ];
      };
    };
  };
}
