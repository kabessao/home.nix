{ self, ... }:
{

  flake.homeModules.allModules =
    { ... }:
    {
      imports = [ self.homeModules.myThumbnailsFix ];
    };

  flake.homeModules.myThumbnailsFix =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ffmpeg-headless
        ffmpegthumbnailer
      ];
    };
}
