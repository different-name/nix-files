{
  lib,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "nix-files";
  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    cp install $out/bin/${finalAttrs.name}
    chmod +x $out/bin/${finalAttrs.name}
  '';

  meta = {
    description = "Different's nix-files";
    homepage = "https://github.com/Different-Name/nix-files";
    license = lib.licenses.gpl3Only;
  };
})
