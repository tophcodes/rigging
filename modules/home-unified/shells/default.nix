{...}: {
  imports = [
    ./bash.nix
    ./fish.nix
    ./nu.nix
  ];

  programs = {
    bat.enable = true;

    atuin = {
      enable = true;
    };

    # Alternative cd command with fuzzy find
    zoxide = {
      enable = true;
      # Override default cd command
      options = ["--cmd cd"];
    };
  };
}
