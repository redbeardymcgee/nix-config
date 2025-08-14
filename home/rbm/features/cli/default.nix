{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # ./aerc.nix
    ./atuin.nix
    ./bash.nix
    ./bat.nix
    ./browsh.nix
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
    ./posting.nix
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
    inputs.posting.packages.${system}.default

    # nix tools
    alejandra
    comma
    manix

    # Generally useful
    bun
    clipboard-jh
    csview
    difftastic
    discordo
    distrobox
    entr
    gtrash
    magic-wormhole
    procs
    protonvpn-cli
    sass
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
