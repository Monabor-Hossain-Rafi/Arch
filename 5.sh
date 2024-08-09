#inside arch terminal
setfont -d
nmcli dev status
nmcli radio wifi on
nmcli dev wifi list
sudo nmcli dev wifi connect wifi password "fuckyou69"
sudo pacman -Sy
sudo pacman -S xorg sddm plasma-meta plasma-wayland-session kde-applications noto-fonts noto-font-emoji ttf-dejavu ttf-font-awesome
sudo systemctl enable sddm
sudo reboot now
