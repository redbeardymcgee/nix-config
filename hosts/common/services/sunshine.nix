{
  # networking.firewall = {
  #   enable = true;
  #   allowedTCPPorts = [ 47984 47989 47990 48010 ];
  #   allowedUDPPortRanges = [
  #     { from = 47998; to = 48000; }
  #     { from = 8000; to = 8010; }
  #   ];
  # };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;

    settings = {
      back_button_timeout = 2000;
      # global_prep_cmd = "riverctl set-focused-tags 64";
    };

    applications = {
      apps = [
        {
          name = "Desktop";
          image = "desktop.png";
        }

        {
          name = "Big Picture - Flatpak";
          # cmd = "flatpak run com.valvesoftware.Steam";
          detached = [
            "flatpak run com.valvesoftware.Steam"
            # "flatpak run com.valvesoftware.Steam --command='steam steam://open/bigpicture'"
          ];
        }

        {
          name = "Big Picture";
          detached = [
            "setsid steam steam://open/bigpicture"
          ];
        }
      ];
    };
  };
}
