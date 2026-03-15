{
  description = "Home Manager configuration of cyberdruga";

  inputs = {

    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flameshot-pin.url = "nixpkgs/b60793b86201040d9dee019a05089a9150d08b5b";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    neovim-config.url = "github:CyberDruga/neovim.nix";
    jujutsu.url = "github:jj-vcs/jj";
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      flake-parts,
      ...
    }@inputs:

    flake-parts.lib.mkFlake { inherit inputs; } {

      systems = [ "x86_64-linux" ];

      imports = [
        home-manager.flakeModules.home-manager
        ./customPackages
        ./packages.nix
        ./modules
      ];

      flake = {
        homeConfigurations.cyberdruga = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          modules = [
            ./home.nix
            self.homeModules.myModules
            self.homeModules.extraPackages
          ];
        };
      };
    };
}
