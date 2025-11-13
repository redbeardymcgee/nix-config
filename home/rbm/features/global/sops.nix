{config, ...}: {
  sops = {
    defaultSopsFile = ../../../../secrets/rbm.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    };
    secrets.phone_number = {};
  };
}
