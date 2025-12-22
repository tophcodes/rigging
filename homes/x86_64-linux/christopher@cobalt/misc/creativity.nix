{
  pkgs,
  system,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # 3D printing and engineering
    orca-slicer

    # Drawing
    krita
    inputs.affinity-nix.packages.${system}.v3

    # Audio
    vcv-rack
    supercollider
  ];
}
