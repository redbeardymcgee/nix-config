{inputs, outputs, pkgs, ...}: {
  imports = [
    ./atuin.nix
    ./bash.nix
    ./bat.nix
    ./bottom.nix
    ./direnv.nix
    ./eza.nix
    ./fastfetch.nix
    ./fd.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./gitui.nix
    ./go.nix
    ./htop.nix
    ./jq.nix
    ./less.nix
    ./man.nix
    ./nix-index.nix
    ./rbw.nix
    ./ripgrep.nix
    ./ssh.nix
    ./starship.nix
    ./tealdeer.nix
    ./tmux
    ./yazi
    ./zk.nix
    ./zoxide.nix
  ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays ++ builtins.attrValues inputs.kixvim.overlays;

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.packages = with pkgs; [
    alejandra
    comma
    devenv
    difftastic
    entr
    exiftool
    glow
    gtrash
    hexyl
    lazydocker
    manix
    miller
    # neovim
    kixvim
    nodejs
    ouch
    poppler
    procs
    python3
    ripdrag
    transmission_4
    tree-sitter
    yq
  ];
}
