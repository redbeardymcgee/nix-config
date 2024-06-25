{ pkgs, ... }: {
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = false;
      daemon = {
        enabled = false;
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

  # systemd.user.services.atuind = {
  #   enable = false;
  #   Install = {
  #     WantedBy = [ "default.target" ];
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.atuin}/bin/atuin daemon";
  #     Environment = [ ''ATUIN_LOG="info"'' ];
  #     Restart = "on-failure";
  #     Type = "exec";
  #   };
  #   Unit = {
  #     Description = "Atuin shell history manager daemon";
  #   };
  # };
}
