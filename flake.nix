{
  description = "Home Manager configuration of cyberdruga";

  inputs = {

    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";

    # Separate repo for just gnome extensions
    extensions.url = "github:nixos/nixpkgs/1cb1c02a6b1b7cf67e3d7731cbbf327a53da9679"; 

    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    neovim-config.url = "github:kabessao/kickstart.nvim/nixCats";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, home-manager, flake-utils, ... }@args:
    flake-utils.lib.eachDefaultSystemPassThrough (system: 

      let
        pkgs = nixpkgs.legacyPackages.${system};
        unstable = args.unstable.legacyPackages.${system};
        zen-browser = args.zen-browser.packages.${system};
        neovim-config = args.neovim-config.packages.${system};
        extensions = args.extensions.legacyPackages.${system};
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
                    extensions;
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
