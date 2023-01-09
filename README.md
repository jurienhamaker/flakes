[![NixOS](https://github.com/JurienHamaker/nixos/actions/workflows/NixOS.yml/badge.svg)](https://github.con/JurienHamaker/nixos-config/actions/workflows/NixOS.yml)

<h2 align="center">JurienHamaker's NixOS Config</h2>

### Screenshot

![](https://user-images.githubusercontent.com/18376682/196764533-6d199f97-1402-47dc-b4c9-8ffd92e8de37.png)

### Structure

```
.
├── flake.lock
├── flake.nix
├── hosts
│   ├── default.nix
│   ├── laptop
│   └── system.nix
├── modules
│   ├── desktop
│   ├── devlop
│   ├── editors
│   ├── environment
│   ├── fonts
│   ├── hardware
│   ├── programs
│   ├── scripts
│   ├── shell
│   ├── theme
│   └── virtualisation
├── overlays
│   └── default.nix
├── pkgs
│   ├── catppuccin-cursors
│   ├── catppuccin-gtk
│   └── default.nix
└── README.md
```

## How to install ?(root on tmpfs)

0. Suppose I have divided two partitions `/dev/nvme0n1p1` `/dev/nvme0n1p3`
1. Format the partition

```bash
  mkfs.fat -F 32 /dev/nvme0n1p1
  mkfs.ext4 /dev/nvme0n1p3
```

2. Mount

```bash
  mount -t tmpfs none /mnt
  mkdir -p /mnt/{boot,nix}
  mount /dev/nvme0n1p3 /mnt/nix
  mount /dev/nvme0n1p1 /mnt/boot
```

3. Generate a basic configuration

```bash
  nixos-generate-config --root /mnt
```

4. Clone the repository locally

```bash
nix-shell -p git
git clone  https://github.com/Ruixi-rebirth/nixos-config.git /mnt/etc/nixos/Flakes
```

5. Copy `hardware-configuration.nix` from /mnt/etc/nixos to /mnt/etc/nixos/Flakes/hosts/laptop/hardware-configuration.nix

```bash
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/Flakes/hosts/laptop/hardware-configuration.nix
```

6. Modify the overwritten `hardware-configuration.nix`

```nix
...
#This is just an example
#Please refer to `https://elis.nu/blog/2020/05/nixos-tmpfs-as-root/#step-4-1-configure-disks`

fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=8G" "mode=755" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/b0f7587b-1eb4-43ad-b4a1-e6385b8511ae";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3C0D-7D32";
      fsType = "vfat";
    };
...
```

7. Go into the cloned repository and remove '/mnt/etc/nixos/Flakes/.git'

```bash
cd /mnt/etc/nixos/Flakes && rm -rf .git
```

8. Modify the login passwords of users _root_ and _ruixi_, use the hash password generated by the `mkpasswd -m sha-512` command to replace the value of `users.users.<name>.hashedPassword` in `/mnt/etc/nixos/Flakes/hosts/laptop/default.nix`
9. Perform install

```bash
nixos-install --no-root-passwd --flake .#laptop
```

10. Reboot

```bash
reboot
```

11. Enjoy it!
