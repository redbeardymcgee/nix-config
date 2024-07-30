{
  programs.foot = {
    enable = true;
    settings = {
      mouse.hide-when-typing = "yes";
      key-bindings.pipe-command-output = ''
        [sh -c 'f=$(mktemp); cat - > $f; footclient bat $f; rm $f'] Control+Shift+g
      '';
    };
  };

  wayland.windowManager = {
    river.settings.map.normal = {
      "Super Space" = "spawn 'foot --app-id=foot_localhost tmuxp load -y localhost'";
    };
  };
}
