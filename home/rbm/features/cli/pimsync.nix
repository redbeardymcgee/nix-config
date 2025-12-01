{
  config,
  pkgs,
  ...
}: {
  # programs.pimsync = {
  #   enable = true;
  # };

  services.pimsync = {
    enable = true;
  };

  accounts = let
    nextcloudUrl = "https://cloud.ocdp.social";
    protonMailAddress = "redbeardymcgee@proton.me";
    nextcloudPassCmd = [
      "rbw"
      "get"
      "OCDP cloud"
      protonMailAddress
    ];
    realName = "Redbeardy McGee";
  in {
    email.accounts = {
      protonmail = let
        perseus = "203.0.113.250";
        bridgePassword = "XDwKddnGVbaFI5mLxzVQaw";
      in {
        address = protonMailAddress;
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

          extraAccounts = {
            source = "imap+insecure://redbeardymcgee%40proton.me:${bridgePassword}@${perseus}:1143";
            outgoing = "smtp+insecure://redbeardymcgee%40proton.me:${bridgePassword}@${perseus}:1025";
            default = "INBOX";
            from = "${realName} <${protonMailAddress}>";
            copy-to = "Sent";
          };
        };
      };
    };

    contact.accounts = {
      nextcloud = {
        remote = {
          type = "carddav";
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
          addresses = [protonMailAddress];
        };
      };
    };

    calendar.accounts = {
      nextcloud = {
        primary = true;
        primaryCollection = "Indivisible Meetings";
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
          addresses = [protonMailAddress];
          type = "discover";
        };
      };
    };
  };
}
