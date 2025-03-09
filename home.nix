{ pkgs, neovim-config, unstable, ... }:

{
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  dconf = {
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita-dark";
    style.name = "adwaita-dark";
  };

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


  imports = [
    ./desktop-fix
  ];


  nixpkgs.config.allowUnfree = true;

  programs.bash = {
    enable = true;
    bashrcExtra = ''

      # User specific environment
      if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
      then
          PATH="$HOME/.local/bin:$HOME/bin:$PATH"
      fi
      export PATH

      # Uncomment the following line if you don't like systemctl's auto-paging feature:
      # export SYSTEMD_PAGER=

      unset rc

      source ~/.mybashrc.sh

      [ -f ~/.fzf.bash ] && source ~/.fzf.bash
    '';
    shellAliases = {
      r = ". ${pkgs.ranger}/bin/.ranger-wrapped";
    };
  };

  targets.genericLinux.enable = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cyberdruga";
  home.homeDirectory = "/home/cyberdruga";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # environment.
  home.packages = with pkgs; [

    bitwarden-desktop
    blesh
    discordchatexporter-cli
    hollywood
    lazygit
    vesktop
    firefox
    kitty
    ferdium
    nvtopPackages.full
    headsetcontrol
    vlc
    desktop-file-utils
    gnome-tweaks
    chromium
    gnome-extension-manager
    xclip
    libgda
    gsound
    vscode
    gamemode
    gamescope
    flameshot
    obs-studio
    clonehero
    jq
    distrobox
    podman
    unzip
    bottles
    go
    ripgrep
    steam-run
    playwright-driver
    hmcl
    kdenlive
    libnotify
    unstable.dolphin-emu
    openvpn
    gum
    speedtest-cli
    stremio

    gnomeExtensions.gsconnect
    (callPackage ./gnome-pano {})

    (callPackage ./chatterino2 {})

    unstable.ghostty

    (pkgs.nerdfonts.override { fonts = [ "DroidSansMono" ]; })

    (pkgs.writeShellScriptBin "nv" ''
      ${neovim}/bin/nvim -u "${neovim-config}/init.lua $@"
    '')

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cyberdruga/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # systemd.user.timers."calendario" = {
  #   wantedBy = [ "timers.target" ];
  #     timerConfig = {
  #       OnBootSec = "5m";
  #       OnUnitActiveSec = "5m";
  #       # Alternatively, if you prefer to specify an exact timestamp
  #       # like one does in cron, you can use the `OnCalendar` option
  #       # to specify a calendar event expression.
  #       # Run every Monday at 10:00 AM in the Asia/Kolkata timezone.
  #       #OnCalendar = "Mon *-*-* 10:00:00 Asia/Kolkata";
  #       Unit = "calendario.service";
  #     };
  # };
  #
  # systemd.user.services."calendario" = {
  #   script = ''
  #     set -eu
  #     ${pkgs.coreutils}/bin/echo "Hello World"
  #   '';
  #   serviceConfig = {
  #     Type = "oneshot";
  #     User = "cyberdruga";
  #   };
  # };
  #

  xdg.mime.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
