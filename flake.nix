{
  description = "Home Manager configuration of cyberdruga";

  inputs = {

    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";

    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-config = {
      url = "github:kabessao/kickstart.nvim";
      flake = false;
    };

  };

  outputs = { nixpkgs, home-manager, neovim-config, flake-utils, ... }@args:
    flake-utils.lib.eachDefaultSystemPassThrough (system: 
      let
        pkgs = nixpkgs.legacyPackages.${system};
        unstable = args.unstable.legacyPackages.${system};
      in
      {

        homeConfigurations."cyberdruga" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
          extraSpecialArgs = {
            inherit neovim-config;
            inherit unstable;
          };

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [ ./home.nix ];

        };
    });
}
