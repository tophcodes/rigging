{
  pkgs,
  inputs,
  system,
  ...
}: {
  home.packages = with pkgs; [
    # Editors
    jetbrains-toolbox # Installer for JetBrains IDEs
    zed-editor
    code-cursor
    vscode

    rfc

    # Language Servers
    lua-language-server
    rust-analyzer
    nodePackages.typescript
    nodePackages.typescript-language-server
    nil # nix lsp

    # trurl # Parsing and manipulating URLs via CLI
    ripgrep # Grep file search
    dig # DNS
    onefetch # Git information tool
    tokei # Like cloc
    zeal # Offline documentation browser
    just # Just a command runner
    claude-monitor
    devenv
    _elements.oryx # TUI for sniffing network traffic using eBPF

    # Build tools
    cargo
    glibc
    gcc

    php82
    php82Packages.composer

    bun
    nodejs_20
    nodejs_20.pkgs.pnpm
  ];

  programs = {
    go.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;

      config.global.log_filter = "^$";
    };

    claude-code = {
      enable = true;
      # package = inputs.unstable.${system}.claude-code;

      commands = {
        fix-github-issue = ''
          Please analyze and fix the GitHub issue $ARGUMENTS.

          Follow these steps:
          1. Use `gh issue view` to get the issue details
          2. Understand the problem described in the issue. If necessary, follow links to other mentioned issues to understand context
          3. Search the codebase for relevant files
          4. Implement the necessary changes to fix the issue
          5. Write and run tests to verify the fix
          6. Ensure code passes linting and type checking
          7. Create a descriptive commit message
          8. Push and create a PR

          Remember to use the GitHub CLI (`gh`) for all GitHub-related tasks.
        '';

        commit = ''
          ---
          argument-hint: [commit-style]
          ---

          Create a commit message. The message should be succinct, only with a one-liner explaining
          the most relevant changes and possibly some reasoning for changes, but only where relevant.

          Try to follow this commit style, if specified: '$ARGUMENTS'. If no commit style is specified,
          try doing atomic commits. That is, split up larger changes into atomic commits that stand
          for themselves.

          Do not include a `Co-authored-by`.
        '';
      };
    };
  };
}
