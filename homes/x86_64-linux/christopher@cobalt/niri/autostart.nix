{
  lib,
  pkgs,
  ...
}: {
  programs.niri.settings.spawn-at-startup = with lib._elements; [
    {argv = ["mako"];}
    {argv = ["awww-daemon"];}
    {argv = ["awww" "img" "${fixture "wallpapers/cat-vibes.webp"}"];}

    {argv = ["kitty"];}
  ];
}
