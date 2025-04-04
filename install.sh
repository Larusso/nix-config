sudo nix --extra-experimental-features nix-command --extra-experimental-features flakes run 'github:nix-community/disko/latest#disko-install' -- --write-efi-boot-entries --flake 'github:Larusso/nix-config/main#nixos-vm' --disk main /dev/vda


cd /tmp

nix --extra-experimental-features nix-command --extra-experimental-features flakes flake init --template github:nix-community/disko-templates#single-disk-ext4

# or
sudo curl https://raw.githubusercontent.com/Larusso/nix-config/refs/heads/main/hosts/nixos-vm/disko-config.nix -o disko-config.nix

# adjust disko.nix

# USAGE in your configuration.nix.
# Update devices to match your hardware.
# {
#  imports = [ ./disko-config.nix ];
#  disko.devices.disk.main.device = "/dev/sda";
# }
# {
#   disko.devices = {
#     disk = {
#       main = {
#         type = "disk";
#         device = "/dev/vda";
#         content = {
#           type = "gpt";
#           partitions = {
#             boot = {
#               size = "1M";
#               type = "EF02"; # for grub MBR
#             };
#             ESP = {
#               size = "1G";
#               type = "EF00";
#               content = {
#                 type = "filesystem";
#                 format = "vfat";
#                 mountpoint = "/boot";
#                 mountOptions = [ "umask=0077" ];
#                 extraArgs = ["-n" "nixos-boot" "-i" "0x43589196"];
#               };
#             };
#             root = {
#               size = "100%";
#               content = {
#                 type = "filesystem";
#                 format = "ext4";
#                 mountpoint = "/";
#                 extraArgs = ["-L" "nixos-root" "-U" "f72e337d-0800-47bf-9e7d-3e3a6b6c2c54" ];
#               };
#             };
#           };
#         };
#       };
#     };
#   };
# }



sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disko-config.nix

# create hardware configuration file
sudo nixos-generate-config --no-filesystems --root /mnt

# move disko config to new nix configuration
sudo cp /tmp/disko-config.nix /mnt/etc/nixos

sudo nixos-install --root /mnt --flake 'github:Larusso/nix-config/main#nixos-vm' --no-write-lock-file


sudo mount -t virtiofs share /path/to/shares