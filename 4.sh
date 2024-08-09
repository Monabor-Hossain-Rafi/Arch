#inside the arch terminal, do manually
passwd
     useradd -m -g users -G wheel,storage,video,audio -s /bin/bash sasuke
     passwd sasuke
     EDITOR=nano visudo
        [remove the # from %wheel ALL=(ALL:ALL) ALL]
     ln -sf /usr/share/zoneinfo/Asia/Dhaka /etc/localtime
     hwclock --systohc
     nano /etc/locale.gen
        [Remove # form en_US.UTF-8 UTF-8]
     locale-gen
     echo "LANG=en_US.UTF-8" >> /etc/locale.conf
     echo "arch" >> /etc/hostname
     nano /etc/hosts
         [
# Static table lookup for hostnames.
# See hosts (5) for details.

127.0.0.1    localhost
::1          localhost
127.0.1.1    arch.localdomain  arch
         ]
     pacman -S grub efibootmgr dosfstools mtools
     grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
     grub-mkconfig -o /boot/grub/grub.cfg
     systemctl enable bluetooth
     systemctl enable NetworkManager
     exit

#Then unmount using "umount -lR /mnt" and restart
