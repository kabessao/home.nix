{
pkgs ? import<nixpkgs> {},
fetchFromGitHub ? pkgs.fetchFromGithub,
...
}:

pkgs.chatterino2.overrideAttrs (oldAttrs: rec {
		pname = "chatterino2";
		version = "2.5.2";
		src = fetchFromGitHub {
			owner = "Chatterino";
			repo = pname;
			rev = "v${version}";
			hash = "sha256-nrw4dQ7QjPPMbZXMC+p3VgUQKwc1ih6qS13D9+9oNuw=";
			fetchSubmodules = true;
		};
		patches = [ ./chatterino-nix.patch ];
})
