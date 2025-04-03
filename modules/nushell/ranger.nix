{pkgs, lib, config, ...}: 
let 
	self = config.mynushell.ranger;
in
{
	options.mynushell.ranger = {

		enable = lib.mkOption {
			default = false;
			type = lib.types.bool;
			description = "Enable my configurations for ranger in Nushell";
		};

		package = lib.mkOption {
			default = pkgs.ranger;
			type = lib.types.package;
			description = "Ranger package to be used";
		};

	};

	config = lib.mkIf self.enable {
		
		programs.nushell = {

			extraConfig = with pkgs; lib.mkAfter ''
				# Navigates through folders using ranger.
				# Drops you in the same folder you had open before quitting
				def --env --wrapped r [...args]: nothing -> nothing {
					let temp_file = (mktemp -t "ranger_cd.XXXXXXXXXX")
					${ranger}/bin/ranger --choosedir $temp_file ...$args
					cd (cat $temp_file)
					rm -rf $temp_file
				}
				'';

		};

	};
}
