{
  programs.chromium = {
    enable = true;

    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";  }# ublock origin
      # "ammjkodgmmoknidbanneddgankgfejfh" # 7TV
    ];
  };
}
