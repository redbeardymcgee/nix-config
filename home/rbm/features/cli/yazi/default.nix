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
        rev = "ec97f8847feeb0307d240e7dc0f11d2d41ebd99d";
        hash = "sha256-U2mxevqEuix3UYI6q2cPqxXFKf9ruXzeRpgUhhjNVsY=";
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
            rev = "011489a2a881742c88aed235972031f7d8e572d0";
            hash = "sha256-cLqUp9V/a8agUPKONFEorMCYLzqmnKgtPAG9njRZi4Y=";
          };
          allmytoes = fetchFromGitHub {
            owner = "sonico98";
            repo = "allmytoes.yazi";
            rev = "e5329138a19615e63bff6a581eb69d1d1eb5d4fe";
            hash = "sha256-S9O8jgTjdOxf/Zybmgm7nGBkd2Ipt2DtQ+Be2uawyNA=";
          };
          exifaudio = fetchFromGitHub {
            owner = "sonico98";
            repo = "exifaudio.yazi";
            rev = "855ff055c11fb8f268b4c006a8bd59dd9bcf17a7";
            hash = "sha256-8f1iG9RTLrso4S9mHYcm3dLKWXd/WyRzZn6KNckmiCc=";
          };
          glow = fetchFromGitHub {
            owner = "reledia";
            repo = "glow.yazi";
            rev = "c2ed51ed8c4ba965b793adab5868a307ab375c8a";
            hash = "sha256-hY390F6/bkQ6qN2FZEn0k+j+XfaERJiAo/E3xXYRB70=";
          };
          hexyl = fetchFromGitHub {
            owner = "reledia";
            repo = "hexyl.yazi";
            rev = "39d3d4e23ad7cec8888f648ddf55af4386950ce7";
            hash = "sha256-nsnnL3GluKk/p1dQZTZ/RwQPlAmTBu9mQzHz1g7K0Ww=";
          };
          miller = fetchFromGitHub {
            owner = "reledia";
            repo = "miller.yazi";
            rev = "40e02654725a9902b689114537626207cbf23436";
            hash = "sha256-GXZZ/vI52rSw573hoMmspnuzFoBXDLcA0fqjF76CdnY=";
          };
          ouch = fetchFromGitHub {
            owner = "ndtoan96";
            repo = "ouch.yazi";
            rev = "db1488358941a2bc9918fa91c304d6724a0bb608";
            hash = "sha256-fEfsHEddL7bg4z85UDppspVGlfUJIa7g11BwjHbufrE=";
          };
          torrent-preview = fetchFromGitHub {
            owner = "kirasok";
            repo = "torrent-preview.yazi";
            rev = "76970b6f9d6f3031e9cd57c8595a53e9f9f48c18";
            hash = "sha256-QPdtoCU7CyS7sx1aoGHNHv1NxWMA/SxSuy+2SLDdCeU=";
          };
          yamb = fetchFromGitHub {
            owner = "h-hg";
            repo = "yamb.yazi";
            rev = "0598b8defc21ac7231e584115c3aa330f0310db4";
            hash = "sha256-Mw+CUyy8sN76NJNy+Xt0HwH6tD/gxqNvyIYKqpWUKMs=";
          };
          lazygit = fetchFromGitHub {
            owner = "Lil-Dank";
            repo = "lazygit.yazi";
            rev = "c82794fb410cca36b23b939d32126a6a9705f94d";
            hash = "sha256-m2zITkjGrUjaPnzHnnlwA6d4ODIpvlBfIO0RZCBfL0E=";
          };
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
