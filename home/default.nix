{ config, pkgs, ... }:

{
  imports = [
    ./user/larusso
    ./theme/britannia.nix
    ./role/linux/i3.nix
    ./programs.nix
  ];

  home.packages = [
    pkgs.yubikey-manager-qt
    pkgs.yubikey-manager
    pkgs.via
  ];

  programs.home-manager.enable=true;
  home.stateVersion = "24.11";

}