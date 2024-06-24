{ appimageTools, fetchurl }:
let
  pname = "ente-photos-desktop";
  version = "1.7.1";

  src = fetchurl {
    url = "https://github.com/ente-io/photos-desktop/releases/download/v${version}/ente-${version}-x86_64.AppImage";
    hash = "sha256-u+N9rPQamKwG6yxw+R83RD14bC3HH053Ap3dNcK8eSY=";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;
}