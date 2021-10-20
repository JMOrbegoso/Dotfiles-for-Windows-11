function Set-VSCode-Configuration {
  $VSCodeSettingsPath = Join-Path -Path $env:appdata -ChildPath "Code" | Join-Path -ChildPath "User";
  $DotfilesVSCodeSettingsFolder = Join-Path -Path $DotfilesWorkFolder -ChildPath "VSCode";
  
  if (-not (Test-Path -Path $VSCodeSettingsPath)) {
    Write-Host "Configuring Visual Studio Code:" -ForegroundColor "Green";
    New-Item $VSCodeSettingsPath -ItemType directory;
  }

  Get-ChildItem -Path "${DotfilesVSCodeSettingsFolder}\*" -Include "*.json" -Recurse | Copy-Item -Destination $VSCodeSettingsPath;
}

choco install -y "vscode" --params "/NoDesktopIcon /NoQuicklaunchIcon /NoContextMenuFiles /NoContextMenuFolders";
Set-VSCode-Configuration;
refreshenv;
code --install-extension "coenraads.bracket-pair-colorizer-2";
code --install-extension "eamodio.gitlens";
code --install-extension "esbenp.prettier-vscode";
code --install-extension "formulahendry.auto-rename-tag";
code --install-extension "jock.svg";
code --install-extension "ms-azuretools.vscode-docker";
code --install-extension "ms-vscode-remote.remote-containers";
code --install-extension "ms-vscode-remote.remote-wsl";
code --install-extension "ms-vscode.powershell";
code --install-extension "oderwat.indent-rainbow";
code --install-extension "pkief.material-icon-theme";
code --install-extension "robole.markdown-snippets";
code --install-extension "ue.alphabetical-sorter";
code --install-extension "usernamehw.errorlens";