{ moduleWithSystem, ... }:
{
  flake.homeModules.extraPackages = moduleWithSystem (
    {
      self',
      ...
    }:
    { pkgs, ... }:
    {

      nixpkgs.config.allowUnfree = true;
      home.packages =
        with pkgs;
        [
          ffmpeg-headless
          ffmpegthumbnailer
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
          thunderbird

          krita

          (writeScriptBin "get-comments" ''
            ${yt-dlp}/bin/yt-dlp --write-comments --no-download $@
          '')

        ]
        ++ (with self'.packages; [
          chatterino2
          gamescope
          colmena
          dolphin-emu
          freeJ2ME
        ]);
    }
  );
}
