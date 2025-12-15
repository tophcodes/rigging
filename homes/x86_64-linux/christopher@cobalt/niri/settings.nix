{
  config,
  pkgs,
  ...
}: let
  round = tl: tr: bl: br: {
    bottom-left = bl;
    bottom-right = br;
    top-left = tl;
    top-right = tr;
  };

  r = 24.0;
  # rounded-corners = round r r r r;
  # rounded-corners-l = round r 0.0 0.0 r;
  rounded-corners-r = round 0.0 r r 0.0;
in {
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
          geometry-corner-radius = rounded-corners-r;
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
        # disable-power-key-handling = true;
        keyboard.xkb = {
          layout = "us";
          variant = "intl";
        };
      };

      outputs = {
        "DP-3" = {
          position.x = 3840;
          position.y = -430;
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
        # CLUTTER_BACKEND = "wayland";
        MOZ_ENABLE_WAYLAND = "1";
        # QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
      };
    };
  };
}
