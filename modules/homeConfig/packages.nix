{ ... }:
{
  flake.homeModules.extraPackages =
    { pkgs, ... }:
    {

      nixpkgs.config.allowUnfree = true;
      home.packages = with pkgs; [
        hollywood
        gamemode
        clonehero
        bottles
        go
        playwright-driver
        hmcl
        kdePackages.kdenlive
        speedtest-cli
        yt-dlp
        translate-shell
        oversteer
        mangohud
        # nvtopPackages.nvidia
        protontricks
        sshfs
        gnome-boxes
        twitch-cli
        gcc
        stremio-linux-shell
        prismlauncher
        krita
        (writeScriptBin "get-comments" ''
          ${yt-dlp}/bin/yt-dlp --write-comments --no-download $@
        '')

      ];
    };
}
