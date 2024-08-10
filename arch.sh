#!/bin/bash

# Set the console font for better readability
setfont ter-132n

# Assuming you have already connected to Wi-Fi manually

# Update the package database and install keyring
pacman -Sy
pacman -S --noconfirm archlinux-keyring

# Display current disk layout
lsblk

# Format the partitions
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkswap /dev/sda3

# Mount the partitions
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/sda3

# Confirm the partitions are mounted correctly
lsblk

# Install base system and essential packages
pacstrap -i /mnt base base-devel linux linux-headers linux-firmware amd-ucode sudo git nano vim neofetch htop cmake make bluez bluez-utils networkmanager cargo gcc mpv

# Generate the fstab file
genfstab -U /mnt >> /mnt/etc/fstab

# Change root into the new system
arch-chroot /mnt <<EOF_CHROOT

# Set the root password
echo "root:your_root_password" | chpasswd

# Create a new user
useradd -m -g users -G wheel,storage,video,audio -s /bin/bash sasuke
echo "sasuke:your_user_password" | chpasswd

# Configure sudoers
sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Set timezone
ln -sf /usr/share/zoneinfo/Asia/Dhaka /etc/localtime
hwclock --systohc

# Generate locale
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Set hostname
echo "arch" > /etc/hostname
cat >> /etc/hosts <<EOF_HOSTS
127.0.0.1    localhost
127.0.1.1    arch.localdomain    arch
::1          localhost ip6-localhost ip6-loopback
ff02::1      ip6-allnodes
ff02::2      ip6-allrouters
EOF_HOSTS

# Install and configure GRUB
pacman -S --noconfirm grub efibootmgr dosfstools mtools
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Install KDE Plasma and essential applications
pacman -S --noconfirm xorg sddm plasma-meta plasma-wayland-session kde-applications noto-fonts noto-font-emoji ttf-dejavu ttf-font-awesome
pacman -S --noconfirm firefox konsole

# Enable essential services
systemctl enable sddm
systemctl enable bluetooth
systemctl enable NetworkManager

EOF_CHROOT

# Unmount partitions and reboot
umount -lR /mnt
swapoff /dev/sda3
reboot
