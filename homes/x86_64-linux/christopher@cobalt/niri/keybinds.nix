{
  config,
  pkgs,
  ...
}: {
  programs.niri.settings = {
    binds = with config.lib.niri.actions; {
      "Mod+space".action = spawn "fuzzel";
      "Mod+e".action = spawn "dolphin";
      "Mod+c".action = spawn "${pkgs._elements.spawn-term}/bin/spawn-term";
      "Mod+g".action = spawn "${pkgs._elements.hg-picker}/bin/hg-picker";

      "Mod+q".action = close-window;
      "Mod+f".action = fullscreen-window;
      "Mod+t".action = toggle-window-floating;
      "Mod+w".action = toggle-column-tabbed-display;

      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;

      "Mod+Ctrl+1".action.move-window-to-workspace = 1;
      "Mod+Ctrl+2".action.move-window-to-workspace = 2;
      "Mod+Ctrl+3".action.move-window-to-workspace = 3;
      "Mod+Ctrl+4".action.move-window-to-workspace = 4;
      "Mod+Ctrl+5".action.move-window-to-workspace = 5;

      "Mod+WheelScrollDown".cooldown-ms = 150;
      "Mod+WheelScrollDown".action = focus-workspace-down;
      "Mod+WheelScrollUp".cooldown-ms = 150;
      "Mod+WheelScrollUp".action = focus-workspace-up;
      "Mod+WheelScrollRight".action = focus-column-right;
      "Mod+WheelScrollLeft".action = focus-column-left;

      "Mod+h".action = focus-column-left;
      "Mod+j".action = focus-workspace-up;
      "Mod+k".action = focus-workspace-down;
      "Mod+l".action = focus-column-right;
      "Mod+Ctrl+h".action = move-column-left;
      "Mod+Ctrl+j".action = move-window-up-or-to-workspace-up;
      "Mod+Ctrl+k".action = move-window-down-or-to-workspace-down;
      "Mod+Ctrl+l".action = move-column-right;
    };
  };
}
