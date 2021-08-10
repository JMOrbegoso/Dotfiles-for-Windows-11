function Update-Ubuntu-Packages-Repository {
  Write-Host "Updating Ubuntu package repository:" -ForegroundColor "Green";
  wsl sudo apt --yes update;
}

function Update-Ubuntu-Packages {
  Write-Host "Upgrading Ubuntu packages:" -ForegroundColor "Green";
  wsl sudo apt --yes upgrade;
}

function Install-Ubuntu-Package {
  [CmdletBinding()]
  param(
    [Parameter(Position = 0, Mandatory = $TRUE)]
    [string]
    $PackageName
  )

  Write-Host "Installing ${PackageName} in Ubuntu:" -ForegroundColor "Green";
  wsl sudo apt install --yes --no-install-recommends $PackageName;
}

function Set-Git-Configuration-In-Ubuntu {
  Write-Host "Configuring Git in Ubuntu:" -ForegroundColor "Green";
  wsl git config --global init.defaultBranch "main";
  wsl git config --global user.name $Config.GitUserName;
  wsl git config --global user.email $Config.GitUserEmail;
  wsl git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe";
  wsl git config --list;
  Write-Host "Git was successfully configured in Ubuntu." -ForegroundColor "Green";
}

function Install-VSCode-Extensions-In-WSL {
  Write-Host "Installing Visual Studio Code extensions in WSL:" -ForegroundColor "Green";
  wsl code --install-extension dbaeumer.vscode-eslint;
  wsl code --install-extension golang.go;
}

function Install-Volta-In-Ubuntu {
  $DotfilesVoltaInstallerPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WSL" | Join-Path -ChildPath "volta.sh";

  Invoke-WebRequest -o $DotfilesVoltaInstallerPath https://get.volta.sh;

  $WslVoltaInstallerPath = wsl wslpath $DotfilesVoltaInstallerPath.Replace("\", "\\");

  Write-Host "Installing Volta in Ubuntu:" -ForegroundColor "Green";
  
  wsl bash $WslVoltaInstallerPath;
}

function Install-Nodejs-Packages-In-Ubuntu {
  Write-Host "Installing Node.js LTS in Ubuntu:" -ForegroundColor "Green";
  wsl ~/.volta/bin/volta install node;
  
  Write-Host "Installing NPM in Ubuntu:" -ForegroundColor "Green";
  wsl ~/.volta/bin/volta install npm;
  
  Write-Host "Installing Yarn in Ubuntu:" -ForegroundColor "Green";
  wsl ~/.volta/bin/volta install yarn;
  
  Write-Host "Installing TypeScript in Ubuntu:" -ForegroundColor "Green";
  wsl ~/.volta/bin/volta install typescript;
  
  Write-Host "Installing Yarn-Upgrade-All in Ubuntu:" -ForegroundColor "Green";
  wsl ~/.volta/bin/volta install yarn-upgrade-all;
  
  Write-Host "Installing Angular CLI in Ubuntu:" -ForegroundColor "Green";
  wsl ~/.volta/bin/volta install @angular/cli;
  
  Write-Host "Installing NestJS CLI in Ubuntu:" -ForegroundColor "Green";
  wsl ~/.volta/bin/volta install @nestjs/cli;
}

function Install-Golang-In-Ubuntu {
  Write-Host "Installing Golang in Ubuntu:" -ForegroundColor "Green";
  wsl sudo apt install --yes --no-install-recommends golang-go;
}

function Install-Hugo-In-Ubuntu {
  $DotfilesHugoInstallerPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WSL" | Join-Path -ChildPath "hugo-installer.deb";
  $HugoVersion = "0.87.0";
  $HugoReleaseUrl = "https://github.com/gohugoio/hugo/releases/download/v${HugoVersion}/hugo_${HugoVersion}_Linux-64bit.deb";

  if (-not (Test-Path $DotfilesHugoInstallerPath)) {
    Write-Host "Downloading Hugo installer:" -ForegroundColor "Green";
    Invoke-WebRequest $HugoReleaseUrl -O $DotfilesHugoInstallerPath;
  }

  $WslHugoInstallerPath = wsl wslpath $DotfilesHugoInstallerPath.Replace("\", "\\");

  Write-Host "Installing Hugo in Ubuntu:" -ForegroundColor "Green";
  wsl sudo dpkg -i $WslHugoInstallerPath;
  wsl sudo apt install -f $WslHugoInstallerPath;
}

function Install-Plug-Vim-In-Ubuntu {
  Write-Host "Installing Vim-Plug in Ubuntu:" -ForegroundColor "Green";

  wsl mkdir -p -v ~/.vim/autoload;
  wsl curl -L -o ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
}

function Copy-Initial-Vimrc-In-Ubuntu {
  $DotfilesInitialVimrcPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Vim" | Join-Path -ChildPath "initial.vimrc";
  $WslVimrcPath = wsl wslpath $DotfilesInitialVimrcPath.Replace("\", "\\");

  if (-not((wsl wslpath -w ~/.vimrc))) {
    Write-Host "Copying initial Vim configuration file in Ubuntu:" -ForegroundColor "Green";
    
    wsl cp -R $WslVimrcPath ~/.vimrc;
    
    $WindowsVimrcPath = wsl wslpath -w ~/.vimrc;
    (Get-Content -path $WindowsVimrcPath) -replace "__VIM_PLUGGED__", "~/.vim/plugged" | Set-Content -Path $WindowsVimrcPath;
  }
}

function Install-Vim-Plugins-In-Ubuntu {
  Write-Host "Installing Vim plugins in Ubuntu:" -ForegroundColor "Green";
  wsl vim +PlugInstall +qall;
}

function Copy-Final-Vimrc-In-Ubuntu {
  $DotfilesFinalVimrcPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Vim" | Join-Path -ChildPath "final.vimrc";
  $WslVimrcPath = wsl wslpath $DotfilesFinalVimrcPath.Replace("\", "\\");

  Write-Host "Copying final Vim configuration file in Ubuntu:" -ForegroundColor "Green";

  wsl cp -R $WslVimrcPath ~/.vimrc;

  $WindowsVimrcPath = wsl wslpath -w ~/.vimrc;
  (Get-Content -path $WindowsVimrcPath) -replace "__VIM_PLUGGED__", "~/.vim/plugged" | Set-Content -Path $WindowsVimrcPath;
  (Get-Content -path $WindowsVimrcPath) -replace "__STARTIFY_BOOKMARKS__", "[ { 'v': '~/.vimrc' }, { 'z': '~/.zshrc' }, { 'o': '~/.oh-my-zsh' }, { 't': '~/.oh-my-zsh/custom/themes' }, { 'f': '~/.oh-my-zsh/custom/functions' } ]" | Set-Content -Path $WindowsVimrcPath;
  (Get-Content -path $WindowsVimrcPath) -replace "__VIM_SESSION__", "~/.vim/session" | Set-Content -Path $WindowsVimrcPath;
  (Get-Content -path $WindowsVimrcPath) -replace "__VIMRC_LOCAL__", "~/.vimrc.local" | Set-Content -Path $WindowsVimrcPath;
}

function Install-OhMyZsh-In-Ubuntu {
  $DotfilesOhMyZshInstallerPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WSL" | Join-Path -ChildPath "ohmyzsh.sh";

  Invoke-WebRequest -o $DotfilesOhMyZshInstallerPath https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh;

  $WslOhMyZshInstallerPath = wsl wslpath $DotfilesOhMyZshInstallerPath.Replace("\", "\\");
  
  Write-Host "Installing Oh My Zsh in Ubuntu:" -ForegroundColor "Green";
  
  wsl bash $WslOhMyZshInstallerPath --unattended;
}

function Install-OhMyZsh-Theme-In-Ubuntu {
  $DotfilesOhMyZshThemePath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WSL" | Join-Path -ChildPath "paradox.zsh-theme";
  $WslOhMyZshThemePath = wsl wslpath $DotfilesOhMyZshThemePath.Replace("\", "\\");

  Write-Host "Installing Paradox theme for Oh My Zsh in Ubuntu:" -ForegroundColor "Green";

  wsl cp -R $WslOhMyZshThemePath ~/.oh-my-zsh/custom/themes;
}

function Install-OhMyZsh-Functions-In-Ubuntu {
  $DotfilesOhMyZshFunctionsPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WSL" | Join-Path -ChildPath "custom-actions.sh";
  $WslOhMyZshFunctionsPath = wsl wslpath $DotfilesOhMyZshFunctionsPath.Replace("\", "\\");

  Write-Host "Installing custom alias and functions for Oh My Zsh in Ubuntu:" -ForegroundColor "Green";

  wsl mkdir -p ~/.oh-my-zsh/custom/functions;

  wsl cp -R $WslOhMyZshFunctionsPath ~/.oh-my-zsh/custom/functions;
}

function Set-OhMyZsh-Configuration-In-Ubuntu {
  $DotfilesZshrcPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WSL" | Join-Path -ChildPath ".zshrc";
  $WslZshrcPath = wsl wslpath $DotfilesZshrcPath.Replace("\", "\\");

  Write-Host "Configuring Zsh in Ubuntu:" -ForegroundColor "Green";
  
  wsl cp -R $WslZshrcPath ~;
}

function Set-Zsh-As-Default-In-Ubuntu {
  Write-Host "Changing default shell to Zsh in Ubuntu:" -ForegroundColor "Green";

  $WslZshPath = wsl which zsh;
  wsl sudo chsh -s $WslZshPath;

  # Change just for a user: sudo chsh -s $WslZshPath $USER_NAME;
}

choco install -y "wsl2" --params "/Version:2 /Retry:true";
choco install -y "wsl-ubuntu-2004" --params "/InstallRoot:true" --execution-timeout 3600;

Update-Ubuntu-Packages-Repository;
Update-Ubuntu-Packages;

Install-Ubuntu-Package -PackageName "curl";
Install-Ubuntu-Package -PackageName "neofetch";
Install-Ubuntu-Package -PackageName "git";
Install-Ubuntu-Package -PackageName "vim";
Install-Ubuntu-Package -PackageName "zsh";
Install-Ubuntu-Package -PackageName "make";
Install-Ubuntu-Package -PackageName "g++";
Install-Ubuntu-Package -PackageName "gcc";

Set-Git-Configuration-In-Ubuntu;

Install-VSCode-Extensions-In-WSL;

Install-Volta-In-Ubuntu;
Install-Nodejs-Packages-In-Ubuntu;

Install-Golang-In-Ubuntu;
Install-Hugo-In-Ubuntu;

Install-Plug-Vim-In-Ubuntu;
Copy-Initial-Vimrc-In-Ubuntu;
Install-Vim-Plugins-In-Ubuntu;
Copy-Final-Vimrc-In-Ubuntu;

Install-OhMyZsh-In-Ubuntu;
Install-OhMyZsh-Theme-In-Ubuntu;
Install-OhMyZsh-Functions-In-Ubuntu;
Set-OhMyZsh-Configuration-In-Ubuntu;
Set-Zsh-As-Default-In-Ubuntu;