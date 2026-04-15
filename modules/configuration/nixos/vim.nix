{config, pkgs, ...}:

{
programs.nvf = {
    enable = true;
    settings = {
      vim.viAlias = true;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = true;
        lspsaga.enable = false;
        trouble.enable = true;
        lspSignature.enable = true;
      #otter-nvim.enable = isMaximal;
      #nvim-docs-view.enable = isMaximal;
      #harper-ls.enable = isMaximal;
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
      ts.enable = true;
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


    };
  };
}
