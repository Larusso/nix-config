USAGE in your configuration.nix.
Update devices to match your hardware.
{
 imports = [ ./disko-config.nix ];
 disko.devices.disk.main.device = "/dev/sda";
}
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02"; # for grub MBR
            };
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
                extraArgs = ["-n" "nixos-boot" "-i" "0x43589196"];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                extraArgs = ["-L" "nixos-root" "-U" "f72e337d-0800-47bf-9e7d-3e3a6b6c2c54" ];
              };
            };
          };
        };
      };
    };
  };
}