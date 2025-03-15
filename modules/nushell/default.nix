{pkgs, lib, config, unstable, ...}:
let
	self = config.mynushell;
in
{
	imports = [
		./fzf.nix
		./ranger.nix
	];

	options.mynushell = {

		enable = lib.mkOption {
			default = true;
			type = lib.types.bool;
			description = "Enables my custom configuration of Nushell";
		};

		package = lib.mkOption {
			default = unstable.nushell;
			type = lib.types.package;
			description = "Package to be used. Default is from the Unstable branch";
		};

	};

	config = lib.mkIf config.mynushell.enable {

		mynushell.ranger.enable = lib.mkDefault true;
		mynushell.fzf.enable = lib.mkDefault true;
		
		programs.nushell = {
			enable = true;
			package = self.package;

			shellAliases = {
				o = "xdg-open";
				ta = "if ((tmux attach | complete | get exit_code) == 1) { tmux }";
				lz = "lazygit";
			};
		};
	};
}

