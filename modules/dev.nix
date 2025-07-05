{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs ; [
    python3Full
      nodejs_24
      go
      pipx
      python313Packages.pip
      python313Packages.virtualenv
      typescript-language-server
      vscode-langservers-extracted
      pyright
      sqls
      prettier
      lua-language-server
      stylua
      llvmPackages_20.libcxxClang
      astyle
      jdt-language-server
      python313Packages.debugpy
      vimPlugins.vim-ipython
      rPackages.autoimport
      python313Packages.black
      postgresql
      gdb
      shfmt
      cargo
      rustc
      rust-analyzer
      rustfmt
      ];
}
