{ config, pkgs, ... }: 

{
  services = {
    picom.enable = true;
    libinput.enable = true;
    openssh.enable = true;
    udev.packages = with pkgs; [ libmtp ];
    udisks2.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
  security.polkit.enable = true;
  programs.ssh.startAgent = true;
}
