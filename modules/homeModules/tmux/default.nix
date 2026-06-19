{ self, ... }:
{

  flake.homeModules.allModules =
    { ... }:
    {
      imports = [ self.homeModules.myTmux ];
    };

  flake.homeModules.myTmux =
    {
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
        enableContinuum = lib.mkOption {
          default = true;
          type = lib.types.bool;
          description = "Enables the continuum plugin";
        };
        extraConfig = lib.mkOption {
          default = "";
          type = lib.types.str;
          description = "Extra Config";
        };
      };

      config = lib.mkIf config.mytmux.enable {

        # programs.tmux = {
        #
        # 	enable = true;
        # 	keyMode = "vi";
        # 	mouse = true;
        #
        # 	extraConfig = ''
        # 		bind h split-window -h -c "#{pane_current_path}"
        # 		bind v split-window -v -c "#{pane_current_path}"
        # 		bind c new-window -c "#{pane_current_path}"
        # 		bind-key -T copy-mode-vi v send-keys -X begin-selection
        #
        # 		bind -r C-k select-pane -U
        # 		bind -r C-j select-pane -D
        # 		bind -r C-h select-pane -L
        # 		bind -r C-l select-pane -R
        #
        # 		# bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -i -f -selection primary | xclip -i -selection clipboard"
        # 		bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -i -f -selection primary | xclip -i -selection clipboard"
        # 		bind -T copy-mode-vi Escape send-keys -X cancel
        #
        # 		bind -T copy-mode MouseDragEnd1Pane send -X copy-selection-no-clear 'pbcopy'
        # 		unbind -T copy-mode-vi MouseDragEnd1Pane
        #
        # 		set -g @themepack 'powerline/default/grey'
        # 	'';
        #
        # 	plugins = with pkgs.tmuxPlugins;[
        # 		resurrect
        # 		sensible
        # 		resurrect
        # 		# tmux-powerline
        # 		(lib.mkIf config.mytmux.continuum.enable {
        # 			plugin = continuum;
        # 			extraConfig = "set -g @continuum-restore 'on'";
        # 		})
        # 		(
        # 			mkTmuxPlugin {
        # 				pluginName = "themePack";
        # 				version = "2019-12-22";
        # 				src = pkgs.fetchFromGitHub {
        # 					owner = "jimeh";
        # 					repo = "tmux-themepack";
        # 					rev = "7c59902f64dcd7ea356e891274b21144d1ea5948";
        # 					hash = "sha256-c5EGBrKcrqHWTKpCEhxYfxPeERFrbTuDfcQhsUAbic4=";
        # 				};
        # 			}
        # 		)
        # 	];
        # };

        home.file = {
          # ".tmux.conf".source = ./tmux.conf;
          ".tmux.conf".text = ''

            set -g terminal-overrides 'xterm*:smcup@:rmcup@'
            set -g mouse on

            set-window-option -g mode-keys vi

            bind h split-window -h -c "#{pane_current_path}" 
            bind v split-window -v -c "#{pane_current_path}" 
            bind c new-window -c "#{pane_current_path}" 
            bind-key -T copy-mode-vi v send-keys -X begin-selection

            bind -r C-k select-pane -U
            bind -r C-j select-pane -D
            bind -r C-h select-pane -L
            bind -r C-l select-pane -R

            bind -r C-Space next-layout
            bind -r C-n next-window
            bind -r C-p previous-window

            # bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -i -f -selection primary | xclip -i -selection clipboard"
            bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -i -f -selection primary | xclip -i -selection clipboard"
            bind -T copy-mode-vi Escape send-keys -X cancel

            bind -T copy-mode MouseDragEnd1Pane send -X copy-selection-no-clear 'pbcopy'
            unbind -T copy-mode-vi MouseDragEnd1Pane 


            set -g @plugin 'jimeh/tmux-themepack'
            set -g @plugin 'tmux-plugins/tpm'
            set -g @plugin 'tmux-plugins/tmux-sensible'

            set -g @plugin 'tmux-plugins/tmux-resurrect'

            ${
              if config.mytmux.enableContinuum then
                ''
                  set -g @plugin 'tmux-plugins/tmux-continuum'
                  set -g @continuum-restore 'on'
                ''
              else
                ""
            }

            set -g @themepack 'powerline/default/purple'

            ${config.mytmux.extraConfig}

            run '~/.tmux/plugins/tpm/tpm'

          '';
        };

      };
    };
}
