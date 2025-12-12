{
  config,
  pkgs,
  ...
}: {
  programs.niri = {
    settings = {
      prefer-no-csd = true;

      layout = {
        background-color = "#ac8887";
        focus-ring.enable = true;

        gaps = 24;
        shadow = {
          enable = true;
        };
      };

      window-rules = [
        {
          opacity = 0.95;
          clip-to-geometry = true;
          geometry-corner-radius = {
            bottom-left = 12.0;
            bottom-right = 0.0;
            top-left = 0.0;
            top-right = 12.0;
          };
        }
        {
          matches = [{is-focused = true;}];

          # opacity = 0.98;
          focus-ring = {
            width = 2;
          };
        }
      ];

      input = {
        keyboard.xkb.layout = "en";
      };

      outputs = {
        "DP-3" = {
          position.x = 3840;
          position.y = -370;
          transform = {
            rotation = 90;
          };
        };
        "HDMI-A-1" = {
          position.x = 0;
          position.y = 0;
          focus-at-startup = true;
        };
      };

      environment = {
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland.x11";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
      };
    };
  };
}
