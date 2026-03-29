{
  config,
  pkgs,
  ...
}: {
  programs.neovim.enable = true;
  programs.nvf = {
    enable = true;
    settings = {
      vim.viAlias = true;
      vim.vimAlias = true;
      vim.statusline.lualine.enable = true;
      vim.autocomplete.nvim-cmp.enable = true;

      vim.lsp = {
        enable = true;
        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = true;
        lspsaga.enable = false;
        trouble.enable = true;
        lspSignature.enable = true;
      };

      vim.languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.enable = true;
        markdown.enable = true;

        bash.enable = true;
        clang.enable = true;
        cmake.enable = true;
        css.enable = true;
        html.enable = true;
        json.enable = true;
        sql.enable = true;
        java.enable = true;
        typescript.enable = true;
        go.enable = true;
        lua.enable = true;
        zig.enable = true;
        python.enable = true;
        rust = {
          enable = true;
          extensions.crates-nvim.enable = true;
        };
        toml.enable = true;
        xml.enable = true;

        assembly.enable = true;
        scala.enable = true;
        glsl.enable = true;
        ocaml.enable = true;
        just.enable = true;
        make.enable = true;
        jinja.enable = true;
        jq.enable = true;
      };

      vim.snippets.luasnip.enable = true;

      vim.autopairs.nvim-autopairs.enable = true;
      vim.comments.comment-nvim.enable = true;

      vim.filetree.nvimTree.enable = true;

      vim.tabline.nvimBufferline.enable = true;

      vim.visuals = {
        nvim-cursorline.enable = true;
        indentBlankline.enable = true;
        rainbow-delimiters.enable = true;
      };

      vim.git = {
        vim-fugitive.enable = true;
        gitsigns = {
          enable = true;
          codeActions.enable = true;
        };
      };

      vim.telescope = {
        enable = true;
      };

      vim.terminal.toggleterm = {
        enable = true;
        lazygit.enable = true;
      };
    };
  };
}
