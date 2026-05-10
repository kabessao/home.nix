{ ... }:
{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.reset-desktop =
        with pkgs;
        resholve.writeScript "reset-desktop"
          {
            inputs = [ coreutils ];
            interpreter = "${bash}/bin/bash";
          }
          ''
            	rm -rf "$HOME/.local/share/applications/home-manager"
            	rm -rf "$HOME/.icons/nix-icons"
            	ls "$HOME/.nix-profile/share/applications/*.desktop" > "$HOME/.cache/current_desktop_files.txt"
          '';
    };
}
