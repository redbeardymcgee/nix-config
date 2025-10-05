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
    enableFishIntegration = true;
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
        rev = "d1c8baab86100afb708694d22b13901b9f9baf00";
        hash = "sha256-tPoZE1M/LCNQS07VRJBJUHgU8RCRa8eeN3h3IK04l2w=";
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
            rev = "120406f79b6a5bf4db6120dd99c1106008ada5cf";
            hash = "sha256-t9X7cNrMR3fFqiM13COQbBDHYr8UKgxW708V6ndZVgY=";
          };
          allmytoes = fetchFromGitHub {
            owner = "sonico98";
            repo = "allmytoes.yazi";
            rev = "e9697528fa446521927a7e039e3d4a01a85eb20f";
            hash = "sha256-LekO13LU18lfuIuY7AgGnjLfRZw16Ap/tBEkQQYKp8g=";
          };
          exifaudio = fetchFromGitHub {
            owner = "sonico98";
            repo = "exifaudio.yazi";
            rev = "4506f9d5032e714c0689be09d566dd877b9d464e";
            hash = "sha256-RWCqWBpbmU3sh/A+LBJPXL/AY292blKb/zZXGvIA5/o=";
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
            rev = "0742fffea5229271164016bf96fb599d861972db";
            hash = "sha256-C0wG8NQ+zjAMfd+J39Uvs3K4U6e3Qpo1yLPm2xcsAaI=";
          };
          torrent-preview = fetchFromGitHub {
            owner = "kirasok";
            repo = "torrent-preview.yazi";
            rev = "f46528243c458de3ffce38c44607d5a0cde67559";
            hash = "sha256-VhJvNRKHxVla4v2JJeSnP0MOMBFSm4k7gfqjrHOMVlo=";
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
            rev = "8f37dc5795f165021098b17d797c7b8f510aeca9";
            hash = "sha256-rR7SMTtQYrvQjhkzulDaNH/LAA77UnXkcZ50WwBX2Uw=";
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
