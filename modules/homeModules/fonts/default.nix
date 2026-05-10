{ self, ... }:
{

  flake.homeModules.allModules =
    { ... }:
    {
      imports = [ self.homeModules.myFontsFix ];
    };

  flake.homeModules.myFontsFix =
    { ... }:
    {
      home.file = {
        ".config/fontconfig/fonts.conf".source = ./fonts.conf;
      };
    };
}
