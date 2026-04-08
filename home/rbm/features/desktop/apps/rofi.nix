{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    extraConfig = {
      cycle = true;
      font = "FiraCode Nerd Font 14";
      terminal = "${pkgs.foot}/bin/foot";
      kb-primary-paste = "Control+v,Shift+Insert";
      kb-secondary-paste = "Control+Shift+v,Control+Insert";
      matching = "fuzzy";
      sorting-method = "fzf";
    };
  };

  home = {
    packages = with pkgs; [
      # pinentry-rofi
      rofimoji
      rofi-bluetooth
      rofi-power-menu
      rofi-pulse-select
      rofi-rbw
      # rofi-screenshot
    ];
    sessionVariables = {
      ROFI_SYSTEMD_TERM = "${pkgs.foot}/bin/foot";
    };
  };

  wayland.windowManager = {
    river.settings.map.normal = {
      "None Menu" = "spawn '$(rofi -show drun)'";
      "Super Menu" = "spawn '$(rofi -show run)'";
      "Super+Shift A" = "spawn '$(rofi-pulse-select sink)'";
      "Super+Shift B" = "spawn '$(rofi-bluetooth)'";
      "Super+Shift E" = "spawn '$(rofimoji)'";
      "Super+Shift P" = "spawn '$(rofi -show power-menu -modi power-menu:rofi-power-menu)'";
      "Super+Shift X" = "spawn '$(rofi-rbw)'";
      # "None Print" = "spawn '$(rofi-screenshot)'";
    };
  };
}
