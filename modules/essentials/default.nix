{pkgs, zen-browser, lib, config, ...}:
let
  self = config.myessentials;
in
{
	options.myessentials = {
		enable = lib.mkOption {
			default = true;
			type = lib.types.bool;
			description = "Installed essential packages";
		};
	};

	config = lib.mkIf self.enable {
		home.packages = with pkgs; [

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

		];
	};
}
