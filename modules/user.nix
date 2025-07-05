{ config, pkgs, smsm, ... }:

{
  time.timeZone = smsm.timeZone;
  users.users.${smsm.userName} = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "kvm" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
      fish
        brave
        google-chrome
        tree
        yafetch
      ];
  };
  environment.shells = with pkgs; [ bash zsh fish ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
}
