{
  lib,
  inputs,
  pkgs,
  ...
}: {
  programs.fish.functions = {
    y = {
      wraps = "yazi";
      body =
        # fish
        ''
          builtin cd -- "$(command yazi $argv --cwd-file /dev/stdout)"
        '';
    };
  };

  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.system}.default;
    enableFishIntegration = false;
    initLua = ./init.lua;
    keymap = import ./keymap.nix;

    plugins = let
      officialPluginsNames = [
        "chmod"
        "diff"
        "full-border"
        "smart-filter"
      ];

      officialPluginsSrc = pkgs.fetchgit {
        url = "https://github.com/yazi-rs/plugins.git";
        sparseCheckout = map (p: "${p}.yazi") officialPluginsNames;
        rev = "aeca767ec27bfbea66873d667a729791de18f364";
        hash = "sha256-+BL7ALt8UmJNDP0wVWBHumxss7JvjG5wgiorVbFHn8w=";
      };

      officialPlugins =
        lib.lists.fold (
          a: b:
            {
              ${a} = "${officialPluginsSrc}/${a}.yazi";
            }
            // b
        )
        {}
        officialPluginsNames;
    in
      with pkgs;
        officialPlugins
        // {
          augment-command = fetchFromGitHub {
            owner = "hankertrix";
            repo = "augment-command.yazi";
            rev = "a03a23713aecaa25c58e830eead34461f1d66853";
            hash = "sha256-Zyd4Q003rT4mfFUqt6dzykUYTGeUc++q7qT0D7GKoFA=";
          };
          allmytoes = fetchFromGitHub {
            owner = "sonico98";
            repo = "allmytoes.yazi";
            rev = "dd7895d833dc062785506b171305d7f6940ada65";
            hash = "sha256-T1Zx+K/0qHD5iAOhV2mG7amjNLLFzjLxuAx192FCLEk=";
          };
          exifaudio = fetchFromGitHub {
            owner = "sonico98";
            repo = "exifaudio.yazi";
            rev = "e766cd273246612fe71fc18d2126619a41273c32";
            hash = "sha256-aniuY14pXcoaW6YkUwt7hTl9mWjl5HoOPhHkuY4ooAw=";
          };
          glow = fetchFromGitHub {
            owner = "reledia";
            repo = "glow.yazi";
            rev = "bd3eaa58c065eaf216a8d22d64c62d8e0e9277e9";
            hash = "sha256-mzW/ut/LTEriZiWF8YMRXG9hZ70OOC0irl5xObTNO40=";
          };
          hexyl = fetchFromGitHub {
            owner = "reledia";
            repo = "hexyl.yazi";
            rev = "016a09bcc249dd3ce06267d54cc039e73de9c647";
            hash = "sha256-ly/cLKl2y3npoT2nX8ioGOFcRXI4UXbD9Es/5veUhOU=";
          };
          miller = fetchFromGitHub {
            owner = "reledia";
            repo = "miller.yazi";
            rev = "0a3d1316e38132ae9a6b91fbd69bab295cbbf2fe";
            hash = "sha256-pZpx7V5ud5JhEkgkfVBSuM0CFIIUXZZ+pOX0xVlHf+0=";
          };
          ouch = fetchFromGitHub {
            owner = "ndtoan96";
            repo = "ouch.yazi";
            rev = "1ee69a56da3c4b90ec8716dd9dd6b82e7a944614";
            hash = "sha256-4KZeDkMXlhUV0Zh+VGBtz9kFPGOWCexYVuKUSCN463o=";
          };
          torrent-preview = fetchFromGitHub {
            owner = "kirasok";
            repo = "torrent-preview.yazi";
            rev = "4ca5996a8264457cbefff8e430acfca4900a0453";
            hash = "sha256-vaeOdNa56wwzBV6DgJjprRlrAcz2yGUYsOveTJKFv6M=";
          };
          yamb = fetchFromGitHub {
            owner = "h-hg";
            repo = "yamb.yazi";
            rev = "22af0033be18eead7b04c2768767d38ccfbaa05b";
            hash = "sha256-NMxZ8/7HQgs+BsZeH4nEglWsRH2ibAzq7hRSyrtFDTA=";
          };
          lazygit = fetchFromGitHub {
            owner = "Lil-Dank";
            repo = "lazygit.yazi";
            rev = "7a08a0988c2b7481d3f267f3bdc58080e6047e7d";
            hash = "sha256-OJJPgpSaUHYz8a9opVLCds+VZsK1B6T+pSRJyVgYNy8=";
          };
        };

    settings = {
      mgr = {
        sort_dir_first = true;
      };

      plugin = {
        # fetchers = [
        #   {
        #     id = "git-status";
        #     name = "*";
        #     run = "git-status";
        #     prio = "normal";
        #   }
        # ];

        prepend_preloaders = [
          {
            mime = "image/svg+xml";
            run = "magick";
          }
          {
            mime = "image/heic";
            run = "magick";
          }
          {
            mime = "image/jxl";
            run = "magick";
          }
          {
            mime = "image/*";
            run = "allmytoes";
          }
        ];

        prepend_previewers = [
          {
            mime = "application/*zip";
            run = "ouch";
          }
          {
            mime = "application/x-tar";
            run = "ouch";
          }
          {
            mime = "application/x-bzip2";
            run = "ouch";
          }
          {
            mime = "application/x-7z-compressed";
            run = "ouch";
          }
          {
            mime = "application/x-rar";
            run = "ouch";
          }
          {
            mime = "application/x-xz";
            run = "ouch";
          }
          {
            mime = "image/svg+xml";
            run = "magick";
          }
          {
            mime = "image/heic";
            run = "magick";
          }
          {
            mime = "image/jxl";
            run = "magick";
          }
          {
            mime = "image/*";
            run = "allmytoes";
          }
          {
            mime = "*.md";
            run = "glow";
          }
          {
            mime = "text/csv";
            run = "miller";
          }
          {
            mime = "audio/*";
            run = "exifaudio";
          }
          {
            mime = "application/x-bittorrent";
            run = "torrent-preview";
          }
        ];

        append_previewers = [
          {
            name = "*";
            run = "hexyl";
          }
        ];
      };
    };
  };
}
