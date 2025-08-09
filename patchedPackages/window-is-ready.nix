{
	pkgs ? import <nixpkgs> {},
	...
}:

pkgs.gnomeExtensions.window-is-ready-remover.overrideAttrs {
	postInstall = /*bash*/ ''
		cd $out/share/gnome-shell/extensions/windowIsReady_Remover@nunofarruca@gmail.com
		${pkgs.nushell}/bin/nu -c "open metadata.json | update shell-version { \$in ++  [ \"48\"] } | save metadata.json --force "
	'';
}
