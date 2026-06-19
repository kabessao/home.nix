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

        home.file = {
          # ".tmux.conf".source = ./tmux.conf;
          ".tmux.conf".text = ''

            set -g terminal-overrides 'xterm*:smcup@:rmcup@'
            set -g mouse on

            set-window-option -g mode-keys vi

            bind -N "Split window horizontally" h split-window -h -c "#{pane_current_path}" 
            bind -N "Split window vertically" v split-window -v -c "#{pane_current_path}" 
            bind -N "Create new window" c new-window -c "#{pane_current_path}" 
            bind-key -N "Begin selection" -T copy-mode-vi v send-keys -X begin-selection 
            bind-key -N "Begin block selection" -T copy-mode-vi C-v run-shell "tmux send-keys -X rectangle-on ; tmux send-keys -X begin-selection"

            bind -N "Select the pane up" -r C-k select-pane -U 
            bind -N "Select the pane down" -r C-j select-pane -D 
            bind -N "Select the pane to the left" -r C-h select-pane -L 
            bind -N "Select the pane to the right" -r C-l select-pane -R 

            bind -N "Next layout" -r C-Space next-layout 
            bind -N "Goto next window" -r C-n next-window 
            bind -N "Goto previous window" -r C-p previous-window 

            # bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -i -f -selection primary | xclip -i -selection clipboard"
            bind -N "Copy text" -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -i -f -selection primary | xclip -i -selection clipboard" 
            bind -N "Exit from selection mode" -T copy-mode-vi Escape send-keys -X cancel 
            bind -N "Clear Selection" -T copy-mode-vi Space run-shell "tmux send-keys -X clear-selection ; tmux send-keys -X rectangle-off"

            bind -N "Copy with mouse" -T copy-mode MouseDragEnd1Pane send -X copy-selection-no-clear 'pbcopy' 
            unbind -T copy-mode-vi MouseDragEnd1Pane 

            # Plugins
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
