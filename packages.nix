{pkgs, unstable, neovim-config, zen-browser, ...}:

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
    kdenlive
    unstable.dolphin-emu
    speedtest-cli
    stremio
    yt-dlp
    translate-shell
    oversteer
    mangohud

    gnomeExtensions.gsconnect
    gnomeExtensions.pano

    (callPackage ./chatterino2 {pkgs = unstable;})

    (nerdfonts.override { fonts = [ "DroidSansMono" ]; })

    (writeScriptBin "get-comments" ''
      ${yt-dlp}/bin/yt-dlp --write-comments --no-download $@
    '')

  ];
}
