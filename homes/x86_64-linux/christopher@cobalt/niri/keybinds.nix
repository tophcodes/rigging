{
  lib,
  config,
  pkgs,
  ...
}: let
in {
  programs.niri.settings = {
    binds = with config.lib.niri.actions; {
      "Mod+q".action = close-window;
      "Mod+t".action = spawn "${pkgs._elements.spawn-term}/bin/spawn-term";

      "Mod+space".action = spawn "fuzzel";
      "Mod+f".action = fullscreen-window;

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
      "Mod+Ctrl+j".action = move-window-up;
      "Mod+Ctrl+k".action = move-window-down;
      "Mod+Ctrl+l".action = move-column-right;
    };
  };
}
