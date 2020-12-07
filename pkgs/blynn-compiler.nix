{ stdenv, lib, help2man, texinfo, mescc-tools, mes-m2, m2-planet, hostPlatform, pkgs }:

stdenv.mkDerivation {
  name = "blynn-compiler";
  src = lib.cleanSource ../.;
  nativeBuildInputs = [ help2man texinfo mescc-tools m2-planet mes-m2 ];

  postPatch = ''
    patchShebangs go.sh
  '';

  buildPhase = ''
    substituteInPlace go.sh --replace "./bin/pack_blobs" "${hostPlatform.emulator pkgs} ./bin/pack_blobs"
    substituteInPlace go.sh --replace "./bin/vm" "${hostPlatform.emulator pkgs} ./bin/vm"
    ./go.sh
  '';

  installPhase = ''
    mkdir -p $out/share
    cp bin/vm $out/share
  '';
}
