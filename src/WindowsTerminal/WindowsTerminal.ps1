function Set-OhMyPosh-Theme
{
  $DotfilesOhMyPoshThemePath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WindowsTerminal" | Join-Path -ChildPath ".oh-my-posh-custom-theme.omp.json";

  Write-Host "Coping Oh My Posh custom theme:" -ForegroundColor "Green";

  Copy-Item $DotfilesOhMyPoshThemePath -Destination $env:UserProfile;

  Write-Host "Oh My Posh theme was successfully created." -ForegroundColor "Green";
}

function Set-PowerShell-Profile
{
  $DotfilesWindowsTerminalProfilePath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WindowsTerminal" | Join-Path -ChildPath "Microsoft.PowerShell_profile.ps1";

  if (-not (Test-Path -Path $Profile))
  {
    Write-Host "Creating empty PowerShell profile:" -ForegroundColor "Green";
    New-Item -Path $Profile -ItemType "file" -Force;
  }
  
  Write-Host "Coping PowerShell profile:" -ForegroundColor "Green";
  Copy-Item $DotfilesWindowsTerminalProfilePath -Destination $Profile;
  
  Write-Host "Activating PowerShell profile:" -ForegroundColor "Green";
  . $Profile;

  Write-Host "PowerShell profile was successfully created." -ForegroundColor "Green";
}

function Set-WindowsTerminal-Settings
{
  $WindowsTerminalSettingsFilePath = Join-Path -Path $env:LOCALAPPDATA -ChildPath "Packages" | Join-Path -ChildPath "Microsoft.WindowsTerminal_8wekyb3d8bbwe" | Join-Path -ChildPath "LocalState" | Join-Path -ChildPath "settings.json";
  $DotfilesWindowsTerminalSettingsPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WindowsTerminal" | Join-Path -ChildPath "settings.json";
  $WorkspaceFolder = Join-Path -Path $Config.WorkspaceDisk -ChildPath "Workspace";

  Write-Host "Copying Windows Terminal settings:" -ForegroundColor "Green";
  Copy-Item $DotfilesWindowsTerminalSettingsPath -Destination $WindowsTerminalSettingsFilePath;

  Write-Host "Configuring Windows Terminal starting directory:" -ForegroundColor "Green";
  (Get-Content -path $WindowsTerminalSettingsFilePath) -replace "__STARTING_DIRECTORY__", ($WorkspaceFolder | ConvertTo-Json) | Set-Content -Path $WindowsTerminalSettingsFilePath;

  Write-Host "Windows Terminal was successfully configured." -ForegroundColor "Green";
}

Install-Module -Name "oh-my-posh";
Set-OhMyPosh-Theme;
Set-PowerShell-Profile;
Set-WindowsTerminal-Settings;