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
        rev = "02d18be03812415097e83c6a912924560e4cec6d";
        hash = "sha256-FM2kb+Lw4TYAG32mExV9TBc4MrB1zF3Fcdwt11GQjc0=";
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
            rev = "7c20850de190afcc1b73dfbe0a2b481fbc65d5ad";
            hash = "sha256-aVb95MSX1kYqtNBebKfgGkHobw8knrpHHL6NeCkLPk4=";
          };
          allmytoes = fetchFromGitHub {
            owner = "sonico98";
            repo = "allmytoes.yazi";
            rev = "a9870513d935680c2d59da7d59b3f91660e2729d";
            hash = "sha256-ZV7WB5ylYzmC98ORP2Cb5aO6l6vwGEnYsZhHGSPQdIQ=";
          };
          exifaudio = fetchFromGitHub {
            owner = "sonico98";
            repo = "exifaudio.yazi";
            rev = "d7946141c87a23dcc6fb3b2730a287faf3154593";
            hash = "sha256-nXBxPG6PVi5vstvVMn8dtnelfCa329CTIOCdXruOxT4=";
          };
          glow = fetchFromGitHub {
            owner = "reledia";
            repo = "glow.yazi";
            rev = "5ce76dc92ddd0dcef36e76c0986919fda3db3cf5";
            hash = "sha256-UljcrXXO5DZbufRfavBkiNV3IGUNct31RxCujRzC9D4=";
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
            rev = "083d5647345c8d2119d50860aabca57d292ab672";
            hash = "sha256-zLAaJrcZGNWlG2HjsZtN4u8JZAN+GLl2RtP9qCt3T74=";
          };
          torrent-preview = fetchFromGitHub {
            owner = "kirasok";
            repo = "torrent-preview.yazi";
            rev = "169cafcb6f1b0aeef647c7598845e1e09651c3a8";
            hash = "sha256-taLlWoC57h8N8Yj2wD/dY+piVPgNk1F85+QIuJfQRoQ=";
          };
          yamb = fetchFromGitHub {
            owner = "h-hg";
            repo = "yamb.yazi";
            rev = "3f7c51fdccf3345485d54aedfabbca86fc7b0dca";
            hash = "sha256-/itu+xuqPqhe0Fh5JPPHA5ftzg1IqgrNZW0Lw2p3Vas=";
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
