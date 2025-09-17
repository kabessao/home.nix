{
pkgs,
lib,
config,
niri,
...
}:

let
  self = config.myniri;
in

{
	options.myniri = {

		enable = lib.mkOption {
			default = false;
			type = lib.types.bool;
			description = "Initiate my custom Niri config";
		};

		configFile = lib.mkOption {
			default = "";
			type = lib.types.str;
			description = "path to the config file";
		};
		
	};

	config = lib.mkIf self.enable {

		home.packages = with pkgs; [
			niri.niri
			(callPackage ./cosmic-ext-alternative-startup.nix {} )
		];

		home.file = 
			let
				path = assert lib.assertMsg (self.configFile != "") "You need to set the config path for Niri with myniri.configFile"; self.home ; 
			in
			{
				".config/niri/config.kdl".source = path;
			};

	};
}
