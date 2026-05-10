{ inputs, moduleWithSystem, ... }:
{

  flake.homeModules.extraPackages = moduleWithSystem (
    { system, ... }:
    { ... }:
    {
      home.packages = [ inputs.colmena.defaultPackage.${system} ];
    }
  );

}
