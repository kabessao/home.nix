{pkgs, lib, config, ...}:

{

	imports = [
		./blesh.nix
	];

	options.mybash = {
		enable = lib.mkOption {
			default = true;
			type = lib.types.bool;
			description = "Enables my personal bash configuration";
		};
	};

	config = lib.mkIf config.mybash.enable {

		programs.fzf = {
			enable = lib.mkDefault true;
			enableBashIntegration = lib.mkDefault true;
		};

		mybash.blesh.enable = lib.mkDefault true;

		programs.bash = {
			enable = true;
			bashrcExtra = ''

				# User specific environment
				if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
				then
						PATH="$HOME/.local/bin:$HOME/bin:$PATH"
				fi
				export PATH

				cdw() { 
					git status 2> /dev/null > /dev/null \
						&& cd `git rev-parse --show-toplevel` \
						|| cd ~/workspace/
				}

			'';

			shellAliases = {
				r = ". ${pkgs.ranger}/bin/.ranger-wrapped";
				o = "xdg-open";
				ta = "tmux a || tmux";
				lz = "lazygit";
			};

		};
	};
}


