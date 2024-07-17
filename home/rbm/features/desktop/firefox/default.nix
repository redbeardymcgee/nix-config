{pkgs, ...}: {
  programs.firefox = {
    enable = true;

    package = pkgs.firefox.override {
      nativeMessagingHosts = [
        pkgs.tridactyl-native
      ];
    };

    nativeMessagingHosts = [
      pkgs.tridactyl-native
    ];

    profiles = {
      rbm = {
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "extensions.autoDisableScopes" = 0;
        };
      };
    };
  };

  home.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

  xdg.configFile."tridactyl/tridactylrc".source = ./tridactylrc;
}
