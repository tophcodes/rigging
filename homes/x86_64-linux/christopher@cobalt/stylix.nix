{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.stylix.homeModules.stylix];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-dawn.yaml";

    targets.firefox.profileNames = ["default" "work" "streaming"];

    cursor = {
      package = pkgs.rose-pine-cursor;
      # name = "Rosé Pine Dawn";
      name = "BreezeX-RosePineDawn-Linux";
      size = 32;
    };

    fonts.sizes = {
      applications = 12;
      terminal = 13;
      desktop = 10;
      popups = 10;
    };
  };
}
