{ inputs, ... }:
let
  system = "x86_64-linux";
in
{
  perSystem =
    { inputs', pkgs, ... }:
    let
      unstable = inputs'.unstable.legacyPackages;
      flameshot-pin = inputs'.flameshot-pin.legacyPackages;
      zen-browser = inputs'.zen-browser.packages;
      neovim-config = inputs'.neovim-config.packages;
      # jujutsu-repo = inputs'.jujutsu.packages;
    in
    {
      packages = {
        chatterino2 = unstable.stdenv.mkDerivation {
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

        nvim = neovim-config.nvim;
        zen-browser = zen-browser.twilight;
        flameshot = flameshot-pin.flameshot;
        colmena = inputs.colmena.defaultPackage.${system};

        copyous = unstable.gnomeExtensions.copyous;

        freeJ2ME = pkgs.callPackage ./FreeJ2ME.nix { };

        inherit (unstable)
          jujutsu
          dolphin-emu
          evolution
          gamescope
          nushell
          ghostty
          ;
      };
    };
}
