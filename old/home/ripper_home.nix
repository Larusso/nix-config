{ config, pkgs, ... }:
{
  programs.home-manager.enable=true;
  home.stateVersion = "24.11";
  
  imports = [
    ./theme/britannia.nix
    ./role/linux/xmonad/default.nix
    ./role/linux/i3.nix
    ./user/larusso
    ./machine/ripper
  ];

  home.packages = [
    pkgs.yubikey-manager-qt
    pkgs.yubikey-manager
    pkgs.via
  ];
}

