{
pkgs ? import<nixpkgs> {},
...
}:

pkgs.stdenv.mkDerivation {
	pname = "chatterino2";
	name = "chatterino2";
	src = "${pkgs.chatterino2}";
	
	buildPhase = ''
		cp -r $src $out

		substituteInPlace $out/share/applications/com.chatterino.chatterino.desktop \
			--replace "Exec=chatterino" "Exec=env QT_QPA_PLATFORM=xcb chatterino" # fixes freeze happening in PaperWM

	'';
}
