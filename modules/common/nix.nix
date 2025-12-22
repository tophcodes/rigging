{
  self,
  pkgs,
  config,
  ...
}: {
  nix = {
    # Automatic cleanup
    gc.automatic = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 21d";

    settings = {
      # builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes"];
      flake-registry = "/etc/nix/registry.json";

      keep-derivations = true;
      keep-outputs = true;

      trusted-users = ["root" "@wheel"];
      substituters = ["https://cache.nixos.org/"];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "nixos-config"
      "electron-36.9.5"
      "dotnet-sdk-6.0.428"
      "olm-3.2.16"
    ];
  };

  environment.etc."current-system-packages".text = let
    packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
    formatted = builtins.concatStringsSep "\n" sortedUnique;
  in
    formatted;
}
