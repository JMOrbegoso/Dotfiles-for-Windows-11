function Invoke-Update-Ubuntu-Packages {
  Write-Host "Updating Ubuntu package repository:" -ForegroundColor "Green";
  wsl sudo apt --yes update;
}

function Invoke-Upgrade-Ubuntu-Packages {
  Write-Host "Upgrading Ubuntu packages:" -ForegroundColor "Green";
  wsl sudo apt --yes upgrade;
}

function Invoke-Install-Ubuntu-Package {
  [CmdletBinding()]
  param(
    [Parameter(Position = 0, Mandatory = $TRUE)]
    [string]
    $PackageName
  )

  Write-Host "Installing ${PackageName} in Ubuntu:" -ForegroundColor "Green";
  wsl sudo apt install --yes --no-install-recommends $PackageName;
}

function Invoke-Configure-Git-In-Ubuntu {
  Write-Host "Configuring Git in Ubuntu:" -ForegroundColor "Green";
  wsl git config --global init.defaultBranch "main";
  wsl git config --global user.name $Config.GitUserName;
  wsl git config --global user.email $Config.GitUserEmail;
  wsl git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe";
  wsl git config --list;
  Write-Host "Git was successfully configured in Ubuntu." -ForegroundColor "Green";
}

function Invoke-Install-VSCode-Extensions-In-WSL {
  Write-Host "Installing Visual Studio Code extensions in WSL:" -ForegroundColor "Green";
  wsl code --install-extension dbaeumer.vscode-eslint;
  wsl code --install-extension golang.go;
}

function Invoke-Install-Volta-In-Ubuntu {
  Write-Host "Installing Volta in Ubuntu:" -ForegroundColor "Green";
  wsl mkdir -p -v ~/.dotfiles;
  wsl curl -o ~/.dotfiles/volta.sh https://get.volta.sh;
  wsl bash ~/.dotfiles/volta.sh;
}

function Invoke-Install-Nodejs-Packages-In-Ubuntu {
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

choco install -y "wsl2" --params "/Version:2 /Retry:true";
choco install -y "wsl-ubuntu-2004" --params "/InstallRoot:true" --execution-timeout 3600;

Invoke-Update-Ubuntu-Packages;
Invoke-Upgrade-Ubuntu-Packages;

Invoke-Install-Ubuntu-Package -PackageName curl;
Invoke-Install-Ubuntu-Package -PackageName neofetch;
Invoke-Install-Ubuntu-Package -PackageName git;
Invoke-Install-Ubuntu-Package -PackageName vim;
Invoke-Install-Ubuntu-Package -PackageName zsh;

Invoke-Configure-Git-In-Ubuntu;

Invoke-Install-VSCode-Extensions-In-WSL;

Invoke-Install-Volta-In-Ubuntu;

Invoke-Install-Nodejs-Packages-In-Ubuntu;