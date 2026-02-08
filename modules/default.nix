{ self, ... }:
{
  imports = [
    ./bash
    ./nushell
    ./desktop-fix
    ./gnome
    ./language
    ./essentials
    # ./niri
    ./tmux

  ];

  flake = {
    homeModules.myModules = {
      imports = [
        self.homeModules.myBash
        self.homeModules.myNushell
        self.homeModules.myDesktopFixes
        self.homeModules.myGnome
        self.homeModules.myLanguageConfig
        self.homeModules.myEssentials
        self.homeModules.myTmux
      ];
    };
  };

}
