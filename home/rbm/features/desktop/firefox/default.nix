{
  inputs,
  pkgs,
  ...
}: let
  addons = inputs.firefox-addons.packages.${pkgs.system};
in {
  programs.firefox = {
    enable = true;

    # package = pkgs.firefox.override {
    #   nativeMessagingHosts = [
    #     pkgs.tridactyl-native
    #   ];
    # };

    # nativeMessagingHosts = [
    #   pkgs.tridactyl-native
    # ];

    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableFirefoxAccounts = true;
      DisablePocket = true;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = "never";
      DontCheckDefaultBrowser = true;
      DNSOverHTTPS = {
        Enabled = true;
        Fallback = true;
        Locked = true;
      };
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Category = "strict";
        Cryptomining = true;
        EmailTracking = true;
        Fingerprinting = true;
        SuspectedFingerprinting = true;
      };
      FirefoxHome = {
        Locked = true;
        Search = false;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        Stories = false;
        SponsoredPocket = false;
        SponsoredStories = false;
        Snippets = false;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      HardwareAcceleration = true;
      Homepage = {
        Locked = true;
        Startpage = "previous-session";
        URL = "https://searxng.mcgee.red";
      };
      NewTabPage = false;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      OfferToSaveLoginsDefault = false;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      PasswordManagerEnabled = false;
      SearchSuggestEnabled = false;
      ShowHomeButton = false;
      SkipTermsOfUse = true;
      TranslateEnabled = true;
      UserMessaging = {
        Locked = true;
        ExtensionRecommended = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
      };
    };

    profiles = {
      rbm = {
        name = "Default";
        id = 0;
        isDefault = true;
        containersForce = true;

        containers = {
          default = {
            id = 0;
            name = "Default";
            color = "toolbar";
            icon = "circle";
          };

          social = {
            id = 1;
            name = "Social Media";
            color = "red";
            icon = "fingerprint";
          };

          torrents = {
            id = 2;
            name = "Torrents";
            color = "blue";
            icon = "cart";
          };

          banking = {
            id = 3;
            name = "Banking";
            color = "green";
            icon = "dollar";
          };
        };

        extensions = {
          force = true;

          # https://nur.nix-community.org/repos/rycee/
          packages = with addons; [
            augmented-steam
            bitwarden
            blocktube
            censor-tracker
            clearurls
            click-and-read
            consent-o-matic
            dark-mode-website-switcher
            dearrow
            fastforwardteam
            firemonkey
            image-search-options
            # libredirect
            linkwarden
            multi-account-containers
            passbolt
            pronoundb
            protondb-for-steam
            purpleadblock
            react-devtools
            refined-github
            seventv
            skip-redirect
            sponsorblock
            # tridactyl
            # twitch-auto-points
            ublock-origin
          ];
        };

        search = {
          force = true;
          default = "searxng";
          privateDefault = "searxng";

          engines = {
            searxng = {
              name = "searxng";
              definedAliases = ["@searxng" "@mcgee"];

              urls = [
                {
                  template = "https://searxng.mcgee.red";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            nix-packages = {
              name = "Nix Packages";
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np" "@nixpkgs"];
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            nixos-wiki = {
              name = "NixOS Wiki";
              iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
              definedAliases = ["@nw" "@nixwiki"];
              urls = [
                {
                  template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                  params = [
                    {
                      name = "search";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            home-manager = {
              name = "Home Manager Options";
              definedAliases = ["@hm" "@homemanager"];
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                    {
                      name = "release";
                      value = "release-25.05";
                    }
                  ];
                }
              ];
            };
          };
        };

        settings = {
          # "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          "browser.startup.page" = 3;

          "extensions.autoDisableScopes" = 0;
          "extensions.update.autoUpdateDefault" = false;
          "extensions.update.enabled" = false;

          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
          "sidebar.visibility" = "always-show";
          "sidebar.position_start" = false;
          "sidebar.notification.badge.aichat" = false;
          "sidebar.new-sidebar.has-used" = true;
        };
      };

      testing = {
        id = 99;

        extensions = {
          packages = with addons; [
            ublock-origin
          ];
        };

        settings = {
          "extensions.autoDisableScopes" = 0;
        };
      };
    };
  };

  home.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

  # xdg.configFile."tridactyl/tridactylrc".source = ./tridactylrc;
  stylix.targets.firefox = {
    colorTheme.enable = true;
    profileNames = ["rbm"];
  };
}
