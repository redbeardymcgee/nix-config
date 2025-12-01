{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.w3m];
  programs.aerc = {
    enable = true;
    extraConfig.general.unsafe-accounts-conf = true;

    extraConfig = {
      filters = {
        "text/plain" = "colorize";
        "text/html" = "! w3m -I UTF-8 text/html";
        "text/calendar" = "calendar";
        "text/*" = ''bat -fP --file-name="''${AERC_FILENAME}" --style=plain'';
        ".headers" = "colorize";
        "message/delivery-status" = "colorize";
      };
    };

    templates = {
      quoted_reply =
        # gotmpl
        ''

          {{ if or
            (eq .OriginalMIMEType "text/html")
            (contains (toLower .OriginalText) "<html")
          }}
          {{- $text := exec `/usr/lib/aerc/filters/html` .OriginalText | replace `\r` `` -}}
          {{- range split "\n" $text -}}
            {{- if eq . "References:" }}{{break}}{{end}}
            {{- if or
              (eq (len .) 0)
              (match `^\[.+\]\s*$` .)
            }}{{continue}}{{end}}
            {{- printf "%s\n" . | replace `^[\s]+` "" | quote}}
          {{- end -}}
          {{- else }}
          {{- trimSignature .OriginalText | quote -}}
          {{- end -}}

          {{.Signature -}}
        '';
    };
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
