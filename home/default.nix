{ config, pkgs, ... }:

{
  imports = [
    ./user/larusso
    ./theme/britannia.nix
    ./theme/wallpaper.nix
    ./role/linux/i3.nix
    ./programs.nix
  ];

  home.packages = [
    pkgs.yubikey-manager-qt
    pkgs.yubikey-manager
  ];

  programs.home-manager.enable=true;
  home.stateVersion = "24.11";

}