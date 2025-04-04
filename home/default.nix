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
    pkgs.import-ssh-key
  ];

  programs.home-manager.enable=true;
  home.stateVersion = "24.11";

}