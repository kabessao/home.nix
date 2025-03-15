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
				def ranger-nu [] {
					let temp_file = (mktemp -t "ranger_cd.XXXXXXXXXX")
					${ranger}/bin/ranger --choosedir $temp_file
					let $temp_dir = (cat $temp_file)
					rm -rf $temp_file
					echo $temp_dir
				}
				'';

			shellAliases.r = ''cd (ranger-nu)'';
		};

	};
}
