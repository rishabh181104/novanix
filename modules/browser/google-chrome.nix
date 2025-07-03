{ pkgs, ... }:

{
# Module installing brave as default browser
  home.packages = [ pkgs.google-chrome ];

  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.google-chrome}/bin/google-chrome";
  };

}
