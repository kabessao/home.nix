{ moduleWithSystem, ... }:
{

  # flake.homeModules.extraPackages = moduleWithSystem (
  #   { self', ... }:
  #   { ... }:
  #   {
  #     home.packages = [ self'.packages.FreeJ2ME ];
  #   }
  # );

  perSystem =
    { pkgs, ... }:
    {
      packages.FreeJ2ME =
        with pkgs;
        stdenv.mkDerivation rec {
          name = "FreeJ2ME";
          version = "2018-09-07";
          src = fetchzip {
            url = "https://sinalbr.dl.sourceforge.net/project/freej2me/freej2me_${version}.zip";
            hash = "sha256-A8PQANYje7S2Th5x8n6dkssgpa4dpgMrWxtIPNeH5mc=";
          };

          buildPhase = /* bash */ ''
            mkdir -p $out/lib $out/bin
            cp -r $src/* $out/lib/

            cat <<-EOF > $out/bin/freeJ2ME
            #!${bash}/bin/bash
            path="file://\$(readlink -f "\$@")"
            ${openjdk}/bin/java -jar $out/lib/build/freej2me.jar "\$path"
            EOF

            chmod +x $out/bin/freeJ2ME
          '';
        };
    };
}
