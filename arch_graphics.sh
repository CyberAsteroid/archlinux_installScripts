#!/usr/bin/env bash

# 如果你想安装xfce桌面，添加 xfce4 xfce4-goodies
# 如果你想安装kde桌面，添加 plasma kde-applications
# 如果你想安装gnome桌面，添加gnome gnome-extra


sudo pacman -S vulkan-intel lib32-vulkan-intel mesa lib32-mesa alsa alsa-utils pipewire pipewire-pulse pavucontrol xorg xorg-xinit sddm fcitx5-git fcitx5-qt5 fcitx5-qt6 fcitx5-gtk fcitx5-configtool fcitx5-chinese-addons fcitx5-pinyin-moegirl fcitx5-pinyin-zhwiki yay git feh rofi flameshot v2ray v2raya telegram-desktop vlc obs-studio mpv netease-cloud-music icalingua ttf-dejavu wqy-microhei wqy-zenhei


echo "GTK_IM_MODULE DEFAULT=fcitx" >> ~/.pam_environment
echo "QT_IM_MODULE  DEFAULT=fcitx" >> ~/.pam_environment
echo "XMODIFIERS    DEFAULT=\@im=fcitx" >> ~/.pam_environment
