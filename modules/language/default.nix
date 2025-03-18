{ lib, config, ...}:
let
  self = config.mylanguage;
in 
{
	options.mylanguage = {

		enable = lib.mkOption {
			default = true;
			type = lib.types.bool;
			description = "Enables my language configurations, which is a mix of pt-BR and en-US.";
		};

	};

	config = lib.mkIf self.enable {

		home.language = {
				base = "en_US.utf8";
				ctype = "en_US.utf8";
				numeric = "en_US.utf8";
				time = "pt_BR.UTF-8";
				collate = "en_US.utf8";
				monetary = "en_US.utf8";
				messages = "en_US.utf8";
				paper = "en_US.utf8";
				name = "en_US.utf8";
				address = "en_US.utf8";
				telephone = "en_US.utf8";
				measurement = "en_US.utf8";
		};

	};
}
