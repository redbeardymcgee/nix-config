{
  pkgs,
  inputs,
  nixcats,
  ...
}: {
  imports = [
    ./atuin.nix
    ./bash.nix
    ./bat.nix
    ./bottom.nix
    ./direnv.nix
    ./eza.nix
    ./fastfetch
    ./fd.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./go.nix
    ./htop.nix
    ./jq.nix
    ./lazygit.nix
    ./less.nix
    ./man.nix
    ./nix-index.nix
    ./nix.nix
    ./nvim.nix
    ./rbw.nix
    ./ripgrep.nix
    ./ssh.nix
    ./starship.nix
    ./tealdeer.nix
    ./tmux
    ./tokei.nix
    ./yazi
    ./zk.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    inputs.nixcats.packages.${system}.nixCats

    # nix tools
    alejandra
    comma
    manix

    # Generally useful
    difftastic
    entr
    gtrash
    magic-wormhole
    procs
    typos
    yq

    # Editor support
    cargo
    nodejs
    python3
    tree-sitter

    # Yazi deps but generally useful
    exiftool
    glow
    hexyl
    miller
    ouch
    p7zip
    poppler
    ripdrag
  ];
}
