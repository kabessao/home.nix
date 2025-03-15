{pkgs, lib, config, ...}:
let 
	self = config.mybash.blesh;
in
{
	options.mybash.blesh = {

		enable = lib.mkOption {
			default = false;
			type = lib.types.bool;
			description = "Enables my personal Blesh configuration";
		};

		extraConfig = lib.mkOption {
			default = "";
			type = lib.types.string;
			description = "Extra options for Blesh";
		};

		vimMode.enable = lib.mkOption {
			default = true;
			type = lib.types.bool;
			description = "Enables Vim mode in Blesh";
		};

	};

	config = lib.mkIf self.enable {

		home.packages = [pkgs.blesh]; 

		programs.bash = {
			bashrcExtra = lib.mkAfter ''
				# blesh
				if [[ "$TERM_PROGRAM" != "vscode" ]] ; then
					source `blesh-share`/ble.sh
					${lib.optionalString self.vimMode.enable ''
						set -o vi
						bind 'set keyseq-timeout 1'

						# Cursor configuration to be more like vim
						ble-bind -m vi_nmap --cursor 2
						ble-bind -m vi_imap --cursor 5
						ble-bind -m vi_omap --cursor 4
						ble-bind -m vi_xmap --cursor 2
						ble-bind -m vi_cmap --cursor 0
					''}
					# ble-bind -m 'auto_complete' -f C-i auto_complete/insert-on-end
					# ble-bind -m 'auto_complete' -f TAB auto_complete/insert-on-end
					ble-import -d integration/fzf-completion
					ble-import -d integration/fzf-key-bindings
					bleopt complete_limit_auto=190
					${self.extraConfig}
				fi
			'';
		};
	};
	
}

