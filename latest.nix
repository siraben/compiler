# Latest repos so can be easily updated with niv

# Bootstrappable packages as a Nixpkgs overlay
sources: self: super:

{
  kaem = super.kaem.overrideAttrs (oA: {
    src = sources.mescc-tools;
  });
  m2-planet = super.m2-planet.overrideAttrs (oA: {
    src = sources.m2-planet;
  });
  mes-m2 = super.mes-m2.overrideAttrs (oA: {
    src = sources.mes-m2;
  });
  mescc-tools = super.mescc-tools.overrideAttrs (oA: {
    src = sources.mescc-tools;
  });
}
