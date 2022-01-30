function Install-Neovim-In-Ubuntu {
  wsl sudo apt-get remove vim;

  wsl sudo add-apt-repository -y ppa:neovim-ppa/stable;
  wsl sudo apt --yes update;

  Install-Ubuntu-Package -PackageName "neovim";
  Install-Ubuntu-Package -PackageName "python3-neovim";
  Install-Ubuntu-Package -PackageName "ctags";
}

function Install-Plug-Vim-For-Neovim-In-Ubuntu {
  Write-Host "Installing Vim-Plug for Neovim in Ubuntu:" -ForegroundColor "Green";

  wsl sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.config}"/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';
}

function Copy-Initial-Neovim-Configuration-File {
  $DotfilesInitialVimrcPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WSL" | Join-Path -ChildPath "Neovim" | Join-Path -ChildPath "initial.vim";
  $WslVimrcPath = wsl wslpath $DotfilesInitialVimrcPath.Replace("\", "\\");
  
  Write-Host "Copying initial Neovim configuration file in Ubuntu:" -ForegroundColor "Green";
  wsl cp -R $WslVimrcPath ~/.config/nvim/init.vim;
}

function Install-Neovim-Plugins-In-Ubuntu {
  Write-Host "Installing Neovim plugins in Ubuntu:" -ForegroundColor "Green";
  wsl vim +PlugInstall +qall;
}

function Copy-Final-Neovim-Configuration-File {
  $DotfilesFinalVimrcPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WSL" | Join-Path -ChildPath "Neovim" | Join-Path -ChildPath "final.vim";
  $WslVimrcPath = wsl wslpath $DotfilesFinalVimrcPath.Replace("\", "\\");
  
  Write-Host "Copying final Neovim configuration file in Ubuntu:" -ForegroundColor "Green";
  wsl cp -R $WslVimrcPath ~/.config/nvim/init.vim;
}

Install-Neovim-In-Ubuntu;
Install-Plug-Vim-For-Neovim-In-Ubuntu;
Copy-Initial-Neovim-Configuration-File;
Install-Neovim-Plugins-In-Ubuntu;
Copy-Final-Neovim-Configuration-File;