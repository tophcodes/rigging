{channels, ...}: final: prev: {
  # Pull the following packages from unstable instead
  inherit
    (channels.unstable)
    kitty
    nu
    cider-2
    _1password-gui
    orca-slicer
    claude-code
    lutris
    ollama
    # currently doesn't build on unstable
    # open-webui
    ;

  bambu-studio = channels.unstable.bambu-studio.overrideAttrs (old: let
    newVersion = "02.03.00.70";
  in {
    version = newVersion;
    src = prev.fetchFromGitHub {
      owner = "bambulab";
      repo = "BambuStudio";
      rev = "v${newVersion}";
      hash = "sha256-2duNeSBi2WvsAUxkzTbKH+SiliNovc7LVICTzgQkrN8=";
    };

    nativeBuildInputs = (old.nativeBuildInputs or []) ++ [prev.cmake prev.pkg-config];

    postPatch =
      (old.postPatch or "")
      + ''
        # Remove cereal-Links (link does not work, havent seen anything breaking from this change).
        # Disclaimera; This patch is AI generated
        grep -RIl "target_link_libraries" . | while read -r f; do
          sed -i \
            -e 's/\bcereal::cereal\b//g' \
            -e 's/[[:space:]]\bcereal\b//g' \
            "$f"
        done
      '';

    postInstall =
      (old.postInstall or "")
      + ''
        wrapProgram $out/bin/bambu-studio --set GBM_BACKEND dri
      '';

    cmakeFlags =
      (old.cmakeFlags or [])
      ++ [
        "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
      ];
  });
}
