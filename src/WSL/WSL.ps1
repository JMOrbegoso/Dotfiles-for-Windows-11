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
  Write-Host "Installing Volta in Ubuntu:" -ForegroundColor "Green";
  wsl mkdir -p -v ~/.dotfiles;
  wsl curl -o ~/.dotfiles/volta.sh https://get.volta.sh;
  wsl bash ~/.dotfiles/volta.sh;
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
  $DotfilesHugoWindowsScript = Join-Path -Path $DotfilesWorkFolder -ChildPath "WSL" | Join-Path -ChildPath "InstallHugo.sh";
  $DotfilesHugoWlsScript = wsl wslpath $DotfilesHugoWindowsScript.Replace("\", "\\");

  Write-Host "Installing Hugo in Ubuntu:" -ForegroundColor "Green";
  $HugoVersion = "0.87.0";
  wsl bash $DotfilesHugoWlsScript $HugoVersion;
}

function Install-OhMyZsh-In-Ubuntu {
  Write-Host "Installing Oh My Zsh in Ubuntu:" -ForegroundColor "Green";

  wsl mkdir -p -v ~/.dotfiles;
  wsl curl -L -o ~/.dotfiles/ohmyzsh.sh https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh;
  wsl bash ~/.dotfiles/ohmyzsh.sh --unattended;
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

choco install -y "wsl2" --params "/Version:2 /Retry:true";
choco install -y "wsl-ubuntu-2004" --params "/InstallRoot:true" --execution-timeout 3600;

Update-Ubuntu-Packages-Repository;
Update-Ubuntu-Packages;

Install-Ubuntu-Package -PackageName curl;
Install-Ubuntu-Package -PackageName neofetch;
Install-Ubuntu-Package -PackageName git;
Install-Ubuntu-Package -PackageName vim;
Install-Ubuntu-Package -PackageName zsh;

Set-Git-Configuration-In-Ubuntu;

Install-VSCode-Extensions-In-WSL;

Install-Volta-In-Ubuntu;
Install-Nodejs-Packages-In-Ubuntu;

Install-Golang-In-Ubuntu;
Install-Hugo-In-Ubuntu;

Install-OhMyZsh-In-Ubuntu;
Install-OhMyZsh-Theme-In-Ubuntu;
Install-OhMyZsh-Functions-In-Ubuntu;