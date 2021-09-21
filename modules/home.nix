{ inputs, config, pkgs, ... }:
let 
    homeDir = "/Users/gmodena";
    LS_COLORS = pkgs.fetchgit {
      url = "https://github.com/trapd00r/LS_COLORS";
      rev = "6fb72eecdcb533637f5a04ac635aa666b736cf50";
      sha256 = "0czqgizxq7ckmqw9xbjik7i1dfwgc1ci8fvp1fsddb35qrqi857a";
    };
    ls-colors = pkgs.runCommand "ls-colors" { } ''
      mkdir -p $out/bin $out/share
      ln -s ${pkgs.coreutils}/bin/ls $out/bin/ls
      ln -s ${pkgs.coreutils}/bin/dircolors $out/bin/dircolors
      cp ${LS_COLORS}/LS_COLORS $out/share/LS_COLORS
      '';
  in
  {
    programs.home-manager = {
      enable = true;
#     path = "${homeDir}/.nixpkgs/modules/home-manager";
    };


    home.packages = [pkgs.cargo ls-colors];
    programs.bat.enable = true;
    programs.neovim = {
      enable = true;
      vimAlias = true;
      extraConfig = "colorscheme gruvbox";
      withPython3 = true;
      plugins = with pkgs.vimPlugins; [
        coc-nvim
        coc-python
        vim-nix
        gruvbox
      ];
      extraPackages = with pkgs; [
        (python3.withPackages (ps: with ps; [
          black
          flake8
        ]))
      ];
      extraPython3Packages = (ps: with ps; [
        jedi
      ]);
    };
    xdg.configFile."nvim/coc-settings.json".text = builtins.readFile /Users/gmodena/nvim/my-coc-settings.json;

    home.stateVersion = "21.05";
}
