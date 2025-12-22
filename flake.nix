{
  description = "toph's system configuration";

  inputs = {
    # Core
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Flake framework
    # flake-parts.url = "github:hercules-ci/flake-parts";
    # nixos-unified.url = "github:srid/nixos-unified";
    snowfall = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Infrastructure
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets management
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Styling
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    affinity-nix.url = "github:mrshmllow/affinity-nix";
    quadlet.url = "github:SEIAROTg/quadlet-nix";
    musnix.url = "github:musnix/musnix";
    niri.url = "github:sodiboo/niri-flake/9e59ee8";
    awww.url = "git+https://codeberg.org/LGFae/awww";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Custom
    ovos = {
      url = "git+file:///home/christopher/workspaces/ovos-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, ...} @ inputs:
    (inputs.snowfall.mkFlake {
      inherit inputs;
      src = ./.;

      # Exposes all internal libs and packages as `lib._elements` or `pkgs._elements` respectively
      snowfall.namespace = "_elements";

      # Global system modules to be included for all systems
      systems.modules = with inputs; {
        nixos = [
          disko.nixosModules.default
          agenix.nixosModules.default
          agenix-rekey.nixosModules.default
          ./modules/common
        ];
        darwin = [
          agenix.darwinModules.default
          agenix-rekey.nixosModules.default
          stylix.darwinModules.stylix
          ./modules/common
        ];
      };

      # Add modules only to specific hosts
      systems.hosts = with inputs; {
        cobalt.modules = [
          niri.nixosModules.niri
          stylix.nixosModules.stylix
          musnix.nixosModules.default
          ovos.nixosModules.default
        ];
        beryllium.modules = [
          quadlet.nixosModules.quadlet
        ];
        europium.modules = [
          quadlet.nixosModules.quadlet
        ];
      };

      homes.users = {
        "christopher@beryllium".modules = with inputs; [
          quadlet.homeManagerModules.quadlet
        ];
      };

      # Configure nixpkgs when instantiating the package set
      # TODO: This is already specified elsewhere. Still needed here?
      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [];
      };

      overlays = with inputs; [
        niri.overlays.niri
        nur.overlays.default
      ];

      outputs-builder = channels: {
        formatter = channels.nixpkgs.alejandra;
      };
    })
    // {
      agenix-rekey = inputs.agenix-rekey.configure {
        userFlake = inputs.self;
        nixosConfigurations = inputs.self.nixosConfigurations // inputs.self.darwinConfigurations;
        homeConfigurations = inputs.self.homeConfigurations;
      };
    };
}
