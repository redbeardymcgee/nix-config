{
  workspace-switch.kind = {
    spring = {
      damping-ratio = 0.80;
      stiffness = 523;
      epsilon = 0.0001;
    };
  };
  window-open.kind = {
    easing = {
      duration-ms = 150;
      curve = "ease-out-expo";
    };
  };
  window-close.kind = {
    easing = {
      duration-ms = 150;
      curve = "ease-out-quad";
    };
  };
  horizontal-view-movement.kind = {
    spring = {
      damping-ratio = 0.85;
      stiffness = 423;
      epsilon = 0.0001;
    };
  };
  window-movement.kind = {
    spring = {
      damping-ratio = 0.75;
      stiffness = 323;
      epsilon = 0.0001;
    };
  };
  window-resize.kind = {
    spring = {
      damping-ratio = 0.85;
      stiffness = 423;
      epsilon = 0.0001;
    };
  };
  config-notification-open-close.kind = {
    spring = {
      damping-ratio = 0.65;
      stiffness = 923;
      epsilon = 0.001;
    };
  };
  # screenshot-ui-open.kind = {
  #   duration-ms = 200;
  #   curve = "ease-out-quad";
  # };
  overview-open-close.kind = {
    spring = {
      damping-ratio = 0.85;
      stiffness = 800;
      epsilon = 0.0001;
    };
  };
}
