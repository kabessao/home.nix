{
	pkgs, 
	lib,
	config,
	...
}:

{
	options.mytmux = {
		enable = lib.mkOption {
			default = true;
			type = lib.types.bool;
			description = "Enables my tmux configuration";
		};
	};

	config = lib.mkIf config.mytmux.enable {

		programs.tmux = {
			enable = lib.mkDefault true;
			extraConfig = (builtins.readFile ./tmux.conf);
		};

	};
}
