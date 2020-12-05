{ sources ? import ../nix/sources.nix, pkgs ? import sources.nix, overlays ? [ ] }:

import sources.nixpkgs {
  overlays = [ (import ./packages.nix) ] ++ overlays;
}
