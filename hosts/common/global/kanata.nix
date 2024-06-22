{ ... }: {
  kanata = {
    enable = true;
    keyboards."rbm".config = ''
      (defsrc caps)

      (deflayermap (default-layer)
        caps (tap-hold 100 100 caps lctl))
    '';
  };
}
