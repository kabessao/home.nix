{
pkgs,
zen-browser,
lib,
config,
unstable,
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
		vscode
		jq
		podman
		unzip
		flameshot
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
		zen-browser.twilight 
		unstable.ghostty
		youtube-music

		(writeShellScriptBin "nixwhere" ''
			which $@ | xargs -I {} readlink -f {}
		'')

		];
in

{
	options.myessentials = {

		programs.direnv = {
			enable = true;
			enableBashIntegration = true;
			nix-direnv.enable = true;
		};

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

		programs.zoxide = {
			enable = true;
			enableBashIntegration = true;
		}; 

		home.packages = utils.removePackagesByName packages self.excludePackages ; 
	};

}
