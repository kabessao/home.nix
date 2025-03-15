{pkgs, lib, config, ... }:
let
  self = config.mygnome;
in 
{
	imports = [
		../desktop-fix
	];

	options.mygnome = {
		enable = lib.mkOption {
			default = false;
			type = lib.types.bool;
			description = "Enable my Gnome configurations";
		};
	};

	config = lib.mkIf self.enable {
		
		desktop-fix.enable = lib.mkDefault true;

		gtk = {
			enable = true;
			gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
		};

		dconf = {
			settings = {
				"org/gnome/desktop/interface".color-scheme = "prefer-dark";
			};
		};

		qt = {
			enable = true;
			platformTheme.name = "adwaita-dark";
			style.name = "adwaita-dark";
		};

	};
}
