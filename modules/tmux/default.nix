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
		continuum.enable = lib.mkOption {
			default = true;
			type = lib.types.bool;
			description = "Enables the continuum plugin";
		};
	};

	config = lib.mkIf config.mytmux.enable {

		programs.tmux = {

			enable = true;
			keyMode = "vi";
			mouse = true;

			extraConfig = ''
				bind h split-window -h -c "#{pane_current_path}" 
				bind v split-window -v -c "#{pane_current_path}" 
				bind c new-window -c "#{pane_current_path}" 
				bind-key -T copy-mode-vi v send-keys -X begin-selection

				bind -r C-k select-pane -U
				bind -r C-j select-pane -D
				bind -r C-h select-pane -L
				bind -r C-l select-pane -R

				# bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -i -f -selection primary | xclip -i -selection clipboard"
				bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -i -f -selection primary | xclip -i -selection clipboard"
				bind -T copy-mode-vi Escape send-keys -X cancel

				bind -T copy-mode MouseDragEnd1Pane send -X copy-selection-no-clear 'pbcopy'
				unbind -T copy-mode-vi MouseDragEnd1Pane 
			'';


			plugins = with pkgs.tmuxPlugins;[
				resurrect
				sensible
				resurrect
				(lib.mkIf config.mytmux.continuum.enable {
					plugin = continuum;
					extraConfig = "set -g @continuum-restore 'on'";
				})
				{
					plugin = (mkTmuxPlugin {
						pluginName = "themePack";
						version = "2019-12-22";
						src = pkgs.fetchFromGitHub {
							owner = "jimeh";
							repo = "tmux-themepack";
							rev = "7c59902f64dcd7ea356e891274b21144d1ea5948";
							hash = "sha256-c5EGBrKcrqHWTKpCEhxYfxPeERFrbTuDfcQhsUAbic4=";
						};
					});
					extraConfig = " set -g @themepack 'powerline/default/gray' ";
				}
			];
		};

	};
}
