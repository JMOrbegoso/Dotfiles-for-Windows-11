function Install-VimPlug {
  $VimPlugFilePath = Join-Path -Path $HOME -ChildPath "vimfiles" | Join-Path -ChildPath "autoload" | Join-Path -ChildPath "plug.vim";

  if (-not (Test-Path -Path $VimPlugFilePath)) {
    Write-Host "Installing Vim-Plug:" -ForegroundColor "Green";
    Invoke-WebRequest -useb "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" | New-Item $VimPlugFilePath -Force;
  }
  else {
    Write-Host "Vim-Plug is already installed." -ForegroundColor "Green";
  }
}

function Copy-Initial-Vim-Configuration-File {
  $DotfilesInitialVimrcPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Vim" | Join-Path -ChildPath "initial.vimrc";
  $VimrcPath = Join-Path -Path $HOME -ChildPath ".vimrc";
  
  Write-Host "Copying initial Vim configuration file:" -ForegroundColor "Green";
  Copy-Item $DotfilesInitialVimrcPath -Destination $VimrcPath;
}

function Install-Vim-Plugins {
  Write-Host "Installing Vim plugins:" -ForegroundColor "Green";
  vim +PlugInstall +qall;
}

function Copy-Final-Vim-Configuration-File {
  $DotfilesFinalVimrcPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Vim" | Join-Path -ChildPath "final.vimrc";
  $VimrcPath = Join-Path -Path $HOME -ChildPath ".vimrc";

  Write-Host "Copying final Vim configuration file:" -ForegroundColor "Green";
  Copy-Item $DotfilesFinalVimrcPath -Destination $VimrcPath;
}

choco install -y "vim" --params "/NoDesktopShortcuts /NoContextmenu /InstallDir:${env:ProgramFiles}";
refreshenv;
Install-VimPlug;
Copy-Initial-Vim-Configuration-File;
Install-Vim-Plugins;
Copy-Final-Vim-Configuration-File;