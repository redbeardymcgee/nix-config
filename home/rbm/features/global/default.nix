{
  config,
  lib,
  outputs,
  pkgs,
  ...
}: {
  imports =
    [
      ./nixpkgs.nix
      ./xdg-user-dirs.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  news.display = "show";
  systemd.user.startServices = "sd-switch";

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/vnd.mozilla.xul+xml" = ["org.qutebrowser.qutebrowser.desktop"];
      "application/x-7z-compressed" = ["yazi.desktop"];
      # "application/x-bittorrent" = ["org.qutebrowser.qutebrowser.desktop"];
      "application/x-bzip2" = ["yazi.desktop"];
      "application/xhtml+xml" = ["org.qutebrowser.qutebrowser.desktop"];
      "application/x-qpwgraph-patchbay" = ["org.rncbc.qpwgraph.desktop"];
      # "application/x-rar" = ["org.qutebrowser.qutebrowser.desktop"];
      "application/x-shellscript" = ["redvim.desktop"];
      "application/x-tar" = ["yazi.desktop"];
      "application/x-xz" = ["yazi.desktop"];
      "application/*zip" = ["yazi.desktop"];
      # "audio/*" = ["org.qutebrowser.qutebrowser.desktop"];
      # "image/heic" = ["org.qutebrowser.qutebrowser.desktop"];
      "image/jpeg" = ["satty.desktop"];
      # "image/jxl" = ["org.qutebrowser.qutebrowser.desktop"];
      "image/png" = ["satty.desktop"];
      # "image/svg+xml" = ["org.qutebrowser.qutebrowser.desktop"];
      "inode/directory" = ["yazi.desktop"];
      # "text/csv" = ["org.qutebrowser.qutebrowser.desktop"];
      "text/english" = ["redvim.desktop"];
      "text/html" = ["org.qutebrowser.qutebrowser.desktop"];
      "text/plain" = ["redvim.desktop"];
      "text/x-c++hdr" = ["redvim.desktop"];
      "text/x-chdr" = ["redvim.desktop"];
      "text/x-c" = ["redvim.desktop"];
      "text/x-c++" = ["redvim.desktop"];
      "text/x-c++src" = ["redvim.desktop"];
      "text/x-csrc" = ["redvim.desktop"];
      "text/x-java" = ["redvim.desktop"];
      "text/x-makefile" = ["redvim.desktop"];
      "text/xml" = ["org.qutebrowser.qutebrowser.desktop"];
      "text/x-moc" = ["redvim.desktop"];
      "text/x-pascal" = ["redvim.desktop"];
      "text/x-tcl" = ["redvim.desktop"];
      "text/x-tex" = ["redvim.desktop"];
      "x-scheme-handler/http" = ["org.qutebrowser.qutebrowser.desktop"];
      "x-scheme-handler/https" = ["org.qutebrowser.qutebrowser.desktop"];
      # "x-scheme-handler/http" = ["firefox.desktop"];
      # "x-scheme-handler/https" = ["firefox.desktop"];
      "x-scheme-handler/matrix" = ["org.gnome.Fractal.desktop"];
    };
  };

  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  home = {
    stateVersion = lib.mkDefault "24.05";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    username = lib.mkDefault "rbm";
    preferXdgDirectories = true;

    packages = with pkgs; [
      (pkgs.nerdfonts.override {fonts = ["FiraCode"];})
      gcc
      pwvucontrol
      unzip
    ];

    sessionPath = [
      "$HOME/.local/lib/node_modules/bin"
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
    ];

    sessionVariables = {
      FLAKE = "/mnt/2tb/nix-config";
      EDITOR = "redvim";
      VISUAL = "redvim";
      NODE_PATH = "$HOME/.local/lib/node_modules";
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    };
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/horizon-terminal-dark.yaml";
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
        name = "FiraCode Nerd Font";
      };

      sizes = {
        applications = 13;
        terminal = 11;
        desktop = 14;
        popups = 14;
      };
    };

    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/qz/wallhaven-qzelxl.jpg";
      hash = "sha256-WVXnEV/SHMZ0idEsLe/gdSM4gS29xsx+r9SnSnI56ts=";
    };

    opacity = {
      terminal = 0.95;
    };
  };
}
