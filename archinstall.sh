#!/usr/bin/env bash
# wifi也最好自己手动连接
iwctl << EOF
station wlan0 scan
station wlan0 connect 这里是你的wifi名字
这一行替换成你的wifi密码
exit
EOF
# 分区部分最好自己手动来
fdisk /dev/sda << EOF
g
n


+300M
n


+8G
n



t
1
01
p
w
EOF

# 安装部分

echo "Server = https://mirrors.ustc.edu.cn/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel linux linux-firmware networkmanager iwd intel-ucode vim fish
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt << EOF
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen
echo "zh_HK.UTF-8 UTF-8" >> /etc/locale.gen
echo "zh_TW.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "yuki" >> /etc/hostname
passwd
123
123

useradd -m -G wheel yuki
passwd yuki
123
123

chsh -s /bin/fish yuki
chsh -s /bin/fish
sed -i "s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g" /etc/sudoers
bootctl --path=/boot install
echo "timeout 0" > /boot/loader/loader.conf
echo "default arch.conf" >> /boot/loader/loader.conf
echo "title archlinux" >> /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /intel-ucode.img" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
echo "[device]" >> /etc/NetworkManager/NetworkManager.conf
echo "wifi.backend=iwd" >> /etc/NetworkManager/NetworkManager.conf
systemctl enable NetworkManager
systemctl enable iwd
exit
EOF
echo "options root=$(blkid /dev/sda3 | awk '{print $5}') rw" >> /mnt/boot/loader/entries/arch.conf
cat /mnt/boot/loader/entries/arch.conf
