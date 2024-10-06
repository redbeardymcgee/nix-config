{
  inputs,
  pkgs,
  ...
}: let
  addons = inputs.firefox-addons.packages.${pkgs.system};
in {
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
        id = 0;

        extensions = with addons; [
          addy_io
          auto-tab-discard
          blocktube
          # chatgptbox # seems broken with tridactyl
          consent-o-matic
          dark-mode-website-switcher
          dearrow
          fastforwardteam
          violentmonkey
          libredirect
          react-devtools
          refined-github
          skip-redirect
          sponsorblock
          tridactyl
          ublock-origin
        ];

        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "extensions.autoDisableScopes" = 0;
        };
      };

      testing = {
        id = 99;

        extensions = with addons; [
          ublock-origin
        ];

        settings = {
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
