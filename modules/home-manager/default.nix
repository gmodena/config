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
    stateVersion = "21.11";
    packages = with pkgs; [
      ls-colors
      rustup
      pipenv
      pkg-config
      sshuttle
      nixpkgs-fmt
      gnupg
      jq
      wget
      cachix
      direnv
      scc
      unzip
    ];
  };
  programs.git = {
    enable = true;
    extraConfig = {
      core.editor = "vim";
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
  programs.bat.enable = true;
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ../dotfiles/nvim/init.vim;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      coc-nvim
      coc-rust-analyzer
      vim-scala
      vim-nix
      rust-vim
      gruvbox
    ];
    extraPython3Packages = (ps: with ps; [
      jedi
      black
      flake8
    ]);
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ls = "ls --color=auto -F";
    };

    initExtra = ''
       # Load vcs_info function for git status
      autoload -Uz vcs_info
      
      # Enable checking for staged, unstaged, and untracked changes
      zstyle ':vcs_info:*' check-for-changes true
      zstyle ':vcs_info:*' unstagedstr '!'
      zstyle ':vcs_info:*' stagedstr '+'
      
      # Format the git info that will appear in prompt
      zstyle ':vcs_info:git:*' formats '%F{yellow}(%b%u%c)%f '
      zstyle ':vcs_info:git:*' actionformats '%F{yellow}(%b|%a%u%c)%f '
      
      # Enable prompt string substitution
      setopt PROMPT_SUBST
      
      # Run vcs_info before each prompt display
      precmd() { 
        vcs_info 
      }
      
      PROMPT='%F{green}%n@%m%f:%F{blue}%~%f ''${vcs_info_msg_0_}%# '
    '';

    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
      share = true;
    };

    initExtraBeforeCompInit = ''
      eval $(${pkgs.coreutils}/bin/dircolors -b ${../home/LS_COLORS})
      eval "$(direnv hook zsh)"
        
      # Enable emacs-style line navigation
      bindkey '^A' beginning-of-line        # Ctrl+A: Move to beginning of line
      bindkey '^E' end-of-line              # Ctrl+E: Move to end of line
      
      # Use Alt+F and Alt+B for word navigation
      bindkey '^[f' forward-word            # Alt+f: Move forward one word
      bindkey '^[b' backward-word      

      # Bind Ctrl+R to history search
      bindkey '^R' history-incremental-search-backward
      
      bindkey '^[[A' up-line-or-search    # Up arrow for history search
      bindkey '^[[B' down-line-or-search  # Down arrow for history search

    '';
  };
  xdg.configFile."nvim/coc-settings.json".text = builtins.readFile ../dotfiles/nvim/my-coc-settings.json;
}
