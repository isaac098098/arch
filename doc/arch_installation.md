# Instalación de Arch Linux

## Conectarse a Internet

```
iwctl
device list
device DEVICE set-property Powered off
device DEVICE set-property Powered on
station DEVICE scan
station DEVICE get-networks
station DEVICE connect SSID
exit
```

## Activar teclado en español

```
loadkeys es
```

## Particionar disco

Crear tres particiones:
* Partición EFI (approx. 512M)
* Partición root ```/``` (Al menos 1G)
* Memoria swap (opcional, 1G)

```
fdisk -l
```

Para los dos primeros usar Linux Filesystem y para la memoria sawp Linux Swap.

## Formatear particiones
root
```
mkfs.ext4 /dev/root_partition
```

swap
```
mkswap /dev/swap_partition
```

EFI
```
mkfs.fat -F 32 /dev/efi_system_partition
```

## Montar particiones (1)
```
mount /dev/root_partition /mnt
swapon /dev/swap_partition
```

## Instalar paquetes base
```
pacstrap -K /mnt base base-devel linux linux-firmware networkmanager wpa_supplicant grub
```

## Generar archivo fstab
```
genfstab -U /mnt >> /mnt/etc/fstab
```

## Cambiar el root al nuevo sistema
```
arch-chroot /mnt
```

## Definir usuarios y contraseñas
Contraseña de root
```
passwd
```

Crear usuario y su contraseña
```
useradd -m username
passwd username
```

Añadir usuario al grupo wheel
```
usermod -aG wheel username
```

## Pedir contraseña para permisos de superusuario
Editar ```/etc/sudoers/``` y descomentar la siguiente línea
```
%wheel ALL=(ALL:ALL) ALL
```

## Añadir regiones
Editar ```/etc/locale.gen/``` y descomentar las regiones deseadas, e.g. ```en_US``` y ```es_MX```, luego
```
locale-gen
```

## Fijar teclado español para zsh
Editar ```/etc/vconsole.conf``` y añadir
```
KEYMAP=es
```

## Instalar el grub en el sistema nuevo y crear archivo de configuración (2)
```
mount --mkdir /dev/efi_system_partition /mnt/boot
grub-install --target=x86_64-efi --efi-directory=/mnt/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```

## Configurar hostnames
Nombre de la máquina
```
echo username > /etc/hostname
```

Editar  hosts en ```/etc/hosts``` y añadir
```
127.0.0.1       localhost
::1             localhost
127.0.0.1       username.localhost username
```

## Configurar servicios
networkmanager
```
systemctl start NetworkManager.service
systemctl enable NetworkManager.service
```

wpa_supplicant
```
systemctl start wpa_supplicant.service
systemctl enable wpa_supplicant.service
```

Conectar a red
```
nmcli radio wifi
nmcli radio wifi on
nmcli dev wifi list
sudo nmcli --ask dev wifi connect SSID
```

## Paquetes y repositorios
Añadir repositorios AUR y blackarch
```
pacman -S git sudo vim neofetch
```
AUR
```
cd
exit
whoami
mkdir repos
cd repos
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin/
makepkg -si
```

blackarch
```
cd ..
mkdir blackarch
cd blackarch
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sudo su
./strap.sh
```
```
pacman -Sy
```

## Para instalar i3
```
pacman -S xorg xorg-server xorg-xinit picom i3-wm
```

## Editar ~/.xinitrc
```
...

picom --config /home/username/.config/picom/picom.conf &
exec i3
```

## Editar ~/.zprofile
```
[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx --vt1
```

## Para usar Hyprland (Wayland), descomentar la línea anterior en ~/.zprofile y agregar
```
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    exec Hyprland
fi
```

## reboot
```
setxkbmap -layout latam
```

## ```.config/i3/config```
Descomentar módulo i3status
```
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ 5%+
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ 5%+
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle
bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle
...
bindsym $mod+Return exec kitty
...
bindsym $mod+d exec --no-startup-id rofi -show run

exec --no-startup-id dunst
...

exec_always --no-startup-id /home/isaac09809/.config/polybar/launch.sh

exec_always --no-startup-id feh --bg-scale /home/isaac09809/Pictures/Wallpapers/arch_nord_1.png

bindsym XF86MonBrightnessUp exec --no-startup-id brightnessctl set 5%+ 
bindsym XF86MonBrightnessDown exec --no-startup-id brightnessctl set 5%- 

exec_always --no-startup-id setxkbmap latam
...

default_border pixel 0
default_floating_border none

gaps inner 10
gaps outer 0

focus_on_window_activation none

bindsym Print exec --no-startup-id scrot

exec --no-startup-id xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
exec --no-startup-id xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1

exec --no-startup-id picom --config ~/.config/picom/picom.conf
```

## Paquetes extra
```
pacman -S kitty neovim zathura zathura-pdf-mupdf firefox texlive-basic texlive-latex texlive-latexrecommended texlive-fontsrecommended texlive-fontsextra texlive-xetex texlive-luatex texlive-bibtexextra texlive-mathscience texlive-binextra texlive-latexextra texlive-langspanish texlive-langeuropean brightnessctl scrot dunst rofi feh python xclip nodejs npm mesa-amber python-pyx biber xdotool
```

## Fuentes
* IosevkaTerm
* IosevkaNerdFont

Instalar fuentes en
```
/usr/share/fonts
```


## Terminal
https://github.com/romkatv/powerlevel10k/issues/515

Pywal
```
pacman -S python-pywal imagemagick
wal --theme base16-nord
```

Cambiar de bash a zsh al usuario y al root
```
echo $SHELL
pacman -S zsh
usermod --shell /usr/bin/zsh username
usermod --shell /usr/bin/zsh root
```

Instalar plugin manager para zsh
```
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

syntax-highlighting, autosuggestions, sudo y powerlever10k
```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
y editar en ```~/.zshrc```
```
...
ZSH_THEME="powerlevel10k/powerlevel10k"
...
plugins=(... zsh-syntax-highlighting zsh-autosuggestions sudo)
...
bindkey '^ ' autosuggest-accept
```

Quitar módulos no deseados (derechos) en ```.p10k.zsh```

Crear link symbólico para el usuario root
```
ln -s -f /home/username/.zshrc /root/.zshrc
mkdir /root/.oh-my-zsh
cp -r /home/username/.oh-my-zsh /root/.oh-my-
```

## ```.config/nvim/init.vim```
```
call plug#begin()

Plug 'lervag/vimtex'
Plug 'arcticicestudio/nord-vim'

call plug#end()

filetype plugin indent on
syntax enable
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexmk'

colorscheme nord
```

## ```.config/picom/picom.con```
```
use-damage = false;
shadow = false;
```

## ```.config/zathura/zathuarc```
```
curl -o .config/zathura/zathurarc hhtps://raw.githubusercontent.com/HaoZeke/base16-zathura/main/build_schemes/colors/base16-nord.config
```

Añadir
```
set guioptions ""
set highlight-transparency 0
```

## ```.config/kitty/kitty.conf```
Esquema de colores
```
curl -o .config/kitty/kitty.conf https://raw.githubusercontent.com/kdrag0n/base16-kitty/master/colors/base16-nord-256.conf
```

Parámetros
```
font_family             IosevkaTerm
font_size               13
url_style               curly
cursor_shape            beam
cursor_beam_thickness   7
background_opacity      0.95
```

## Instalar polybar
```
mkdir -p .config/polybar
cp /etc/polybar/config.ini .config/polybar/
curl -o .config/polybar/launch.sh https://raw.githubusercontent.com/boylemic/configs/master/bspwm/polybar/launch.sh
```

## ```.config/polybar/config.ini```
```
...
line-size = 0pt 
...
font-0 = IosevkaTermNerdFont:size=11;2
font-1 = IosevkaNerdFont Mono:size=20;2
...
label-active = %{T2}<icon>%{T-}
label-active-padding = 3
label-active-foreground = #ebcb8b
...
label-occupied = %{T2}<icon>%{T-}
label-occupied-padding = 3
...
label-urgent = %{T2}<icon>%{T-}
label-urgent-padding = 3
...
label-empty = %{T2}<icon>%{T-}
label-empty-padding = 3
```

## Desactivar suspensión por inactividad
Screensaver
```
xset s off
```

Power saving
```
xset -dpms
```

## Rofi
``` .config/rofi/config.rasi```

## Refrescar archivos de LaTeX

```sudo fmtutil-sys --all```

## Termux Texlive
Si el paquete está desactualizado, buscar un repositorio utilizable en ctan mirros status. 

termux_properties -> allow_external_apps = true

```texlinks```
```updmap -sys```
```mktexmf -all```
```termux-allow-storage```

Buscar paquetes perdidos en instalación incompleta o rota
```tlmgr -repository https://mirror.ctan.org/systems/texlive/tlnet update --self --all --reinstall-forcibly-removed```

## Rotación de pantalla
### Wayland
```pacman -S iio-sensor-proxy```
```paru iio-hyprland-git```

## Mirrors
Use `reflector` to update mirrors.
`ipacman -S archlinux-keyring`
`pacman-key --refresh-keys`

## Fix missing libalpm
`sudo cp /usr/lib/libalpm.so.14 /usr/lib/libalpm.so.13`
