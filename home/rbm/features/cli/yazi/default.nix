{
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
          run = "plugin chmod ";
          desc = "Chmod on selected files";
        }
        {
          on = ["<C-d>"];
          run = "plugin diff ";
          desc = "Diff the selected with the hovered file";
        }
        {
          on = ["F"];
          run = "plugin smart-filter";
          desc = "Smart filter";
        }
        {
          on = ["p"];
          run = "plugin --sync smart-paste";
          desc = "Paste into the hovered directory or CWD";
        }
        {
          on = ["<C-n>"];
          run = ''shell 'ripdrag "$@" -x 2>/dev/null &' --confirm'';
          desc = "Drag and drop into the hovered directory or CWD";
        }
        {
          on = ["y"];
          run = [
            "yank"
            ''shell --confirm 'printf %s\\n "file://$@"| wl-copy -t text/uri-list' ''
          ];
          desc = "Copy selected paths and files to clipboard";
        }
        {
          on = ["i"];
          run = "plugin searchjump";
          desc = "searchjump mode";
        }
        {
          on = ["f" "g"];
          run = "plugin fg";
          desc = "find file by content (fuzzy match)";
        }
        {
          on = ["f" "G"];
          run = "plugin fg --args='rg'";
          desc = "find file by content (ripgrep match)";
        }
        {
          on = ["f" "f"];
          run = "plugin fg --args='fzf'";
          desc = "find file by file name";
        }
        {
          on = ["u" "a"];
          run = "plugin yamb --args=save";
          desc = "Add bookmark";
        }
        {
          on = ["u" "g"];
          run = "plugin yamb --args=jump_by_key";
          desc = "Jump to a bookmark by key";
        }
        {
          on = ["u" "G"];
          run = "plugin yamb --args=jump_by_fzf";
          desc = "Jump to a bookmark by fzf";
        }
        {
          on = ["u" "d"];
          run = "plugin yamb --args=delete_by_key";
          desc = "Delete a bookmark by key";
        }
        {
          on = ["u" "D"];
          run = "plugin yamb --args=delete_by_fzf";
          desc = "Delete a bookmark by fzf";
        }
        {
          on = ["u" "A"];
          run = "plugin yamb --args=delete_all";
          desc = "Delete all bookmarks";
        }
        {
          on = ["u" "r"];
          run = "plugin yamb --args=rename_by_key";
          desc = "Delete all bookmarks";
        }
        {
          on = ["u" "R"];
          run = "plugin yamb --args=rename_by_fzf";
          desc = "Delete all bookmarks";
        }
        {
          on = ["T"];
          run = "plugin --sync hide-preview";
          desc = "Hide or show preview";
        }
        {
          on = ["t"];
          run = "plugin --sync max-preview";
          desc = "Maximize or restore preview";
        }
        {
          on = ["l"];
          run = "plugin --sync fast-enter";
          desc = "Enter the subfolder faster, or open the file directly";
        }
      ];
    };
    plugins = with pkgs; {
      allmytoes = fetchFromGitHub {
        owner = "Sonico98";
        repo = "allmytoes.yazi";
        rev = "e5329138a19615e63bff6a581eb69d1d1eb5d4fe";
        hash = "sha256-S9O8jgTjdOxf/Zybmgm7nGBkd2Ipt2DtQ+Be2uawyNA=";
      };

      # hide-preview = fetchgit {
      #   url = "https://github.com/yazi-rs/plugins.git";
      #   sparseCheckout = ["hide-preview.yazi"];
      #   rev = "5ac77e18de45f018b5602453acc03ebdd347f439";
      #   hash = "sha256-PyqtPOX87C644eHLOxIyDT+iO7hM1zzz8aZJkHuLyeY=";
      # };

      # max-preview = fetchgit {
      #   url = "https://github.com/yazi-rs/plugins.git";
      #   sparseCheckout = ["max-preview.yazi"];
      #   rev = "ab370f0696677bcdbdfd52c2515f81e033942d20";
      #   hash = "sha256-rPujZkToijj54xLCi/Ij9yMMK7iw13AyBe6RO1xgACA=";
      # };

      # diff = fetchgit {
      #   url = "https://github.com/yazi-rs/plugins.git";
      #   sparseCheckout = ["diff.yazi"];
      #   rev = "a6268cfd2f95e56c80018933dfecad60dea456a0";
      #   hash = "sha256-Kki4I6PheXL6MMoEGPKBM19ulsNIZsZXk02I2jSSOZE=";
      # };

      # chmod = fetchgit {
      #   url = "https://github.com/yazi-rs/plugins.git";
      #   sparseCheckout = ["chmod.yazi"];
      #   rev = "a882e3828cdeee243ede2bff0524cbe7e27104cf";
      #   hash = "sha256-jO/KQwT40Ax6quxdrty6Ynrh5qEW7K1ig1AleZjFP6s=";
      # };

      # full-border = fetchgit {
      #   url = "https://github.com/yazi-rs/plugins.git";
      #   sparseCheckout = ["full-border.yazi"];
      #   rev = "eaa682df64040813ff72e3f2f2b2f0c7306d0929";
      #   hash = "sha256-PyqtPOX87C644eHLOxIyDT+iO7hM1zzz8aZJkHuLyeY=";
      # };

      # smart-filter = fetchgit {
      #   url = "https://github.com/yazi-rs/plugins.git";
      #   sparseCheckout = ["smart-filter.yazi"];
      #   rev = "ff84ac3d42eb5c9e0d05aabf44852c062e9440ee";
      #   hash = "sha256-TCQDg4dHfpjo0BghxVf2E11GNT8SsC69x5YBUglRp/4=";
      # };

      fast-enter = fetchFromGitHub {
        owner = "ourongxing";
        repo = "fast-enter.yazi";
        rev = "2864c5998d89ad4ff6b17d6f758b7690a69cda47";
        hash = "sha256-WIgWh1QRGC0IWvFJ1fTBw8c6m6DfxjbCH9WC3zBte1s=";
      };

      fg = fetchFromGitHub {
        owner = "DreamMaoMao";
        repo = "fg.yazi";
        rev = "f7d41ae71249515763d9ee04ddf4bdc3b0b42f55";
        hash = "sha256-6LpnyXB7mri6aVEfnv6aG2mWlzpvaD8SiMqwUS+jJr0=";
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

      searchjump = fetchFromGitHub {
        owner = "DreamMaoMao";
        repo = "searchjump.yazi";
        rev = "fd94cbe9d603430db950532ad8139710c5dfb167";
        hash = "sha256-pTYH03OtzRBpjWDZTXdUzUnvfmDSgmN8v3mk+TjD4cI=";
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
