{ moduleWithSystem, ... }:
{
  flake.homeModules.myEssentials = moduleWithSystem ({self', ...}: 
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
      packages = with pkgs; [

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
		] ++ (with self'.packages;[
        flameshot
        ghostty
        jujutsu
        zen-browser
        nvim
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

        home.packages = utils.removePackagesByName packages self.excludePackages;
      };
    });
}
