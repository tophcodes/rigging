{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    droidcam
    davinci-resolve
    ffmpeg
  ];

  programs.firefox.profiles."streaming" = {
    id = 2;
    settings = {};
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      kagi-search
      kagi-privacy-pass
      ublock-origin
      # dark-reader
      tree-style-tab
    ];

    search = {
      force = true;
      default = "Kagi";
    };
  };
}
