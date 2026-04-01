{config, ...}:
with config.lib.niri.actions; {
  "Mod+Shift+E".action.quit = {skip-confirmation = true;};
  "Mod+Shift+Slash".action = show-hotkey-overlay;

  "Mod+Tab" = {
    repeat = false;
    action = toggle-overview;
  };
  "Mod+D" = {
    repeat = false;
    action = toggle-overview;
  };

  ## Launchers & Tools
  "Mod+Space" = {
    hotkey-overlay.title = "App Launcher";
    action.spawn = ["dms" "ipc" "call" "spotlight" "toggle"];
  };
  "Mod+V" = {
    hotkey-overlay.title = "Clipboard Manager";
    action.spawn = ["dms" "ipc" "call" "clipboard" "toggle"];
  };
  "Mod+M" = {
    hotkey-overlay.title = "Task Manager";
    action.spawn = ["dms" "ipc" "call" "processlist" "focusOrToggle"];
  };
  "Mod+P" = {
    hotkey-overlay.title = "Power Menu";
    action.spawn = ["dms" "ipc" "call" "powermenu" "toggle"];
  };
  "Mod+N" = {
    hotkey-overlay.title = "Notification Center";
    action.spawn = ["dms" "ipc" "call" "notifications" "toggle"];
  };
  "Mod+Shift+N" = {
    hotkey-overlay.title = "Notepad";
    action.spawn = ["dms" "ipc" "call" "notepad" "toggle"];
  };
  "Mod+T" = {
    hotkey-overlay.title = "Open Terminal";
    action.spawn = ["{{TERMINAL_COMMAND}}"];
  };

  ## Audio Controls
  "XF86AudioMute" = {
    allow-when-locked = true;
    action.spawn = ["dms" "ipc" "call" "audio" "mute"];
  };
  "XF86AudioLowerVolume" = {
    allow-when-locked = true;
    action.spawn = ["dms" "ipc" "call" "audio" "decrement"];
  };
  "XF86AudioRaiseVolume" = {
    allow-when-locked = true;
    action.spawn = ["dms" "ipc" "call" "audio" "increment"];
  };
  "Ctrl+XF86AudioLowerVolume" = {
    allow-when-locked = true;
    action.spawn = ["dms" "ipc" "call" "mpris" "decrement"];
  };
  "Ctrl+XF86AudioRaiseVolume" = {
    allow-when-locked = true;
    action.spawn = ["dms" "ipc" "call" "mpris" "increment"];
  };
  "XF86AudioMedia" = {
    allow-when-locked = true;
    action.spawn = ["dms" "ipc" "call" "mpris" "playPause"];
  };
  "XF86AudioPlay" = {
    allow-when-locked = true;
    action.spawn = ["dms" "ipc" "call" "mpris" "playPause"];
  };
  "XF86AudioNext" = {
    allow-when-locked = true;
    action.spawn = ["dms" "ipc" "call" "mpris" "next"];
  };
  "XF86AudioPrev" = {
    allow-when-locked = true;
    action.spawn = ["dms" "ipc" "call" "mpris" "previous"];
  };

  ## Window Management
  "Mod+Q" = {
    repeat = false;
    action = close-window;
  };
  "Mod+F".action = maximize-column;
  "Mod+Shift+F".action = fullscreen-window;
  "Mod+Shift+T".action = toggle-window-floating;
  "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
  "Mod+Shift+W".action = toggle-column-tabbed-display;

  ## Focus Navigation
  "Mod+H".action = focus-column-left;
  "Mod+J".action = focus-window-down;
  "Mod+K".action = focus-window-up;
  "Mod+L".action = focus-column-right;

  ## Window Movement
  "Mod+Shift+H".action = move-column-left;
  "Mod+Shift+J".action = move-window-down;
  "Mod+Shift+K".action = move-window-up;
  "Mod+Shift+L".action = move-column-right;

  ## Monitor Navigation
  "Mod+Ctrl+H".action = focus-monitor-left;
  "Mod+Ctrl+J".action = focus-monitor-down;
  "Mod+Ctrl+K".action = focus-monitor-up;
  "Mod+Ctrl+L".action = focus-monitor-right;

  ## Move to Monitor
  "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
  "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
  "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
  "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

  ## Workspace Navigation
  "Mod+Alt+J".action = focus-workspace-down;
  "Mod+Alt+K".action = focus-workspace-up;
  "Mod+Shift+Alt+J".action = move-column-to-workspace-down;
  "Mod+Shift+Alt+K".action = move-column-to-workspace-up;

  ## Workspace Management
  "Ctrl+Shift+R" = {
    hotkey-overlay.title = "Rename Workspace";
    action.spawn = ["dms" "ipc" "call" "workspace-rename" "open"];
  };

  ## Move Workspaces
  "Mod+Shift+Ctrl+Alt+J".action = move-workspace-down;
  "Mod+Shift+Ctrl+Alt+K".action = move-workspace-up;

  ## Numbered Workspaces
  "Mod+1".action.focus-workspace = 1;
  "Mod+2".action.focus-workspace = 2;
  "Mod+3".action.focus-workspace = 3;
  "Mod+4".action.focus-workspace = 4;
  "Mod+5".action.focus-workspace = 5;
  "Mod+6".action.focus-workspace = 6;
  "Mod+7".action.focus-workspace = 7;
  "Mod+8".action.focus-workspace = 8;
  "Mod+9".action.focus-workspace = 9;

  ## Move to Numbered Workspaces
  "Mod+Shift+1".action.move-column-to-workspace = 1;
  "Mod+Shift+2".action.move-column-to-workspace = 2;
  "Mod+Shift+3".action.move-column-to-workspace = 3;
  "Mod+Shift+4".action.move-column-to-workspace = 4;
  "Mod+Shift+5".action.move-column-to-workspace = 5;
  "Mod+Shift+6".action.move-column-to-workspace = 6;
  "Mod+Shift+7".action.move-column-to-workspace = 7;
  "Mod+Shift+8".action.move-column-to-workspace = 8;
  "Mod+Shift+9".action.move-column-to-workspace = 9;

  ## Column Management
  "Mod+BracketLeft".action = consume-or-expel-window-left;
  "Mod+BracketRight".action = consume-or-expel-window-right;
  "Mod+Period".action = expel-window-from-column;

  ## Sizing & Layout
  "Mod+R".action = switch-preset-column-width;
  "Mod+Shift+R".action = switch-preset-window-height;
  "Mod+Ctrl+R".action = reset-window-height;
  "Mod+Ctrl+F".action = expand-column-to-available-width;
  "Mod+C".action = center-column;
  "Mod+Ctrl+C".action = center-visible-columns;

  ## Manual Sizing
  "Mod+Minus".action.set-column-width = "-10%";
  "Mod+Equal".action.set-column-width = "+10%";
  "Mod+Shift+Minus".action.set-window-width = "-10%";
  "Mod+Shift+Equal".action.set-window-width = "+10%";

  ## Screenshots
  "Print".action = screenshot;
  "Ctrl+Print".action = screenshot-screen;
  "Alt+Print".action = screenshot-window;

  ## System Controls
  "Mod+Shift+P".action = power-off-monitors;
  "Mod+Escape" = {
    allow-inhibiting = false;
    action = toggle-keyboard-shortcuts-inhibit;
  };
}
