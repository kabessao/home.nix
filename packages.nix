{pkgs, unstable, neovim-config, zen-browser, ...}:

{
  home.packages = with pkgs; [

    hollywood
    nvtopPackages.full
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
    youtube-music
    yt-dlp
    translate-shell

    gnomeExtensions.gsconnect
    gnomeExtensions.pano

    (callPackage ./chatterino2 {})

    unstable.ghostty

    (nerdfonts.override { fonts = [ "DroidSansMono" ]; })

    (writeScriptBin "get-comments" ''
      ${yt-dlp}/bin/yt-dlp --write-comments --no-download $@
    '')

  ];
}
