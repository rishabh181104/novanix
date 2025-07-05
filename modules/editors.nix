{ config , pkgs, ... }:
{
  environment.systemPackages = with pkgs ; [
    code-cursor
      zed-editor
      vim 
      neovim
      wget
      fzf
      gnumake
      unzip
      shellcheck
  ];
}
