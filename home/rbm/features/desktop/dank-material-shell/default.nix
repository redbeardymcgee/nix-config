{
  inputs,
  pkgs,
  ...
}: {
  programs.dank-material-shell = {
    enable = true;
    enableAudioWavelength = true;
    enableCalendarEvents = false;
    enableClipboardPaste = true;
    enableDynamicTheming = false;
    enableSystemMonitoring = true;
    enableVPN = false;

    dgop = {
      package = inputs.dgop.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };

    plugins = {};

    niri = {
      enableSpawn = true;
      ## TODO: Are there really no hm settings for these includes?
      includes.enable = false;
    };

    settings = {
      theme = "dark";
    };
  };
}
