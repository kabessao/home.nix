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
      jujutsu-repo = inputs'.jujutsu.packages;
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
        jujutsu = jujutsu-repo.jujutsu;
        flameshot = flameshot-pin.flameshot;
        stremio = pkgs.callPackage ./stremio-shell.nix { };
        colmena = inputs.colmena.defaultPackage.${system};

        inherit (unstable)
          dolphin-emu
          evolution
          nushell
          ghostty
          ;
      };
    };
}
