{pkgs, unstable, neovim-config, ...}:

{
  home.packages = with pkgs; [

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
    nvtopPackages.nvidia
    protontricks

    (callPackage ./customPackages/cosmic-ext-alternative-startup.nix {} )
    
    gnomeExtensions.gsconnect
    gnomeExtensions.pano

    (callPackage ./chatterino2 {pkgs = unstable;})

    (writeScriptBin "get-comments" ''
      ${yt-dlp}/bin/yt-dlp --write-comments --no-download $@
    '')

  ];
}
