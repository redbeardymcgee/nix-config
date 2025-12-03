{
  config,
  pkgs,
  ...
}: let
  calendarPath = "${config.xdg.dataHome}/calendar";
  contactPath = "${config.xdg.dataHome}/contact";
in {
  programs.pimsync = {
    enable = true;
  };

  services.pimsync = {
    enable = true;
  };

  systemd.user.tmpfiles.rules = [
    "d ${calendarPath} - - - - -"
    "d ${calendarPath}/nextcloud - - - - -"
    "d ${contactPath} - - - - -"
    "d ${contactPath}/nextcloud - - - - -"
  ];

  accounts = let
    nextcloudUrl = "https://cloud.ocdp.social";
    protonMailAddress = "redbeardymcgee@proton.me";
    protonMailAliases = ["josh.mcgee@ocdp.social"];
    nextcloudPassCmd = [
      "rbw"
      "get"
      "OCDP cloud"
      protonMailAddress
    ];
  in {
    email.accounts = let
      perseus = "203.0.113.250";
    in {
      protonmail = let
        bridgePassword = "XDwKddnGVbaFI5mLxzVQaw";
        realName = "Redbeardy McGee";
      in {
        address = protonMailAddress;
        aliases = protonMailAliases;
        primary = true;
        realName = realName;
        userName = "redbeardymcgee";
        signature = {
          delimiter = "---";
          showSignature = "append";
        };
        imap = {
          host = perseus;
          port = 1143;
        };
        smtp = {
          host = perseus;
          port = 1025;
        };

        aerc = {
          enable = true;

          extraAccounts = let
            userName = pkgs.lib.strings.escapeURL protonMailAddress;
          in {
            source = "imap+insecure://${userName}:${bridgePassword}@${perseus}:1143";
            outgoing = "smtp+insecure://${userName}:${bridgePassword}@${perseus}:1025";
            default = "INBOX";
            from = "${realName} <${protonMailAddress}>";
            copy-to = "Sent";
          };
        };
      };
      indivisible = let
        indivisibleMailAddress = "IndivisibleNWTN@proton.me";
        bridgePassword = "oAi1URXze0p7DVX_e5daWA";
        realName = "Indivisible NWTN";
      in {
        address = indivisibleMailAddress;
        realName = realName;
        userName = "IndivisibleNWTN";
        signature = {
          delimiter = "---";
          showSignature = "append";
        };
        imap = {
          host = perseus;
          port = 1143;
        };
        smtp = {
          host = perseus;
          port = 1025;
        };

        aerc = {
          enable = true;

          extraAccounts = let
            userName = pkgs.lib.strings.escapeURL indivisibleMailAddress;
          in {
            source = "imap+insecure://${userName}:${bridgePassword}@${perseus}:1143";
            outgoing = "smtp+insecure://${userName}:${bridgePassword}@${perseus}:1025";
            default = "INBOX";
            from = "${realName} <${indivisibleMailAddress}>";
            copy-to = "Sent";
          };
        };
      };
    };

    contact = {
      basePath = "${config.xdg.dataHome}/contact";

      accounts = {
        nextcloud = {
          remote = {
            type = "carddav";
            url = nextcloudUrl;
            userName = protonMailAddress;
            passwordCommand = nextcloudPassCmd;
          };
          local = {
            type = "filesystem";
          };
          pimsync = {
            enable = true;
            extraPairDirectives = [
              {
                name = "collections";
                params = [
                  "all"
                ];
              }
            ];
          };
          khal = {
            enable = true;
            addresses = [protonMailAddress];
          };
        };
      };
    };

    calendar = {
      basePath = "${config.xdg.dataHome}/calendar";

      accounts = {
        nextcloud = {
          primary = true;
          primaryCollection = "nextcloud";
          remote = {
            type = "caldav";
            url = nextcloudUrl;
            userName = protonMailAddress;
            passwordCommand = nextcloudPassCmd;
          };
          pimsync = {
            enable = true;
            extraPairDirectives = [
              {
                name = "collections";
                params = [
                  "all"
                ];
              }
            ];
          };
          khal = {
            enable = true;
            addresses = [protonMailAddress] ++ protonMailAliases;
            type = "discover";
          };
        };
      };
    };
  };
}
