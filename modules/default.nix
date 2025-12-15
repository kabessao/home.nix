{ overlay, ... }: 
{

	nixpkgs.overlays = [
		overlay
	]
	;

	imports = [

		./bash
		./nushell
		./desktop-fix
		./gnome
		./language
		./essentials
		./niri
		./tmux

	];
}
