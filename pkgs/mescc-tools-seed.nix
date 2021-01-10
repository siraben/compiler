{ stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation {
  pname = "mescc-tools-seed";
  version = "unstable-2021-01-09";

  src = fetchFromGitHub {
    owner = "oriansj";
    repo = "mescc-tools-seed";
    rev = "05d8bced32f7ba16597ba46d9cd98a83eaf9e336";
    sha256 = "10jgma1wi0jysb59vwnc4sxw1sfgkci7w492ymv8nq1pkbnfz0sc";
    fetchSubmodules = true;
  };

  makeFlags = [ "PREFIX=${placeholder "out"}" ];

  dontStrip = true;

  installPhase = ''
    mkdir -p $out/bin
    cp ./bin/* $out/bin
  '';
}
