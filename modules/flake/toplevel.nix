# Top-level flake glue
{inputs, ...}: {
  imports = [
    inputs.nixos-unified.flakeModules.default
    # not sure yet
    # inputs.nixos-unified.flakeModules.autoWire
  ];

  perSystem = {
    self',
    pkgs,
    ...
  }: {
    # Formatter to use for 'nix fmt'
    formatter = pkgs.alejandra;

    # Activate using 'nix run'
    packages.default = self'.packages.activate;
  };
}
