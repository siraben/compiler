{ stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation {
  pname = "mescc-tools-seed";
  version = "unstable-2021-01-10";

  src = fetchFromGitHub {
    owner = "oriansj";
    repo = "mescc-tools-seed";
    rev = "0f549aee03a6d97dd441ec17ea832aa5229f3e77";
    sha256 = "1gw7g614rcv67wlm7rnl58ndaanl4l9rq29h2x3lqxibw9nsvz5n";
    fetchSubmodules = true;
  };

  makeFlags = [ "PREFIX=${placeholder "out"}" ];

  dontStrip = true;

  installPhase = ''
    mkdir -p $out/bin
    cp ./bin/* $out/bin
  '';
}
