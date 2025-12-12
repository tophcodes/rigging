{pkgs, ...}: {
  programs.firefox = {
    enable = true;

    profiles."default" = {
      id = 0;
    };
    profiles."work" = {
      id = 1;
    };
  };

  home.packages = [pkgs._elements.open-url];
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "open-url.desktop";
    "x-scheme-handler/https" = "open-url.desktop";
  };

  services.psd = {
    # profile-sync-daemon
    enable = false;
    resyncTimer = "10m";
  };
}
