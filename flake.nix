{
  description = "blynn-compiler";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, utils, ... }:
    utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        overlay = import ./overlay.nix;
        pkgs = import nixpkgs { inherit system; overlays = [ overlay ]; };
      in {
        inherit overlay;
        packages = pkgs;
        defaultPackage = pkgs.blynn-compiler;
      });
}
