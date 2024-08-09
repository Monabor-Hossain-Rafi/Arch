mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkswap /dev/sda3
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/nvme0n1p7
lsblk
pacstrap -i /mnt base base-devel linux linux-headers linux-firmware amd-ucode sudo git nano vim neofetch htop cmake make bluez bluez-utils networkmanager cargo gcc mpv
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
