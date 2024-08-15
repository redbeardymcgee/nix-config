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
          # TODO: Confirm this runs correctly with whitespace or empty $argv
          set --local patharg "."
          if set -q argv
            set patharg "$argv"
          end
          builtin cd -- "$(command yazi "$patharg" --cwd-file /dev/stdout)"
        '';
    };
  };

  programs.yazi = {
    enable = true;
    # package = inputs.yazi.packages.${pkgs.system}.default;
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
        rev = "2dc65ab07d85c3a63e663eeade1324438dc83942";
        hash = "sha256-lnEOcM7oXpE++qrRInkHILIrZVlrIco1R3vgS/6y7jk=";
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
          # UI
          # yaziline = fetchFromGitHub {
          #   owner = "llanosrocas";
          #   repo = "yaziline.yazi";
          #   rev = "b22e2e8962c6fc8a27f8510a29a186b764577c1a";
          #   hash = "sha256-kLK4EvECzE43cAVcdHGhKvbJ+pS0jvd2ggW5XTq7jWc=";
          # };
          #^ UI

          # Features
          augment-command = fetchFromGitHub {
            owner = "hankertrix";
            repo = "augment-command.yazi";
            rev = "2a1fb5d26162ae80941f3c2ba49c826d752cf289";
            hash = "sha256-KAoGmgIE7Y6Roexq86j+ZFt9ebnQ/qfvQsSpFX/iyO4=";
          };

          searchjump = fetchgit {
            url = "https://gitee.com/DreamMaoMao/searchjump.yazi";
            rev = "520f34d4f29460005710da8ffec2da473212841f";
            hash = "sha256-aZcz63x0c0+ZnA2UrmraLYrH+RG4aF8c9G3LD4owH4c=";
          };

          yamb = fetchFromGitHub {
            owner = "h-hg";
            repo = "yamb.yazi";
            rev = "022e9b0b3c8dcd81706aefe5dff4b80e610a0351";
            hash = "sha256-TlKv8jmYtorbwWA3yjRVRgx239TBVF3hoyL+zguJqKQ=";
          };
          #^ Features

          # Previewers
          allmytoes = fetchFromGitHub {
            owner = "sonico98";
            repo = "allmytoes.yazi";
            rev = "e5329138a19615e63bff6a581eb69d1d1eb5d4fe";
            hash = "sha256-S9O8jgTjdOxf/Zybmgm7nGBkd2Ipt2DtQ+Be2uawyNA=";
          };

          exifaudio = fetchFromGitHub {
            owner = "Sonico98";
            repo = "exifaudio.yazi";
            rev = "94329ead8b3a6d3faa2d4975930a3d0378980c7a";
            hash = "sha256-jz6fVtcLHw9lsxFWECbuxE7tEBttE08Fl4oJSTifaEc=";
          };

          glow = fetchFromGitHub {
            owner = "reledia";
            repo = "glow.yazi";
            rev = "536185a4e60ac0adc11d238881e78678fdf084ff";
            hash = "sha256-NcMbYjek99XgWFlebU+8jv338Vk1hm5+oW5gwH+3ZbI=";
          };

          hexyl = fetchFromGitHub {
            owner = "reledia";
            repo = "hexyl.yazi";
            rev = "64daf93a67d75eff871befe52d9013687171ffad";
            hash = "sha256-B2L3/Q1g0NOO6XEMIMGBC/wItbNgBVpbaMMhiXOYcrI=";
          };

          miller = fetchFromGitHub {
            owner = "reledia";
            repo = "miller.yazi";
            rev = "75f00026a0425009edb6fedcfbe893f3d2ddedf4";
            hash = "sha256-u8xadj6/s16xXUAWGezYBqnygKaFMnRUsqtjMDr6DZA=";
          };

          ouch = fetchFromGitHub {
            owner = "ndtoan96";
            repo = "ouch.yazi";
            rev = "251da6930ca8b7ee0384810086c3bf644caede3e";
            hash = "sha256-yLt9aY6hUIOdBI5bMdCs7VYFJGyD3WIkmPxvWKNCskA=";
          };

          torrent-preview = fetchFromGitHub {
            owner = "kirasok";
            repo = "torrent-preview.yazi";
            rev = "76970b6f9d6f3031e9cd57c8595a53e9f9f48c18";
            hash = "sha256-QPdtoCU7CyS7sx1aoGHNHv1NxWMA/SxSuy+2SLDdCeU=";
          };
          #^ Previewers
        };

    settings = {
      manager = {
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
