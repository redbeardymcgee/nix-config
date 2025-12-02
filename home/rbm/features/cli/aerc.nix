{pkgs, ...}: {
  programs.aerc = {
    enable = true;
    extraConfig.general.unsafe-accounts-conf = true;

    extraConfig = {
      filters = {
        "text/plain" = "colorize";
        "text/html" = "! cha -T text/html";
        "text/calendar" = "calendar";
        # "text/*" = ''bat -fP --file-name=''"$AERC_FILENAME" --style=plain'';
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
            {{- if eq . "References:" }}
              {{break}}
            {{end}}
            {{- if or
              (eq (len .) 0)
              (match `^\[.+\]\s*$` .)
            }}
              {{continue}}
            {{end}}
            {{- printf "%s\n" . | replace `^[\s]+` "" | quote}}
          {{- end -}}
          {{- else }}
          {{- trimSignature .OriginalText | quote -}}
          {{- end -}}

          {{.Signature -}}
        '';
    };
  };
}
