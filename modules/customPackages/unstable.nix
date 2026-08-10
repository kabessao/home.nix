{ moduleWithSystem, ... }:
{

  flake.homeModules.extraPackages = moduleWithSystem (
    { inputs', ... }:
    { ... }:
    {
      home.packages = with inputs'.unstable.legacyPackages; [
        # gamescope
        dolphin-emu
        stremio-linux-shell
      ];
    }
  );

}
