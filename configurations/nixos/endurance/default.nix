# Riddle.
#
#
#
# Link to Aleph that doesn't yet exist. Include in riddle.
#
{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    self.nixosModules.default
    self.nixosModules.gui
    ./configuration.nix
  ];
}
