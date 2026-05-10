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
    import-tree.url = "github:vic/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
