{pkgs, unstable, neovim-config, zen-browser, ...}:

{
  home.packages = with pkgs; [

    bitwarden-desktop
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
    pavucontrol

    zen-browser.twilight 

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

  ];
}
