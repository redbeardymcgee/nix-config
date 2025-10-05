{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
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
          Search = true;
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
        HttpsOnlyMode = "force_enabled";
        NewTabPage = false;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        PasswordManagerEnabled = false;
        SearchSuggestEnabled = false;
        ShowHomeButton = false;
        SkipTermsOfUse = true;
        TranslateEnabled = true;
        UserMessaging = {
          Locked = true;
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          UrlbarInterventions = false;
          SkipOnboarding = true;
          MoreFromMozilla = false;
        };

        ExtensionSettings = {
          "dark-mode-website-switcher@rugk.github.io" = {
            # Dark Mode Website Switcher
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/dark-mode-website-switcher@rugk.github.io/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "deArrow@ajay.app" = {
            # DeArrow
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/deArrow@ajay.app/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "firefox-addon@pronoundb.org" = {
            # Pronoundb
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/firefox-addon@pronoundb.org/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "FirefoxColor@mozilla.com" = {
            # Firefox Color
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/FirefoxColor@mozilla.com/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "firemonkey@eros.man" = {
            # Firemonkey
            default_area = "navbar";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/firemonkey@eros.man/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "gdpr@cavi.au.dk" = {
            # Consent-o-Matic
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/gdpr@cavi.au.dk/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "nist.users@gmail.com" = {
            # Click and Read
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/nist.users@gmail.com/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "jordanlinkwarden@gmail.com" = {
            # Linkwarden
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/jordanlinkwarden@gmail.com/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "moz-addon-prod@7tv.app" = {
            # SevenTV
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/moz-addon-prod@7tv.app/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "passbolt@passbolt.com" = {
            # Passbolt
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/assbolt@passbolt.com/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "skipredirect@sblask" = {
            # Skip Redirect
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/skipredirect@sblask/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "sponsorBlocker@ajay.app" = {
            # SponsorBlock
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorBlocker@ajay.app/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "workspaces@fm-sys" = {
            # Workspaces
            default_area = "navbar";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/workspaces@fm-sys/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "{1be309c5-3e4f-4b99-927d-bb500eb4fa88}" = {
            # Augmented Steam
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/{1be309c5-3e4f-4b99-927d-bb500eb4fa88}/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "{4a313247-8330-4a81-948e-b79936516f78}" = {
            # Image Search Options
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/{4a313247-8330-4a81-948e-b79936516f78}/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "{5d0d1f87-5991-42d3-98c3-54878ead1ed1}" = {
            # Censor Tracker
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/{5d0d1f87-5991-42d3-98c3-54878ead1ed1}/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "{58204f8b-01c2-4bbc-98f8-9a90458fd9ef}" = {
            # BlockTube
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/{58204f8b-01c2-4bbc-98f8-9a90458fd9ef}/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "{74145f27-f039-47ce-a470-a662b129930a}" = {
            # ClearURLs
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/{74145f27-f039-47ce-a470-a662b129930a}/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            # Bitwarden
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/{446900e4-71c2-419f-a6a7-df9c091e268b}/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "{30280527-c46c-4e03-bb16-2e3ed94fa57c}" = {
            # ProtonDB
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/{30280527-c46c-4e03-bb16-2e3ed94fa57c}/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = {
            # Refined Github
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "uBlock0@raymondhill.net" = {
            # uBlock Origin
            default_area = "navbar";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "7esoorv3@alefvanoon.anonaddy.me" = {
            # LibRedirect
            default_area = "navbar";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/7esoorv3@alefvanoon.anonaddy.me/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "@react-devtools" = {
            # React Devtools
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/@react-devtools/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };

          "@testpilot-containers" = {
            # Multi-account Containers
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/@testpilot-containers/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
        };
      };
    };

    # package = pkgs.firefox.override {
    #   nativeMessagingHosts = [
    #     pkgs.tridactyl-native
    #   ];
    # };

    # nativeMessagingHosts = [
    #   pkgs.tridactyl-native
    # ];

    profiles = {
      Default = {
        isDefault = false;
      };

      rbm = {
        name = "rbm";
        id = 1;
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

          suspicious = {
            id = 4;
            name = "Suspicious Sites";
            color = "turquoise";
            icon = "fence";
          };
        };

        search = {
          force = true;
          default = "searxng";
          privateDefault = "searxng";

          engines = {
            searxng = {
              name = "SearxNG";
              iconMapObj."16" = "https://searxng.mcgee.red/favicon.png";
              definedAliases = ["@searxng" "@mcgee"];

              urls = [
                {
                  template = "https://searxng.mcgee.red/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            nixPackages = {
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

            nixosWiki = {
              name = "NixOS Wiki";
              iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
              definedAliases = ["@nw" "@nixwiki"];
              urls = [
                {
                  template = "https://wiki.nixos.org/w/index.php";
                  params = [
                    {
                      name = "search";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            homeManager = {
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

          "browser.startup.page" = 3; # Restore previous session

          "browser.download.useDownloadDir" = false; # Ask for download location

          "extensions.autoDisableScopes" = 0; # Auto-enable extensions
          "extensions.update.autoUpdateDefault" = false;
          "extensions.update.enabled" = false;

          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
          "sidebar.visibility" = "always-show";
          "sidebar.position_start" = false; # Sidebar position right
          "sidebar.notification.badge.aichat" = false;
          "sidebar.new-sidebar.has-used" = true;
        };
      };
    };
  };

  home.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

  # xdg.configFile."tridactyl/tridactylrc".source = ./tridactylrc;
  stylix.targets.firefox = {
    # colorTheme.enable = true;
    profileNames = ["rbm"];
  };
}
