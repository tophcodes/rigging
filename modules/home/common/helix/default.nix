{pkgs, ...}: {
  home.packages = [pkgs.helix];

  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      editor = {
        rulers = [80];
        shell = ["nu" "-c"];
        line-number = "relative";

        auto-format = true;
        file-picker.hidden = false;

        # TODO: Why does the clipboard not work?
        # clipboard-provider.custom = {
        #   yank = {command = "wl-copy";};
        #   paste = {command = "wl-paste";};
        # };

        whitespace.render = {
          tabpad = "all";
        };
      };
    };

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
      }
    ];

    # themes = {
    #   catppuccin = {
    #     inherits = "catppuccin/default/catppuccin_frappe";
    #     "ui.background" = {};
    #     # "ui.virtual.whitespace" = {style = "dim";};
    #   };
    # };
  };
}
