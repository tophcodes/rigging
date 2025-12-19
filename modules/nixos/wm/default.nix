{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.elements.wm;
in {
  options.elements = {
    wm = {
      enable = mkEnableOption "Enable window manager configuration";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kdePackages.discover
      kdePackages.kclock
      kdePackages.kcharselect
      kdePackages.kolourpaint
      kdePackages.ksystemlog
      wayland-utils
      wl-clipboard
      libsForQt5.qtstyleplugin-kvantum
      xwayland-satellite
      nautilus # xdg-gnome needs this but we don't use gnome???
    ];

    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    services.xserver = {
      enable = true;
    };

    services.desktopManager.plasma6.enable = true;
    services.displayManager = {
      defaultSession = "plasma";

      # SDDM is broken
      # gdm = {
      #   enable = true;
      #   wayland = true;
      # };

      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      configPackages = [pkgs.xdg-desktop-portal-gtk];
      config.common.default = "gtk";
    };

    security.polkit.enable = true;
  };
}
