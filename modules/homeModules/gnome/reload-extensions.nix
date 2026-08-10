{ moduleWithSystem, ... }:
{

  flake.homeModules.myGnome = moduleWithSystem (
    { self', ... }:
    { lib, config, ... }:
    {
      config = lib.mkIf config.mygnome.enable {
        home.packages = with self'.packages; [ reload-extensions ];
      };
    }
  );

  perSystem =
    { pkgs, ... }:
    {
      packages.reload-extensions = pkgs.writeShellApplication {
        name = "reload-extensions";
        runtimeInputs = [ pkgs.glib ];
        bashOptions = [ ];
        text = ''
          gsettings set org.gnome.shell disable-user-extensions true
          gsettings set org.gnome.shell disable-user-extensions false
        '';
      };
    };
}
