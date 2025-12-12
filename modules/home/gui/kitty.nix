{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.elements;
in {
  options = {
    elements.kitty = {
      enable = mkEnableOption "kitty";
    };
  };

  config = mkIf cfg.kitty.enable {
    programs.fish.enable = true;
    programs.kitty = {
      enable = true;

      settings = {
        window_padding_width = "5 10";
        paste_actions = "no-op";
      };

      actionAliases = {
        "launch_current" = "launch --cwd current";
      };

      extraConfig = ''
        shell ${pkgs.fish}/bin/fish
        modify_font cell_height 7px
      '';
    };

    xdg.configFile."kitty/open-actions.conf".text = ''
      # Open all file links in helix in the current shell
      protocol file
      # mime text/*
      action send_text normal,application hx "''${FILE_PATH}"\r
    '';
  };
}
