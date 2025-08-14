{config, ...}: {
  programs.aerc = {
    enable = true;
    extraConfig.general.unsafe-accounts-conf = true;
  };
  accounts.email.accounts.gmail = let
    appPassword = "dsrvwuzscadoytzs";
  in {
    address = "redbeardymcgee@gmail.com";
    primary = true;
    realName = "redbeardymcgee";
    userName = "redbeardymcgee";
    signature = {
      delimiter = "---";
      showSignature = "append";
    };

    aerc = {
      enable = true;
      extraAccounts = {
        from = "redbeardymcgee <redbeardymcgee@gmail.com>";
        source = "imaps://redbeardymcgee%40gmail.com:${appPassword}@imap.gmail.com";
        outgoing = "smtps://redbeardymcgee%40gmail.com:${appPassword}@smtp.gmail.com";
        default = "INBOX";
        folders-sort = "INBOX";
        postpone = "[Gmail]/Drafts";
        cache-headers = true;
      };
    };
  };

  # accounts.email.accounts.protonmail = let
  # certificatesFile = "${config.home.homeDirectory}/Documents/protonmail.pem";
  # in {
  #   address = "redbeardymcgee@proton.me";
  #   primary = true;
  #   realName = "redbeardymcgee";
  #   userName = "redbeardymcgee";
  #   signature = {
  #     delimiter = "---";
  #     showSignature = "append";
  #   };
  #   imap = {
  #     host = "perseus.localdomain";
  #     port = 1143;
  #     tls = {
  #       enable = true;
  #       certificatesFile = certificatesFile;
  #       useStartTls = true;
  #     };
  #   };
  #   smtp = {
  #     host = "perseus.localdomain";
  #     port = 1025;
  #     tls = {
  #       enable = true;
  #       certificatesFile = certificatesFile;
  #       useStartTls = true;
  #     };
  #   };
  #
  #   aerc = {
  #     enable = true;
  #
  #     extraAccounts = {
  #       source = "imap://redbeardymcgee%40proton.me:5TghBVkr4GfvC13bIYa9zg@perseus.localdomain:1143";
  #       outgoing = "smtp://redbeardymcgee%40proton.me:5TghBVkr4GfvC13bIYa9zg@perseus.localdomain:1025";
  #       default = "INBOX";
  #       from = "redbeardymcgee <redbeardymcgee@proton.me>";
  #       copy-to = "Sent";
  #     };
  #   };
  # };
}
