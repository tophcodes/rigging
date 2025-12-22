{
  lib,
  stdenv,
  fetchurl,
}:

stdenv.mkDerivation rec {
  pname = "oryx";
  version = "0.7.2";

  src = fetchurl {
    url = "https://github.com/pythops/oryx/releases/download/v${version}/oryx-x86_64-unknown-linux-musl";
    hash = "sha256-qvgdaFs21nDePKSYYWChdknbrWlmZheGLsmv/STnVuk=";
  };

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp $src $out/bin/oryx
    chmod +x $out/bin/oryx
    runHook postInstall
  '';

  meta = with lib; {
    description = "TUI for sniffing network traffic using eBPF";
    homepage = "https://github.com/pythops/oryx";
    license = licenses.gpl3Only;
    maintainers = [];
    mainProgram = "oryx";
    platforms = ["x86_64-linux"];
  };
}
