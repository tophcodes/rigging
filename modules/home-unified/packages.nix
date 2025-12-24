{pkgs, ...}: {
  # Nix packages to install to every user's home.
  home.packages = with pkgs; [
    omnix

    # Unix tools
    ripgrep
    fd
    sd
    tree
    gnumake
    just

    # Nix dev
    cachix
    nil # Language server
    nix-info
    alejandra
  ];

  programs = {
    # `<ctrl> + r` to fuzzy-search my shell history
    fzf.enable = true;

    # Simplified JSON parsing
    # TODO: Should I get rid of this globally? Use nu instead?
    jq.enable = true;
  };
}
