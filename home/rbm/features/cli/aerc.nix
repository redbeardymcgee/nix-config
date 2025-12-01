{config, ...}: {
  programs.aerc = {
    enable = true;
    extraConfig.general.unsafe-accounts-conf = true;
  };
  # accounts.email.accounts.gmail = let
  #   ## FIXME: This is impure, therefore unallowed. The solution is apparently
  #   ## `scalpel` but that doesn't look easy either.
  #   appPassword = builtins.readFile config.sops.secrets.gmail_password.path;
  # in {
  #   address = "redbeardymcgee@gmail.com";
  #   primary = false;
  #   realName = "redbeardymcgee";
  #   userName = "redbeardymcgee";
  #   signature = {
  #     delimiter = "---";
  #     showSignature = "append";
  #   };
  #
  #   aerc = {
  #     enable = true;
  #     extraAccounts = {
  #       from = "redbeardymcgee <redbeardymcgee@gmail.com>";
  #       source = "imaps://redbeardymcgee%40gmail.com:${appPassword}@imap.gmail.com";
  #       outgoing = "smtps://redbeardymcgee%40gmail.com:${appPassword}@smtp.gmail.com";
  #       default = "INBOX";
  #       folders-sort = "INBOX";
  #       postpone = "[Gmail]/Drafts";
  #       cache-headers = true;
  #     };
  #   };
  # };

  accounts.email.accounts.protonmail = let
    perseus = "203.0.113.250";
    bridgePassword = "XDwKddnGVbaFI5mLxzVQaw";
  in {
    address = "redbeardymcgee@proton.me";
    primary = true;
    realName = "redbeardymcgee";
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
        from = "redbeardymcgee <redbeardymcgee@proton.me>";
        copy-to = "Sent";
      };
    };
  };
}
