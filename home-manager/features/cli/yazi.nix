{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = false;
    keymap = {
      manager.prepend_keymap = [
        {
          on = [ "<C-s>" ];
          run = ''shell "$SHELL" --block --confirm'';
          desc = "Open shell here";
        }
        # {
        #   on = [ "F" ];
        #   run = "plugin smart-filter";
        #   desc = "Smart filter";
        # }
        {
          on = [ "p" ];
          run = "plugin --sync smart-paste";
          desc = "Paste into the hovered directory or CWD";
        }
        {
          on = [ "<C-n>" ];
          run = ''shell 'ripdrag "$@" -x 2>/dev/null &' --confirm'';
          desc = "Drag and drop into the hovered directory or CWD";
        }
        {
          on = [ "y" ];
          run = [
            "yank"
            '' shell --confirm 'echo "$@" | xclip -i -selection clipboard -t text/uri-list' ''
          ];
          desc = "Copy selected paths and files to clipboard";
        }
        # {
        #   on = [ "i" ];
        #   run = "plugin keyjump";
        #   desc = "Keyjump (Normal mode)";
        # }
        {
          on = [ "f"  "g" ];
          run = "plugin fg";
          desc = "find file by content (fuzzy match)";
        }
        {
          on = [ "f"  "G" ];
          run = "plugin fg --args='rg'";
          desc = "find file by content (ripgrep match)";
        }
        {
          on = [ "f"  "f" ];
          run = "plugin fg --args='fzf'";
          desc = "find file by file name";
        }
        # {
        #   on = [ "u"  "a" ];
        #   run = "plugin yamb --args=save";
        #   desc = "Add bookmark";
        # }
        # {
        #   on = [ "u"  "g" ];
        #   run = "plugin yamb --args=jump_by_key";
        #   desc = "Jump to a bookmark by key";
        # }
        # {
        #   on = [ "u"  "G" ];
        #   run = "plugin yamb --args=jump_by_fzf";
        #   desc = "Jump to a bookmark by fzf";
        # }
        # {
        #   on = [ "u"  "d" ];
        #   run = "plugin yamb --args=delete_by_key";
        #   desc = "Delete a bookmark by key";
        # }
        # {
        #   on = [ "u"  "D" ];
        #   run = "plugin yamb --args=delete_by_fzf";
        #   desc = "Delete a bookmark by fzf";
        # }
        # {
        #   on = [ "u"  "A" ];
        #   run = "plugin yamb --args=delete_all";
        #   desc = "Delete all bookmarks";
        # }
        # {
        #   on = [ "l" ];
        #   run = "plugin --sync fast-enter";
        #   desc = "Enter the subfolder faster, or open the file directly";
        # }
      ];
    };
    plugins = {
      allmytoes = pkgs.fetchFromGitLab {
        owner = "allmytoes";
        repo = "allmytoes";
        rev = "a4ab6b23de491bfea2c889907e5ba41216b3dde9";
        hash = "sha256-5GKscLo0MRSeWnVJc3aU/VdDxQGeg3P/+WKwkTNnqGc=";
      };
      # TODO: yazi 0.26+
      #
      # fast-enter = pkgs.fetchFromGitHub {
      #   owner = "ourongxing";
      #   repo = "fast-enter.yazi";
      #   rev = "2864c5998d89ad4ff6b17d6f758b7690a69cda47";
      #   hash = "sha256-WIgWh1QRGC0IWvFJ1fTBw8c6m6DfxjbCH9WC3zBte1s=";
      # };
      fg = pkgs.fetchFromGitHub {
        owner = "DreamMaoMao";
        repo = "fg.yazi";
        rev = "f7d41ae71249515763d9ee04ddf4bdc3b0b42f55";
        hash = "sha256-6LpnyXB7mri6aVEfnv6aG2mWlzpvaD8SiMqwUS+jJr0=";
      };
      glow = pkgs.fetchFromGitHub {
        owner = "Reledia";
        repo = "glow.yazi";
        rev = "536185a4e60ac0adc11d238881e78678fdf084ff";
        hash = "sha256-NcMbYjek99XgWFlebU+8jv338Vk1hm5+oW5gwH+3ZbI=";
      };
      hexyl = pkgs.fetchFromGitHub {
        owner = "Reledia";
        repo = "hexyl.yazi";
        rev = "64daf93a67d75eff871befe52d9013687171ffad";
        hash = "sha256-B2L3/Q1g0NOO6XEMIMGBC/wItbNgBVpbaMMhiXOYcrI=";
      };
      # TODO: after yazi 0.26+:
      # - https://github.com/DreamMaoMao/searchjump.yazi
      # - https://github.com/yazi-rs/plugins/tree/main/jump-to-char.yazi
      #
      # keyjump = pkgs.fetchFromGitHub {
      #   owner = "DreamMaoMao";
      #   repo = "keyjump.yazi";
      #   rev = "c0c22184dff798be1cf4940ac74c590707a03ad6";
      #   hash = "sha256-FHvhyD9PAiglL03SbuJdRaZ36FzjIDpIHrKt2PFvAQI=";
      # };
      miller = pkgs.fetchFromGitHub {
        owner = "Reledia";
        repo = "miller.yazi";
        rev = "75f00026a0425009edb6fedcfbe893f3d2ddedf4";
        hash = "sha256-u8xadj6/s16xXUAWGezYBqnygKaFMnRUsqtjMDr6DZA=";
      };
      ouch = pkgs.fetchFromGitHub {
        owner = "ndtoan96";
        repo = "ouch.yazi";
        rev = "694d149be5f96eaa0af68d677c17d11d2017c976";
        hash = "sha256-J3vR9q4xHjJt56nlfd+c8FrmMVvLO78GiwSNcLkM4OU=";
      };
      # TODO: after yazi 0.26:
      #
      # smart-filter = pkgs.fetchFromGitHub {
      #   owner = "yazi-rs";
      #   repo = "plugins/smart-filter.yazi";
      #   rev = "ff84ac3d42eb5c9e0d05aabf44852c062e9440ee";
      #   hash = "sha256-smartxfilterAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      # };
      # TODO: after yazi 0.26:
      #
      # yamb = pkgs.fetchFromGitHub {
      #   owner = "h-hg";
      #   repo = "yamb.yazi";
      #   rev = "3636c80f94448347f8047cfbfc1ca6099dcd4d71";
      #   hash = "sha256-81rrxjdWlpICQ12EfOcvXpvnWXeWgA5GYBfoHXxBe1g=";
      # };
    };
    settings = {
      plugin = {
        preloaders = [
          { mime = "image/vnd.djvu"; run = "noop"; }
          { mime = "image/*"; run = "allmytoes"; }
          { mime = "video/*"; run = "video"; }
          { mime = "application/pdf"; run = "pdf"; }
          # TODO: yazi 0.26+
          # {
          #   name = "*";
          #   cond = "!mime";
          #   run = "mime";
          #   multi = true;
          #   prio = "high";
          # }
        ];
        previewers = [
          { name = "*/"; run = "folder"; sync = true; }
          { mime = "text/*"; run = "code"; }
          { mime = "*/xml"; run = "code"; }
          { mime = "*/javascript"; run = "code"; }
          { mime = "*/x-wine-extension-ini"; run = "code"; }
          { mime = "application/json"; run = "json"; }
          { mime = "image/vnd.djvu"; run = "noop"; }
          { mime = "image/*"; run = "allmytoes"; }
          { mime = "video/*"; run = "video"; }
          { mime = "application/pdf"; run = "pdf"; }
          { mime = "application/*zip"; run = "ouch"; }
          { mime = "application/x-tar"; run = "ouch"; }
          { mime = "application/x-bzip"; run = "ouch"; }
          { mime = "application/x-bzip2"; run = "ouch"; }
          { mime = "application/x-7z-compressed"; run = "ouch"; }
          { mime = "application/x-rar"; run = "ouch"; }
          { mime = "application/x-xz"; run = "ouch"; }
          { mime = "text/csv"; run = "miller"; }
          { mime = "audio/*"; run = "exifaudio"; }
          { name = "*.md"; run = "glow"; }
          { name = "*"; run = "hexyl"; }
        ];
      };
    };
  };
}
