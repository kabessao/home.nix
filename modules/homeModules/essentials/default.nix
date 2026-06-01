{ moduleWithSystem, self, ... }:
{

  flake.homeModules.allModules =
    { ... }:
    {
      imports = [ self.homeModules.myEssentials ];
    };

  flake.homeModules.myEssentials = moduleWithSystem (
    { self', inputs', ... }:
    {
      pkgs,
      lib,
      config,
      ...
    }:

    let

      utils = import "${pkgs.path}/nixos/lib/utils.nix" {
        inherit config lib;
        pkgs = null;
      };

      self = config.myessentials;
      packages =
        with pkgs;
        [
          thunderbird
          bitwarden-desktop
          lazygit
          firefox
          vesktop
          ferdium
          headsetcontrol
          gnome-tweaks
          chromium
          gnome-extension-manager
          xclip
          jq
          podman
          unzip
          obs-studio
          distrobox
          ripgrep
          steam-run
          libnotify
          openvpn
          gum
          onlyoffice-desktopeditors
          easyeffects
          dconf-editor
          obsidian
          pavucontrol
          vlc
          youtube-music

          (writeShellScriptBin "nixwhere" ''
            which $@ | xargs -I {} readlink -f {}
          '')
        ]
        ++ (with inputs'.neovim-config.packages; [
          nvim
        ])
        ++ (with inputs'.zen-browser.packages; [
          twilight
        ])
        ++ (with inputs'.unstable.legacyPackages; [
          ghostty
          jujutsu
        ])
        ++ (with inputs'.flameshot-pin.legacyPackages; [
          flameshot
        ]);
    in

    {
      options.myessentials = {

        enable = lib.mkOption {
          default = true;
          type = lib.types.bool;
          description = "Install essential packages";
        };

        excludePackages = lib.mkOption {
          default = [ ];
          example = lib.literalExpression "[ pkgs.vscode ]";
          type = lib.types.listOf lib.types.package;
          description = "Packages to remove from the list";
        };

      };

      config = lib.mkIf self.enable {

        programs.direnv = {
          enable = true;
          enableBashIntegration = true;
          nix-direnv.enable = true;
        };

        programs.zoxide = {
          enable = true;
          enableBashIntegration = true;
        };

        nixpkgs.config.allowUnfree = true;

        nix = {
          package = lib.mkDefault pkgs.nix;
          settings.experimental-features = [
            "nix-command"
            "flakes"
          ];
        };

        home.packages = utils.removePackagesByName packages self.excludePackages;
      };
    }
  );
}
