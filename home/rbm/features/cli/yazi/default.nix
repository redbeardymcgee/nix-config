{
  lib,
  inputs,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;

    package = inputs.yazi.packages.${pkgs.system}.default;
    enableFishIntegration = false;
    initLua = ./init.lua;

    keymap = {
      manager.prepend_keymap = [
        {
          on = ["<C-s>"];
          run = ''shell "$SHELL" --block --confirm'';
          desc = "Open shell here";
        }
        {
          on = ["c" "m"];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }
        {
          on = ["c" "D"];
          run = "plugin diff";
          desc = "Diff the selected with the hovered file";
        }
        {
          on = ["F"];
          run = "plugin smart-filter";
          desc = "Smart filter";
        }
        {
          on = ["p"];
          run = "plugin smart-paste --sync";
          desc = "Paste into the hovered directory or CWD";
        }
        {
          on = ["<C-d>"];
          run = ''shell 'ripdrag "$@" -x 2>/dev/null &' --confirm'';
          desc = "Drag and drop into the hovered directory or CWD";
        }
        {
          on = ["y"];
          run = [
            "yank"
            ''shell 'printf %s\\n "$@"| wl-copy -t text/uri-list' --confirm''
          ];
          desc = "Copy selected paths and files to clipboard";
        }
        {
          on = ["g" "s"];
          run = "plugin searchjump";
          desc = "searchjump mode";
        }
        {
          on = ["f" "g"];
          run = "plugin fg --args='rg'";
          desc = "find file by content (ripgrep match)";
        }
        {
          on = ["f" "f"];
          run = "plugin fg --args='fzf'";
          desc = "find file by file name";
        }
        {
          on = ["b" "a"];
          run = "plugin yamb --args=save";
          desc = "Add bookmark";
        }
        {
          on = ["b" "k"];
          run = "plugin yamb --args=jump_by_key";
          desc = "Jump to a bookmark by key";
        }
        {
          on = ["b" "b"];
          run = "plugin yamb --args=jump_by_fzf";
          desc = "Jump to a bookmark by fzf";
        }
        {
          on = ["b" "d"];
          run = "plugin yamb --args=delete_by_key";
          desc = "Delete a bookmark by key";
        }
        {
          on = ["b" "F"];
          run = "plugin yamb --args=delete_by_fzf";
          desc = "Delete a bookmark by fzf";
        }
        {
          on = ["b" "D"];
          run = "plugin yamb --args=delete_all";
          desc = "Delete all bookmarks";
        }
        {
          on = ["b" "r"];
          run = "plugin yamb --args=rename_by_key";
          desc = "Rename a bookmark by key";
        }
        {
          on = ["b" "R"];
          run = "plugin yamb --args=rename_by_fzf";
          desc = "Rename a bookmark by fzf";
        }
        {
          on = ["<C-t>"];
          run = "plugin hide-preview --sync";
          desc = "Hide or show preview";
        }
        {
          on = ["<C-T>"];
          run = "plugin max-preview --sync";
          desc = "Maximize or restore preview";
        }
        {
          on = ["l"];
          run = "plugin fast-enter --sync";
          desc = "Enter the subfolder faster, or open the file directly";
        }
      ];
    };

    plugins = let
      dreamMaoMaoPluginsNames = [
        "fg"
        "git-status"
        "searchjump"
      ];

      dreamMaoMaoPluginsSrc = pkgs.fetchgit {
        url = "https://github.com/redbeardymcgee/yazi-plugins";
        sparseCheckout = map (p: "${p}.yazi") dreamMaoMaoPluginsNames;
        rev = "7ef1d2d190f350e5f7dfa27b0c636695d2f02061";
        hash = "sha256-IENJrplkQz1q+3uLnb7EjPqkCtMd+YcUpwN4QiSjwQM=";
      };

      dreamMaoMaoPlugins = lib.lists.fold (a: b: {${a} = "${dreamMaoMaoPluginsSrc}/${a}.yazi";} // b) {} dreamMaoMaoPluginsNames;

      officialPluginsNames = [
        "chmod"
        "diff"
        "hide-preview"
        "full-border"
        "max-preview"
        "smart-filter"
      ];

      officialPluginsSrc = pkgs.fetchgit {
        url = "https://github.com/yazi-rs/plugins.git";
        sparseCheckout = map (p: "${p}.yazi") officialPluginsNames;
        rev = "eaa682df64040813ff72e3f2f2b2f0c7306d0929";
        hash = "sha256-01v1WEHKN1gjZF2rv3IRxem02DRy/M+cs25LxKNKPY4=";
      };

      officialPlugins = lib.lists.fold (a: b: {${a} = "${officialPluginsSrc}/${a}.yazi";} // b) {} officialPluginsNames;
    in
      with pkgs;
        officialPlugins
        // dreamMaoMaoPlugins
        // {
          allmytoes = fetchFromGitHub {
            owner = "Sonico98";
            repo = "allmytoes.yazi";
            rev = "e5329138a19615e63bff6a581eb69d1d1eb5d4fe";
            hash = "sha256-S9O8jgTjdOxf/Zybmgm7nGBkd2Ipt2DtQ+Be2uawyNA=";
          };

          fast-enter = fetchFromGitHub {
            owner = "ourongxing";
            repo = "fast-enter.yazi";
            rev = "2864c5998d89ad4ff6b17d6f758b7690a69cda47";
            hash = "sha256-WIgWh1QRGC0IWvFJ1fTBw8c6m6DfxjbCH9WC3zBte1s=";
          };

          glow = fetchFromGitHub {
            owner = "Reledia";
            repo = "glow.yazi";
            rev = "536185a4e60ac0adc11d238881e78678fdf084ff";
            hash = "sha256-NcMbYjek99XgWFlebU+8jv338Vk1hm5+oW5gwH+3ZbI=";
          };

          hexyl = fetchFromGitHub {
            owner = "Reledia";
            repo = "hexyl.yazi";
            rev = "64daf93a67d75eff871befe52d9013687171ffad";
            hash = "sha256-B2L3/Q1g0NOO6XEMIMGBC/wItbNgBVpbaMMhiXOYcrI=";
          };

          torrent-preview = fetchFromGitHub {
            owner = "kirasok";
            repo = "torrent-preview.yazi";
            rev = "76970b6f9d6f3031e9cd57c8595a53e9f9f48c18";
            hash = "sha256-QPdtoCU7CyS7sx1aoGHNHv1NxWMA/SxSuy+2SLDdCeU=";
          };

          exifaudio = fetchFromGitHub {
            owner = "Sonico98";
            repo = "exifaudio.yazi";
            rev = "94329ead8b3a6d3faa2d4975930a3d0378980c7a";
            hash = "sha256-jz6fVtcLHw9lsxFWECbuxE7tEBttE08Fl4oJSTifaEc=";
          };

          miller = fetchFromGitHub {
            owner = "Reledia";
            repo = "miller.yazi";
            rev = "75f00026a0425009edb6fedcfbe893f3d2ddedf4";
            hash = "sha256-u8xadj6/s16xXUAWGezYBqnygKaFMnRUsqtjMDr6DZA=";
          };

          ouch = fetchFromGitHub {
            owner = "ndtoan96";
            repo = "ouch.yazi";
            rev = "694d149be5f96eaa0af68d677c17d11d2017c976";
            hash = "sha256-J3vR9q4xHjJt56nlfd+c8FrmMVvLO78GiwSNcLkM4OU=";
          };

          starship = fetchFromGitHub {
            owner = "Rolv-Apneseth";
            repo = "starship.yazi";
            rev = "6197e4cca4caed0121654079151632f6abcdcae9";
            hash = "sha256-oHoBq7BESjGeKsaBnDt0TXV78ggGCdYndLpcwwQ8Zts=";
          };

          yamb = fetchFromGitHub {
            owner = "h-hg";
            repo = "yamb.yazi";
            rev = "3636c80f94448347f8047cfbfc1ca6099dcd4d71";
            hash = "sha256-81rrxjdWlpICQ12EfOcvXpvnWXeWgA5GYBfoHXxBe1g=";
          };
        };

    settings = {
      plugin = {
        fetchers = [
          {
            id = "git-status";
            name = "*";
            run = "git-status";
            prio = "normal";
          }
        ];

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

        append_previewers = [
          {
            name = "*";
            run = "hexyl";
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
      };
    };
  };
}
