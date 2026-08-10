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
        podman-compose
        protontricks
        sshfs
        gnome-boxes
        twitch-cli
        gcc
        prismlauncher
        krita
        opencode
        (writeScriptBin "get-comments" ''
          ${yt-dlp}/bin/yt-dlp --write-comments --no-download $@
        '')

      ];
    };
}
