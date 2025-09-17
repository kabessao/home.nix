{ pkgs, config, ... }:

rec {

  imports = [
    ./packages.nix
    ./modules
  ];

  nixpkgs.config.allowUnfree = true;

  mygnome.enable = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  targets.genericLinux.enable = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cyberdruga";
  home.homeDirectory = "/home/cyberdruga";

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    ".fonts.conf".source = ./fonts.conf;

    ".config/niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${home.homeDirectory}/.config/home-manager/config/niri.kdl";

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
    NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1;
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

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

}
