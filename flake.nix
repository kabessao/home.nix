{
  description = "Home Manager configuration of cyberdruga";

  inputs = {

    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";

    # Separate repo for just gnome extensions
    extensions.url = "github:nixos/nixpkgs/1cb1c02a6b1b7cf67e3d7731cbbf327a53da9679"; 

    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    flameshot-pin.url = "nixpkgs/b60793b86201040d9dee019a05089a9150d08b5b";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    neovim-config.url = "github:kabessao/kickstart.nvim";
    jujutsu.url = "github:jj-vcs/jj";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, home-manager, flake-utils, ... }@args:
    flake-utils.lib.eachDefaultSystemPassThrough (system: 

      let

        unstable = args.unstable.legacyPackages.${system};
        flameshot-pin = args.flameshot-pin.legacyPackages.${system};
        zen-browser = args.zen-browser.packages.${system};
        neovim-config = args.neovim-config.packages.${system};
        extensions = args.extensions.legacyPackages.${system};
        jujutsu-repo = args.jujutsu.packages.${system};

        overlay = final: prev: {

          gnomeExtensions = unstable.gnomeExtensions //  {
            window-is-ready-remover = unstable.gnomeExtensions.window-is-ready-remover.overrideAttrs {
              postInstall = /*bash*/ ''
             cd $out/share/gnome-shell/extensions/windowIsReady_Remover@nunofarruca@gmail.com
             ${unstable.nushell}/bin/nu -c "open metadata.json | update shell-version { \$in ++  [ \"48\"] } | save metadata.json --force "
             '';
            };
          };

          chatterino2 = prev.stdenv.mkDerivation {
            pname = "chatterino2";
            name = "chatterino2";
            src = "${unstable.chatterino2}";

            buildPhase = ''
              cp -r $src $out

              substituteInPlace $out/share/applications/com.chatterino.chatterino.desktop \
              --replace "Exec=chatterino" "Exec=env QT_QPA_PLATFORM=xcb chatterino" # fixes freeze happening in PaperWM

            '';
          };

          nvim        = neovim-config.nvim;
          zen-browser = zen-browser.twilight;
          jujutsu     = jujutsu-repo.jujutsu;
          flameshot   = flameshot-pin.flameshot;

          dolphin-emu = unstable.dolphin-emu;
          evolution   = unstable.evolution;
          nushell     = unstable.nushell;
          ghostty     = unstable.ghostty;
        };

        pkgs = nixpkgs.legacyPackages.${system}.extend overlay;
        modules = ./modules;
      in

      {

        myModules = modules;

        homeConfigurations."cyberdruga" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
          extraSpecialArgs = {
            inherit neovim-config
                    unstable
                    zen-browser
                    extensions
                    ;jujutsu = jujutsu-repo;
          };

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [ 
            ./home.nix
            modules
          ];

        };
    });
}
