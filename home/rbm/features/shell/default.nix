{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./atuin.nix
    ./bash.nix
    ./bat.nix
    ./comma.nix
    ./difftastic.nix
    ./direnv.nix
    ./eza.nix
    ./fastfetch
    ./fd.nix
    ./fish.nix
    ./fzf.nix
    ./jq.nix
    ./less.nix
    ./man.nix
    ./nix-index.nix
    ./nix.nix
    ./ripgrep.nix
    ./sesh.nix
    ./starship.nix
    ./tealdeer.nix
    ./tmux
    ./yazi
    # ./zellij.nix
    ./zoxide.nix
    ./zk.nix
  ];

  home.packages = with pkgs; [
    clipboard-jh
    csview
    csvlens
    distrobox
    entr
    gtrash
    lsof
    magic-wormhole
    procs
    sass
    serie
    typos
    xan
    yq-go
    manix
  ];
}
