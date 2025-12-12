{
  config,
  pkgs,
  ...
}: let
  borders = bl: br: tl: tr: {
    bottom-left = bl;
    bottom-right = br;
    top-left = tl;
    top-right = tr;
  };

  radius = 12.0;
  rounded = borders radius radius radius radius;
  rounded-left = borders radius 0.0 0.0 radius;
  rounded-right = borders 0.0 radius radius 0.0;
in {
  programs.niri.settings.window-rules = [
    {
      opacity = 0.95;
      clip-to-geometry = true;
      geometry-corner-radius = rounded-left;
    }
    {
      matches = [
        {is-focused = true;}
      ];

      focus-ring.width = 2;
    }
    {
      matches = [
        {app-id = "1password";}
        {app-id = "thunderbird";}
      ];

      block-out-from = "screencast";
    }
  ];
}
