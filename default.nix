{ sources ? import ./nix/sources.nix { }
, pkgs ? import sources.nixpkgs { }
}:
let
  # Nixpkgs extended with bootstrappable related packages
  bootstrappable-pkgs = import ./pkgs {
    overlays = [ (import ./latest.nix sources) ];
  };
in
bootstrappable-pkgs
