{ config, pkgs, ... }:

{
  hardware.nvidia = {
    open = false;
  };
  environment.systemPackages = with pkgs ; [
    vulkan-loader
      vulkan-tools
  ];
}
