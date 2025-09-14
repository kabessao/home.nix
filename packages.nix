{pkgs, unstable, neovim-config, zen-browser, ...}:
{pkgs, unstable, neovim-config, niri, ...}:

{
  home.packages = with pkgs; [

    niri.niri

    (pkgs.callPackage ./patchedPackages/window-is-ready.nix {} )

    hollywood
    gamemode
    gamescope
    clonehero
    bottles
    go
    playwright-driver
    hmcl
    kdePackages.kdenlive
    unstable.dolphin-emu
    speedtest-cli
    stremio
    yt-dlp
    translate-shell
    oversteer
    mangohud
    neovim-config.nvim

    (callPackage ./customPackages/cosmic-ext-alternative-startup.nix {} )
    
    gnomeExtensions.gsconnect
    gnomeExtensions.pano

    (callPackage ./chatterino2 {pkgs = unstable;})

    (writeScriptBin "get-comments" ''
      ${yt-dlp}/bin/yt-dlp --write-comments --no-download $@
    '')

  ];
}
