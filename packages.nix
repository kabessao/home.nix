{pkgs, unstable, ...}:

{
  home.packages = with pkgs; [

    hollywood
    gamemode
    gamescope
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

    prismlauncher

    krita
    
    chatterino2

    (writeScriptBin "get-comments" ''
      ${yt-dlp}/bin/yt-dlp --write-comments --no-download $@
    '')

  ];
}
