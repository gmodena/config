{ inputs, config, pkgs, ... }:

let 
  homeDir = config.home.homeDirectory;
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
      path = "${config.home.homeDirectory}/.nixpkgs/modules/home-manager";
    };

    home = {
      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      stateVersion = "21.05";
      packages = with pkgs; [ls-colors cargo];
    };
    programs.git.enable = true;
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
    programs.zsh = {
      enable = true;
      shellAliases = {
        ls = "ls --color=auto -F";
      };
      initExtraBeforeCompInit = ''
      eval $(${pkgs.coreutils}/bin/dircolors -b ${./home/LS_COLORS})
      '';
    };
    xdg.configFile."nvim/coc-settings.json".text = builtins.readFile ./dotfiles/nvim/my-coc-settings.json;
}
