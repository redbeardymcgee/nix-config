{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  home = {
    homeDirectory = "/var/home/josh";
    sessionPath = [
      "$HOME/.local/lib/node_modules/bin"
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER="sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT="-c";
      NODE_PATH = "~/.local/lib/node_modules";
      VISUAL = "nvim";
    };
    packages = with pkgs; [
      curlie
      difftastic
      dogdns
      entr
      gping
      grex
      gtrash
      hexyl
      lazydocker
      miller
      neovim
      nerdfonts
      nmap
      nodejs
      ouch
      procs
      python3
      python311Packages.libtmux
      racket
      ripdrag
      rustup
      yq
    ];
    stateVersion = "24.05";
    username = "josh";
  };

  programs = {
    atuin = {
      enable = true;
      settings = {
        auto_sync = false;
        daemon = {
          enabled = true;
          sync_frequency = 120;
          systemd_socket = true;
        };
        enter_accept = true;
        filter_mode_shell_up_key_binding = "directory";
        stats = {
          common_subcommands = [
            "apt"
            "cargo"
            "chezmoi"
            "composer"
            "distrobox"
            "dnf"
            "docker"
            "git"
            "go"
            "ip"
            "kubectl"
            "nix"
            "nmcli"
            "npm"
            "npx"
            "pecl"
            "pnpm"
            "podman"
            "port"
            "systemctl"
            "tmux"
            "yarn"
          ];
          ignored_commands = [
            "cd"
            "ls"
            "vi"
            "vim"
          ];
        };
        update_check = false;
        workspaces = true;
      };
    };
    bash = {
      enable = true;
      bashrcExtra = ''
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
    bat = {
      enable = true;
      config = {
        map-syntax = [
          ".ignore:Git Ignore"
        ];
      };
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batgrep
        batman
        batpipe
        batwatch
        prettybat
      ];
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = {
        global = {
          disable_stdin = true;
          hide_env_diff = true;
          strict_env = true;
        };
      };
    };
    eza = {
      enable = true;
      icons = true;
      git = true;
      extraOptions = [
        "--all"
        "--extended"
        "--group-directories-first"
        "--header"
        "--links"
        "--inode"
        "--modified"
        "--mounts"
        "--smart-group"
        "--total-size"
      ];
    };
    fastfetch.enable = true;
    fd = {
      enable = true;
      ignores = [
        ".git/"
        "*.bak"
      ];
    };
    fish = {
      enable = true;
      functions = {
        yy = {
          body = ''
            set tmp (mktemp -p $XDG_RUNTIME_DIR yazi-cwd.XXXXXX)
            yazi $argv --cwd-file=$tmp
            if set cwd (cat -- $tmp); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
              cd "$cwd"
            end
          '';
          wraps = "yazi";
        };
      };
      interactiveShellInit = ''
        set -U fish_greeting
      '';
      shellAbbrs = {
          gp = "gtrash put";
          rm = "gtrash put";
          vim = "nvim";
      };
      shellAliases = {
        dps = ''
          docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Networks}}\t{{.State}}\t{{.CreatedAt}}"
        '';
      };
    };
    fzf = {
      enable = true;
      changeDirWidgetCommand = "fd --type d";
      defaultCommand = "fd --type f";
      fileWidgetCommand = "fd --type f";
      fileWidgetOptions = [
        "--preview 'head {}'"
      ];
      historyWidgetOptions = [
        "--sort"
        "--exact"
      ];
      tmux = {
        enableShellIntegration = true;
      };
    };
    git = {
      enable = true;
      aliases = {
        co = "checkout";
        dlog = "log -p --ext-diff";
      };
      difftastic.enable = true;
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        pull = {
          ff = "only";
        };
        color = {
          ui = true;
        };
        merge = {
          conflictstyle = "diff3";
        };
        pager = {
          colorMoved = "default";
        };
      };
      ignores = [
        "*~"
        "*.swp"
        "*.bak"
      ];
      userName = "redbeardymcgee";
      userEmail = "redbeardymcgee@gmail.com";
    };
    gitui = {
      enable = true;
      keyConfig = ''
        (
          open_help: Some(( code: F(1), modifiers: "")),

          move_left: Some(( code: Char('h'), modifiers: "")),
          move_right: Some(( code: Char('l'), modifiers: "")),
          move_up: Some(( code: Char('k'), modifiers: "")),
          move_down: Some(( code: Char('j'), modifiers: "")),

          popup_up: Some(( code: Char('p'), modifiers: "CONTROL")),
          popup_down: Some(( code: Char('n'), modifiers: "CONTROL")),
          page_up: Some(( code: Char('b'), modifiers: "CONTROL")),
          page_down: Some(( code: Char('f'), modifiers: "CONTROL")),
          home: Some(( code: Char('g'), modifiers: "")),
          end: Some(( code: Char('G'), modifiers: "SHIFT")),
          shift_up: Some(( code: Char('K'), modifiers: "SHIFT")),
          shift_down: Some(( code: Char('J'), modifiers: "SHIFT")),

          edit_file: Some(( code: Char('I'), modifiers: "SHIFT")),

          status_reset_item: Some(( code: Char('U'), modifiers: "SHIFT")),

          diff_reset_lines: Some(( code: Char('u'), modifiers: "")),
          diff_stage_lines: Some(( code: Char('s'), modifiers: "")),

          stashing_save: Some(( code: Char('w'), modifiers: "")),
          stashing_toggle_index: Some(( code: Char('m'), modifiers: "")),

          stash_open: Some(( code: Char('l'), modifiers: "")),

          abort_merge: Some(( code: Char('M'), modifiers: "SHIFT")),
        )
      '';
    };
    go.enable = true;
    home-manager.enable = true;
    htop = {
      enable = true;
      settings = {
        color_scheme = 6;
        cpu_count_from_one = 0;
        delay = 15;
        fields = with config.lib.htop.fields; [
          PID
          USER
          PRIORITY
          NICE
          M_SIZE
          M_RESIDENT
          M_SHARE
          STATE
          PERCENT_CPU
          PERCENT_MEM
          TIME
          COMM
        ];
        highlight_base_name = 1;
        highlight_megabytes = 1;
        highlight_threads = 1;
      } // (with config.lib.htop; leftMeters [
        (bar "AllCPUs2")
        (bar "Memory")
        (bar "Swap")
        (text "Zram")
      ]) // (with config.lib.htop; rightMeters [
        (text "Tasks")
        (text "LoadAverage")
        (text "Uptime")
        (text "Systemd")
      ]);
    };
    jq.enable = true;
    less.enable = true;
    man.enable = true;
    nix-index.enable = true;
    ripgrep = {
      enable = true;
      arguments = [
        "--glob=!.git/*"
        "--max-columns=120"
        "--max-columns-preview"
        "smart-case"
      ];
    };
    ssh = {
      enable = true;
      forwardAgent = true;
      addKeysToAgent = "yes";
      compression = true;
      extraConfig = ''
        Host *
          User josh

        Host mcgeedia
          Hostname media.mcgee.network
          IdentityFile ~/.ssh/rbmpc-to-mcgeedia

        Host proxmox
          Hostname 10.35.20.11
          IdentityFile ~/.ssh/rbmpc-to-proxmox
          ProxyJump josh@mcgeedia

        Host nixedia
          Hostname 10.35.20.142
          IdentityFile ~/.ssh/rbmpc-to-nixedia
          ProxyJump josh@mcgeedia
      '';
    };
    starship = {
      enable = true;
      enableTransience = true;
      settings = {
        format = lib.concatStrings [
          "\${custom.yazi}"
          "$character"
        ];
        right_format = lib.concatStrings [
          "$all"
        ];
        custom.yazi = {
          description = "Indicate when the shell was launched by `yazi`";
          symbol = " ";
          when = ''test -n "$YAZI_LEVEL"'';
        };
      };
    };
    tealdeer = {
      enable = true;
      settings = {
        display = {
            compact = true;
            use_pager = true;
        };
        updates.auto_update = true;
      };
    };
    tmux = {
      enable = true;
      baseIndex = 1;
      disableConfirmationPrompt = true;
      escapeTime = 0;
      extraConfig = ''
        set -g @plugin 'b0o/tmux-autoreload'
        set -g @plugin 'sunaku/tmux-navigate'
        set -g @plugin 'joshmedeski/tmux-nerd-font-window-name'

        set -g @plugin 'rickstaa/tmux-notify'
        set -g @tnotify-prompt-suffixes '❯'
        set -g @tnotify-verbose 'on'

        set -g @plugin 'jaclu/tmux-power-zoom'

        set -g @plugin 'omerxx/tmux-sessionx'

        set -g @sessionx-additional-options '--tmux center'
        set -g @sessionx-tree-mode 'on'
        set -g @sessionx-window-mode 'on'
        set -g @sessionx-zoxide-mode 'on'

        set -g status-position 'top'

        set -g @plugin 'tmux-plugins/tpm'
        if "test ! -d ~/.config/tmux/plugins/tpm" \
          "run 'git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm && ~/.config/tmux/plugins/tpm/bin/install_plugins'"
        run '~/.config/tmux/plugins/tpm/tpm'
      '';
      historyLimit = 10000;
      mouse = true;
      newSession = true;
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '60'
          '';
        }
        copy-toolkit
        mode-indicator
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-processes 'ssh'
          '';
        }
        {
          plugin = tilish;
          extraConfig = ''
            set -g @tilish-dmenu 'on'
          '';
        }
        yank
      ];
      prefix = "C-a";
      terminal = "tmux-256color";
    };
    yazi = {
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
    zk = {
      enable = true;
      settings = {
        alias = {
          last = "zk edit --limit 1 --sort modified- $@";
          recent = "zk edit --sort created- --created-after 'last two weeks' --interactive";
          lucky = "zk list --quiet --format full --sort random --limit 1";
        };
        extra.author = "rbm";
        lsp = {
          diagnostics = {
            wiki-title = "hint";
            dead-link = "error";
          };
          completion = {
            note-label = "{{title-or-path}}";
            note-filter-text = "{{title}} {{path}}";
            note-detail = "{{filename-stem}}";
          };
        };
        notebook.dir = "~/Documents/Notebook";
        note = {
          default-title = "Untitled";
          filename = "{{id}}-{{slug title}}";
          extension = "md";
        };
        tool = {
          fzf-preview = "bat -p --color always {-1}";
        };
        filter = {
          recents = "--sort created- --created-after 'last two weeks'";
        };
        format.markdown = {
          hashtags = true;
          colon-tags = true;
        };
      };
    };
    zoxide = {
      enable = true;
      options = [ "--cmd" "cd" ];
    };
  };

  services = {
    home-manager.autoUpgrade = {
      enable = true;
      frequency = "weekly";
    };
    ssh-agent.enable = true;
  };

  systemd.user.startServices = "sd-switch";

  targets.genericLinux.enable = true;

  xdg = {
    enable = true;
    # mimeApps.enable = true;
    # portal.enable = true;
  };
}
