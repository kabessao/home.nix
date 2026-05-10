{ self, moduleWithSystem, ... }:
{

  flake.homeModules.allModules =
    { ... }:
    {
      imports = [ self.homeModules.myNushell ];
    };

  flake.homeModules.myNushell = moduleWithSystem (
    { inputs', ... }:
    {
      lib,
      config,
      ...
    }:
    let
      this = config.mynushell;
    in
    {

      imports = with self.homeModules; [
        myNushellFzf
        myNushellRanger
      ];

      options.mynushell = {

        enable = lib.mkOption {
          default = true;
          type = lib.types.bool;
          description = "Enables my custom configuration of Nushell";
        };

        package = lib.mkOption {
          default = inputs'.unstable.legacyPackages.nushell;
          type = lib.types.package;
          description = "Package to be used. Default is from the Unstable branch";
        };

        cdw.workspaceFolder = lib.mkOption {
          default = "~/";
          type = lib.types.str;
          description = "Folder where the workspace is located.";
        };

      };

      config = lib.mkIf config.mynushell.enable {

        mynushell.ranger.enable = lib.mkDefault true;
        mynushell.fzf.enable = lib.mkDefault true;

        programs.nushell = {
          enable = true;
          package = this.package;

          extraConfig = lib.mkAfter ''
            # Navigates back until it reaches the root of a git repository
            # if none is found it goes to ${this.cdw.workspaceFolder}
            def --env cdw []: nothing -> nothing  {
              if (git status | complete | get exit_code) == 0 {
                cd (git rev-parse --show-toplevel)
              } else {
                cd ${this.cdw.workspaceFolder}
              }
            }
          '';

          shellAliases = {
            o = "xdg-open";
            ta = "if ((tmux attach | complete | get exit_code) == 1) { tmux }";
            lz = "lazygit";
          };
        };
      };
    }
  );
}
