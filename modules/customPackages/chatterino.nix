{ moduleWithSystem, ... }:
{

  flake.homeModules.extraPackages = moduleWithSystem (
    { self', ... }:
    { ... }:
    {
      home.packages = with self'.packages; [ chatterino2 ];
    }
  );

  perSystem =
    { inputs', ... }:
    let
      unstable = inputs'.unstable.legacyPackages;
    in
    {
      packages.chatterino2 = unstable.stdenv.mkDerivation {
        inherit (unstable.chatterino2)
          pname
          name
          version
          meta
          ;

        src = "${unstable.chatterino2}";
        buildPhase = /* bash */ ''
          cp -r $src $out

          substituteInPlace $out/share/applications/com.chatterino.chatterino.desktop \
          --replace "Exec=chatterino" "Exec=env QT_QPA_PLATFORM=xcb chatterino" # fixes freeze happening in PaperWM
        '';
      };
    };
}
