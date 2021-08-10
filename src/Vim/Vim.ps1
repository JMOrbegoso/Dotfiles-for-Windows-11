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

function Set-Vim-Configuration {
  $DotfilesInitialVimrcPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Vim" | Join-Path -ChildPath "initial.vimrc";
  $DotfilesFinalVimrcPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Vim" | Join-Path -ChildPath "final.vimrc";
  $VimrcPath = Join-Path -Path $HOME -ChildPath ".vimrc";

  if (-not (Test-Path -Path $VimrcPath)) {
    Write-Host "Copying initial Vim configuration file:" -ForegroundColor "Green";
    Copy-Item $DotfilesInitialVimrcPath -Destination $VimrcPath;

    (Get-Content -path $VimrcPath) -replace "__VIM_PLUGGED__", "~/vimfiles/plugged" | Set-Content -Path $VimrcPath;
  }

  Write-Host "Installing Vim plugins:" -ForegroundColor "Green";
  vim +PlugInstall +qall;

  Write-Host "Copying final Vim configuration file:" -ForegroundColor "Green";
  Copy-Item $DotfilesFinalVimrcPath -Destination $VimrcPath;

  (Get-Content -path $VimrcPath) -replace "__VIM_PLUGGED__", "~/vimfiles/plugged" | Set-Content -Path $VimrcPath;
  (Get-Content -path $VimrcPath) -replace "__STARTIFY_BOOKMARKS__", "[ { 'v': '~/.vimrc' } ]" | Set-Content -Path $VimrcPath;
  (Get-Content -path $VimrcPath) -replace "__VIM_SESSION__", "~/vimfiles/session" | Set-Content -Path $VimrcPath;
  (Get-Content -path $VimrcPath) -replace "__VIMRC_LOCAL__", "~/vimfiles/local_init.vim" | Set-Content -Path $VimrcPath;

  Write-Host "Vim was successfully configured." -ForegroundColor "Green";
}

choco install -y "vim" --params "/NoDesktopShortcuts /NoContextmenu /InstallDir:${env:ProgramFiles}";
refreshenv;
Install-VimPlug;
Set-Vim-Configuration;