{ ... }: {
  services.fnott = {
    enable = true;
    settings = {
      default = {
        selection-helper = "tofi";
      };
    };
  };
}
