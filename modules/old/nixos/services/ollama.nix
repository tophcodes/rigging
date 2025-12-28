{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.elements.ollama;
in {
  options.services.elements = {
    ollama.enable = mkEnableOption "Enable Ollama";
  };

  config = mkIf cfg.enable {
    services = {
      ollama = {
        enable = true;
        user = "ollama";
        host = "0.0.0.0";
        openFirewall = true;
        acceleration = "rocm";
      };

      qdrant = {
        enable = true;
        # settings = {};
      };

      open-webui = {
        enable = true;
        host = "0.0.0.0";
        openFirewall = true;
      };
    };
  };
}
