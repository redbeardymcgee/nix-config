{lib, ...}: {
  programs.starship = {
    enable = true;
    enableTransience = true;
    settings = {
      format = lib.concatStrings [
        ''''${custom.yazi} ''
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
      aws = {
        format = " aws [$symbol $profile $region]($style)";
        style = "italic blue";
        symbol = " ";
      };
      buf = {
        symbol = " ";
        format = " buf [$symbol $version $buf_version]($style)";
      };
      c = {
        symbol = " ";
        format = " c [$symbol($version(-$name))]($style)";
      };
      character = {
        format = "$symbol ";
        success_symbol = "[◉](bold italic bright-yellow)";
        error_symbol = "[⊘](italic purple)";
      };
      cmd_duration = {
        min_time = 500;
        format = "[$duration ](italic bright-yellow)";
      };
      conda = {
        symbol = " ";
        format = " conda [$symbol$environment]($style)";
      };
      crystal = {
        symbol = " ";
      };
      dart = {
        symbol = " ";
        format = " dart [$symbol($version )]($style)";
      };
      deno = {
        format = " deno [∫ $version](blue italic)";
        version_format = "$major.$minor";
      };
      directory = {
        home_symbol = "⌂";
        truncation_length = 2;
        truncation_symbol = "▦ ";
        read_only = " 󰌾";
        style = "italic blue";
        format = " [$path]($style)[$read_only]($read_only_style)";
      };
      docker_context = {
        symbol = " ";
        format = " docker [$symbol$context]($style)";
      };
      elixir = {
        symbol = " ";
        format = " exs [$symbol $version OTP $otp_version ]($style)";
      };
      elm = {
        symbol = " ";
        format = " elm [$symbol($version )]($style)";
      };
      env_var.VIMSHELL = {
        # vim subshell
        format = "[$env_value]($style)";
        style = "green italic";
      };
      fennel = {
        symbol = " ";
      };
      fossil_branch = {
        symbol = " ";
      };
      git_branch = {
        format = "[ $symbol $branch(:$remote_branch)]($style)";
        symbol = "[](bold bright-blue)";
        style = "bold italic bright-blue";
      };
      git_status = {
        style = "italic bright-blue";
        format = "([⎪$ahead_behind$staged$modified$untracked$renamed$deleted$conflicted$stashed⎥]($style))";
        conflicted = "[◪◦](italic bright-magenta)";
        ahead = "[▲│[$count](bold white)│](italic green)";
        behind = "[▽│[$count](bold white)│](italic red)";
        diverged = "[◇ ▲┤[$ahead_count](regular white)│▽┤[$behind_count](regular white)│](italic bright-magenta)";
        untracked = "[◌◦](italic bright-yellow)";
        stashed = "[◦◫◦](italic white)";
        modified = "[●◦](italic yellow)";
        staged = "[■┤[$count](bold white)│](italic bright-cyan)";
        renamed = "[◎◦](italic bright-blue)";
        deleted = "[✕](italic red)";
      };
      golang = {
        symbol = " ";
        format = " go [$symbol($version )]($style)";
      };
      guix_shell = {
        symbol = " ";
      };
      haskell = {
        symbol = " ";
        format = " hs [$symbol($version )]($style)";
      };
      haxe = {
        symbol = " ";
      };
      hg_branch = {
        symbol = " ";
      };
      hostname = {
        ssh_symbol = " ";
      };
      java = {
        symbol = " ";
        format = " java [$symbol($version )]($style)";
      };
      jobs = {
        format = "[ $symbol$number]($style)";
        style = "white";
        symbol = "[▶ ](blue italic)";
      };
      julia = {
        symbol = " ";
        format = " jl [$symbol($version )]($style)";
      };
      kotlin = {
        symbol = " ";
      };
      localip = {
        ssh_only = true;
        format = " ◯[$localipv4](bold magenta)";
      };
      lua = {
        format = " lua [$symbol$version]($style)";
        symbol = " ";
        style = "italic bright-yellow";
      };
      memory_usage = {
        symbol = "󰍛 ";
        format = " mem [$ram( $swap)]($style)";
      };
      meson = {
        symbol = "󰔷 ";
      };
      nodejs = {
        format = " node [◫ ($version)](italic bright-green)";
        detect_files = ["package-lock.json" "yarn.lock"];
        version_format = "$major.$minor";
        symbol = " ";
      };
      nim = {
        symbol = "󰆥 ";
        format = " nim [$symbol($version )]($style)";
      };
      nix_shell = {
        symbol = " ";
        format = " nix [$symbol$state $name]($style)";
      };
      ocaml = {
        symbol = " ";
      };
      os.symbols = {
        Alpaquita = " ";
        Alpine = " ";
        AlmaLinux = " ";
        Amazon = " ";
        Android = " ";
        Arch = " ";
        Artix = " ";
        CentOS = " ";
        Debian = " ";
        DragonFly = " ";
        Emscripten = " ";
        EndeavourOS = " ";
        Fedora = " ";
        FreeBSD = " ";
        Garuda = "󰛓 ";
        Gentoo = " ";
        HardenedBSD = "󰞌 ";
        Illumos = "󰈸 ";
        Kali = " ";
        Linux = " ";
        Mabox = " ";
        Macos = " ";
        Manjaro = " ";
        Mariner = " ";
        MidnightBSD = " ";
        Mint = " ";
        NetBSD = " ";
        NixOS = " ";
        OpenBSD = "󰈺 ";
        openSUSE = " ";
        OracleLinux = "󰌷 ";
        Pop = " ";
        Raspbian = " ";
        Redhat = " ";
        RedHatEnterprise = " ";
        RockyLinux = " ";
        Redox = "󰀘 ";
        Solus = "󰠳 ";
        SUSE = " ";
        Ubuntu = " ";
        Unknown = " ";
        Void = " ";
        Windows = "󰍲 ";
      };
      package = {
        format = " pkg [$symbol$version]($style)";
        version_format = "$major.$minor";
        symbol = "󰏗 ";
        style = "bright-yellow italic";
      };
      perl = {
        symbol = " ";
      };
      php = {
        symbol = " ";
      };
      pijul_channel = {
        symbol = " ";
      };
      python = {
        format = " py [$symbol$version]($style)";
        symbol = "[](italic bright-blue)⌊ ";
        version_format = "$major.$minor";
        style = "italic bright-yellow";
      };
      rlang = {
        symbol = "󰟔 ";
      };
      ruby = {
        format = " rb [$symbol$version]($style)";
        symbol = " ";
        version_format = "$major.$minor";
        style = "italic red";
      };
      rust = {
        format = " rs [$symbol$version]($style)";
        symbol = " ";
        version_format = "$major.$minor";
        style = "italic red";
      };
      scala = {
        symbol = " ";
      };
      shell = {
        bash_indicator = " 󱆃";
        fish_indicator = " ";
        zsh_indicator = " ";
      };
      spack = {
        symbol = "◇ ";
        format = " spack [$symbol$environment]($style)";
      };
      swift = {
        format = " sw [$symbol$version]($style)";
        symbol = " ";
        style = "italic bright-red";
        version_format = "$major.$minor";
      };
      sudo = {
        format = "[$symbol]($style)";
        style = "italic bright-purple";
        symbol = "◇┈";
      };
      time = {
        format = "[ $time]($style)";
        time_format = "%R";
        utc_time_offset = "local";
        style = "dimmed white";
      };
      username = {
        style_user = "yellow bold";
        style_root = "purple bold italic";
        format = "[$user]($style) ▻ ";
      };
      zig = {
        symbol = " ";
      };
    };
  };
}
