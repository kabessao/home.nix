{
pkgs ? import <nixpkgs> {},
path ? builtins.toString ./.,
... 
}:


with pkgs; resholve.writeScript "reset-desktop" {
	inputs = [ coreutils ];
	interpreter = "${bash}/bin/bash";
} ''
	rm -rf ${path}/.local/share/applications/home-manager
	rm -rf ${path}/.icons/nix-icons
	ls ${path}/.nix-profile/share/applications/*.desktop > ${path}/.cache/current_desktop_files.txt
''
