#again inside the arch(desktop), do manually
sudo pacman -Sy flatpak
sudo pacman -Sy os-prober
sudo nano /etc/default/grub
      [Uncomment the last line G_E]
grub-mkconfig -o /boot/grub/grub.cfg
