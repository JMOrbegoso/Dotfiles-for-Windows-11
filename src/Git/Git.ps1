function Set-Git-Configuration {
  Write-Host "Configuring Git:" -ForegroundColor "Green";
  git config --global init.defaultBranch "main";
  git config --global user.name $Config.GitUserName;
  git config --global user.email $Config.GitUserEmail;
  Write-Host "Git was successfully configured." -ForegroundColor "Green";
}

choco install -y "git" --params "/NoAutoCrlf /WindowsTerminal /NoShellIntegration /SChannel";
Set-Git-Configuration;