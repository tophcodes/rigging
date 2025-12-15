{
  config,
  pkgs,
  ...
}: {
  services.mako = {
    enable = true;

    settings = {
      max-visible = 5;
      #actions = true;
      # icons = true;
      # default-timeout = 10000; # in ms
      # border-radius = 3;
      # markup = true;
    };
  };
}
