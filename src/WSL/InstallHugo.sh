hugoReleaseUrl="https://github.com/gohugoio/hugo/releases/download/v${1}/hugo_${1}_Linux-64bit.deb";
dotfilesHugoInstaller=~/.dotfiles/hugo-installer.deb;

if [ ! -f $dotfilesHugoInstaller ]; then
    echo "Downloading Hugo...";
    wget $hugoReleaseUrl -O $dotfilesHugoInstaller;
fi

echo "Installing Hugo...";
sudo dpkg -i $dotfilesHugoInstaller;
sudo apt install -f $dotfilesHugoInstaller;