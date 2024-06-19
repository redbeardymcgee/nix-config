{ lib, ... }: {
  programs.starship = {
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
}
