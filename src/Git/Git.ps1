function Set-Git-Configuration {
  Write-Host "Configuring Git:" -ForegroundColor "Green";
  git config --global init.defaultBranch "main";
  git config --global user.name $Config.GitUserName;
  git config --global user.email $Config.GitUserEmail;
  Write-Host "Git was successfully configured." -ForegroundColor "Green";
}

winget install --silent --accept-package-agreements --accept-source-agreements Git.Git;
Set-Git-Configuration;