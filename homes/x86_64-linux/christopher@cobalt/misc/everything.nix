{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    gnupg
    unzip
    dua # Interactively view disk space usage
    numbat # Scientific calculations
    yubikey-manager
    croc # File transfer
    solaar # Logitech mouse driver
    btop # Better resource monitor
    bottom # System resource monitor
    grim # Screenshots
    slurp # Region selection

    # Productivity
    obsidian # Note taking
    todoist-electron # To-Do List app
    thunderbird # Email client
    onlyoffice-desktopeditors # libreoffice alternative
    speedcrunch # GUI calculator app
    calibre # eBook Manager

    # Viewers
    cider-2 # Apple music player
    vlc # Video player
    xarchiver # Archive viewer/extractor
    zathura # Document viewer
    evince # Document viewer

    # element-desktop
    fractal # Matrix client
    gomuks # Matrix client TUI
    telegram-desktop
    vesktop # Discord client
    filezilla # FTP Client
    mochi # SRS flashcards
  ];
}
