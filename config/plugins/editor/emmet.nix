{ ... }: {
  plugins.lsp.servers.emmet_ls = {
    enable = true;
    filetypes = [
      "html" "css" "javascript" "javascriptreact"
      "typescript" "typescriptreact"
    ];
  };
}
