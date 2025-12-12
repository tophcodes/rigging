{pkgs, ...}: {
  home.packages = with pkgs; [
    # Dev tools
    git
    gh
    git-absorb
    delta # Diffing tool
    onefetch # neofetch for git repos

    pkgs._elements.git-delete-stale
  ];

  programs.git = {
    enable = true;

    signing = {
      signByDefault = true;
      key = "E919B0F59E14FD47";
    };

    settings = {
      user = {
        name = "Christopher Mühl";
        email = "hello@muehl.dev";
      };
      push = {
        default = "current";
        autoSetupRemote = true;
        followTags = true;
      };
      column.ui = "auto"; # Display columns in `git branch` automatically
      branch.sort = "-committerdate"; # Sort `git branch` by last commit date
      rerere.enabled = true; # Enable reuse recorded resolution, for automatic merge resolution
      alias.force-push = "push --force-with-lease"; # Safe force pushes
      fetch.writeCommitGraph = true; # Automatically write the commit graph on fetches
      init.defaultBranch = "main";
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta = {
        navigate = true;
        dark = true;
      };
      merge.conflictstyle = "zdiff3";
    };
  };
}
