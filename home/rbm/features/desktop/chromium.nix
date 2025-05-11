{
  programs.chromium = {
    enable = true;

    homepageLocation = "https://sogebot.mcgee.red/?server=https://sogebot-backend.mcgee.red";
    defaultSearchProviderSearchURL = "https://www.qwant.com/?q={searchTerms}";
    defaultSearchProviderSeachProviderSuggestURL = "https://www.qwant.com/?q={searchTerms}";
    extraOpts = {
      "BrowserSignin" = 0;
      "SyncDisabled" = true;
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [
        "en-US"
      ];
    }
    ;

    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      # "ammjkodgmmoknidbanneddgankgfejfh" # 7TV
    ];
  };
}
