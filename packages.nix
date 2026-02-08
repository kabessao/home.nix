{ pkgs, unstable, ... }:

{
  home.packages = with pkgs; [

    hollywood
    gamemode
    clonehero
    bottles
    go
    playwright-driver
    hmcl
    kdePackages.kdenlive
    dolphin-emu
    speedtest-cli
    stremio
    yt-dlp
    translate-shell
    oversteer
    mangohud
    nvtopPackages.nvidia
    protontricks
    sshfs
    evolution
    gnome-boxes
    twitch-cli
    colmena

    prismlauncher

    krita

    chatterino2

    (writeScriptBin "get-comments" ''
      ${yt-dlp}/bin/yt-dlp --write-comments --no-download $@
    '')

  ];
}
