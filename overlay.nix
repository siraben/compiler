# Bootstrappable packages as a Nixpkgs overlay
final: prev:

let
  lib = prev.lib;
in

{
  stdenvMinimal = prev.stdenvNoCC.override {
    cc = null;
    preHook = "";
    allowedRequisites = null;
    initialPath = lib.filter
      (a: lib.hasPrefix "coreutils" a.name
          || lib.hasPrefix "findutils" a.name
          || lib.hasPrefix "gnumake" a.name)
      prev.stdenvNoCC.initialPath;
    extraNativeBuildInputs = [ ];
  };
  blynn-compiler = prev.callPackage ./pkgs/blynn-compiler.nix { };
  kaem = prev.callPackage ./pkgs/kaem.nix { };
  m2-planet = prev.callPackage ./pkgs/m2-planet.nix { };
  mes-m2 = prev.callPackage ./pkgs/mes-m2.nix { };
  mescc-tools = prev.callPackage ./pkgs/mescc-tools.nix { };
  mescc-tools-seed = prev.callPackage ./pkgs/mescc-tools-seed.nix { };
}
