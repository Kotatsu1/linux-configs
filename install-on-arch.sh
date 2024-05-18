YARPATH="$(pwd)"

# Update pacman
echo "Updating pacman, just wait a little"
sudo pacman --noconfirm -Syu

# Install dependecies
echo "##############################"
echo "Installing a bunch of stuff"
echo "##############################"
sudo pacman -S --noconfirm --needed xorg xorg-xinit\
    bspwm sxhkd                     \
    lightdm lightdm-gtk-greeter     \
    git python3 gcc base-devel      \
    mpv                             \
    ttf-cascadia-code               \
    rofi                            \
    yarn                            \
    nodejs                          \
    npm                             \
    xclip                           \
    cmake                           \
    ttf-nerd-fonts-symbols

# Setup lightdm
sudo systemctl enable lightdm &

# Installing NVIM
sudo pacman -S --noconfirm --needed neovim

echo "##############################"
echo "installing Rust and alacritty"
echo "##############################"
sudo pacman -S --needed rustup cargo

rustup default stable

echo "##############################"
echo "Installing paru"
echo "##############################"
git clone https://aur.archlinux.org/paru.git
cd paru 
makepkg -si && cd ..
paru -Syu

echo "##############################"
echo "Installing Picom"
echo "##############################"
paru -S --noconfirm --needed picom

echo "##############################"
echo "Installing alacritty"
echo "##############################"
paru -S --noconfirm --needed alacritty

echo "##############################"
echo "Installing polybar"
echo "##############################"
paru -S --needed polybar

echo "##############################"
echo "Installing xwinwrap"
echo "##############################"
paru -S --needed xwinwrap

sudo chmod 777 ~/.config/ -R


echo "##############################"
echo "Copying configs"
echo "##############################"

if [ -d $HOME/.config ]; then
    sudo cp -r $YARPATH/configs/alacritty ~/.config
    sudo cp -r $YARPATH/configs/bashrc ~/.config
    sudo cp -r $YARPATH/configs/bspwm ~/.config
    sudo cp -r $YARPATH/configs/picom ~/.config
    sudo cp -r $YARPATH/configs/polybar ~/.config
    sudo cp -r $YARPATH/configs/rofi ~/.config
    sudo cp -r $YARPATH/configs/scripts ~/.config
    sudo cp -r $YARPATH/configs/sxhkd ~/.config
    sudo cp -r $YARPATH/configs/xconfigs ~/.config
    sudo cp -r $YARPATH/configs/nvim ~/.config
else
    sudo cp -r "$YARPATH/configs" ~/
    sudo mv ~/configs ~/.config
fi

sudo mv ~/.config/xconfigs/.xinit ~/.xinit
sudo mv ~/.config/xconfigs/.xprofile ~/.xprofile
sudo rm -r ~/.config/xconfigs


