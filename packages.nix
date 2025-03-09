{pkgs, unstable, neovim-config, ...}:

{
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
    onlyoffice-desktopeditors
    easyeffects
    youtube-music
    dconf-editor
    yt-dlp
    obsidian

    gnomeExtensions.gsconnect
    gnomeExtensions.pano

    (callPackage ./chatterino2 {})

    unstable.ghostty

    (nerdfonts.override { fonts = [ "DroidSansMono" ]; })

    (writeShellScriptBin "nv" ''
      ${neovim}/bin/nvim -u "${neovim-config}/init.lua $@"
    '')

    (resholve.writeScriptBin "get-comments" {
      inputs = [ yt-dlp ];
      interpreter = "${bash}/bin/bash";
      execer = [
        "cannot:${yt-dlp}/bin/yt-dlp"
      ];
    }''
      yt-dlp --write-comments --no-download $@
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
}
