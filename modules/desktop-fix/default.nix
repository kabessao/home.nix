{lib, config, pkgs, ... }:
let
  self = config.desktop-fix;
in 
{

  options.desktop-fix = {
    enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Enables a set of fixes to correctly display new packages being installed";
    };
  };
  
  config = lib.mkIf self.enable {

    systemd.user.services.reset-desktop = {
      Unit = {
        Description = "Reset desktop entries";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        ExecStart = "${pkgs.callPackage ./reset-desktop.nix {path = config.home.homeDirectory;} }";
      };
    };

    home.activation = lib.mkAfter {
      linkDesktopApplications = {
        after = ["writeBoundary" "createXdgUserDirectories"];
        before = [];
        data = /*bash*/ ''
          (
            rm -rf ${config.home.homeDirectory}/.local/share/applications/home-manager
            rm -rf ${config.home.homeDirectory}/.icons/nix-icons
            mkdir -p ${config.home.homeDirectory}/.local/share/applications/home-manager
            mkdir -p ${config.home.homeDirectory}/.icons
            ln -sf ${config.home.homeDirectory}/.nix-profile/share/icons ${config.home.homeDirectory}/.icons/nix-icons

            # Check if the cached desktop files list exists
            if [ -f ${config.home.homeDirectory}/.cache/current_desktop_files.txt ]; then
              current_files=$(cat ${config.home.homeDirectory}/.cache/current_desktop_files.txt)
            else
              current_files=""
            fi

            # Symlink new desktop entries
            for desktop_file in ${config.home.homeDirectory}/.nix-profile/share/applications/*.desktop; do
              if ! echo "$current_files" | grep -q "$(basename $desktop_file)"; then
                ln -sf "$desktop_file" ${config.home.homeDirectory}/.local/share/applications/home-manager/$(basename $desktop_file)
              fi
            done

            # Update desktop database
            ${pkgs.desktop-file-utils}/bin/update-desktop-database ${config.home.homeDirectory}/.local/share/applications

            ${pkgs.coreutils}/bin/date > ${config.home.homeDirectory}/activationTest
            echo "no lib.mkAfter" >> ${config.home.homeDirectory}/activationTest
          )
        '';
      };
    };

  };


}
