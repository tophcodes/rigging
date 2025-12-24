{config, ...}: {
  home.shellAliases = {
    g = "git";
    lazy = "lazygit";
  };

  programs = {
    git = {
      enable = true;
      userName = config.me.fullname;
      userEmail = config.me.email;
      ignores = ["*~" "*.swp"];
      aliases = {
        ci = "commit";
      };
    };
    lazygit.enable = true;
  };
}
