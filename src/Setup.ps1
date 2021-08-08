$GitHubRepositoryAuthor = "JMOrbegoso";
$GitHubRepositoryName = "Dotfiles-for-Windows-11";
$DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles";
$DotfilesWorkFolder = Join-Path -Path $DotfilesFolder -ChildPath "${GitHubRepositoryName}-main" | Join-Path -ChildPath "src";
$DotfilesHelpersFolder = Join-Path -Path $DotfilesWorkFolder -ChildPath "Helpers";
$DotfilesConfigFile = Join-Path -Path $DotfilesFolder -ChildPath "${GitHubRepositoryName}-main" | Join-Path -ChildPath "config.json";

Write-Host "Welcome to Dotfiles for Microsoft Windows 11" -ForegroundColor "Yellow";

# Load helpers
Write-Host "Loading helpers:" -ForegroundColor "Green";
$DotfilesHelpers = Get-ChildItem -Path "${DotfilesHelpersFolder}\*" -Include *.ps1 -Recurse;
foreach ($DotfilesHelper in $DotfilesHelpers)
{
  . $DotfilesHelper;
};

# Save user configuration in persistence
Set-Configuration-File -DotfilesConfigFile $DotfilesConfigFile -ComputerName $ComputerName -GitUserName $GitUserName -GitUserEmail $GitUserEmail -WorkspaceDisk $WorkspaceDisk;

# Load user configuration from persistence
$Config = Get-Configuration-File -DotfilesConfigFile $DotfilesConfigFile;

# Set alias for HKEY_CLASSES_ROOT
Set-PSDrive-HKCR;

if (-not (Get-PackageProvider-Installation-Status -PackageProviderName "NuGet"))
{
  Write-Host "Installing NuGet as package provider:" -ForegroundColor "Green";
  Install-PackageProvider -Name "NuGet" -Force;
}

if (-not (Get-PSRepository-Trusted-Status -PSRepositoryName "PSGallery"))
{
  Write-Host "Setting up PSGallery as PowerShell trusted repository:" -ForegroundColor "Green";
  Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted;
}

if (-not (Get-Module-Installation-Status -ModuleName "PackageManagement" -ModuleMinimumVersion "1.4.6"))
{
  Write-Host "Updating PackageManagement module:" -ForegroundColor "Green";
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
  Install-Module -Name "PackageManagement" -Force -MinimumVersion "1.4.6" -Scope "CurrentUser" -AllowClobber -Repository "PSGallery";
}

# Register the script to start after reboot
Register-DotfilesScript-As-RunOnce;

# Run scripts
Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "Chocolatey" | Join-Path -ChildPath "Chocolatey.ps1");
Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "Fonts" | Join-Path -ChildPath "Fonts.ps1");
Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "Git" | Join-Path -ChildPath "Git.ps1");
Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "Vim" | Join-Path -ChildPath "Vim.ps1");
Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "VSCode" | Join-Path -ChildPath "VSCode.ps1");
Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "WindowsTerminal" | Join-Path -ChildPath "WindowsTerminal.ps1");
Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "TeraCopy" | Join-Path -ChildPath "TeraCopy.ps1");
Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "Notepad++" | Join-Path -ChildPath "Notepad++.ps1");
Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "Dotnet" | Join-Path -ChildPath "Dotnet.ps1");
Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "WSL" | Join-Path -ChildPath "WSL.ps1");
Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "Docker" | Join-Path -ChildPath "Docker.ps1");
Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "VisualStudio2019" | Join-Path -ChildPath "VisualStudio2019.ps1");
Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "Windows" | Join-Path -ChildPath "Windows.ps1");

# Clean
# Unregister script from RunOnce
Remove-DotfilesScript-From-RunOnce;

Write-Host "Deleting Desktop shortcuts:" -ForegroundColor "Green";
Remove-Desktop-Shortcuts;

Write-Host "Cleaning Dotfiles workspace:" -ForegroundColor "Green";
Remove-Item $DotfilesFolder -Recurse -Force -ErrorAction SilentlyContinue;

Write-Host "The process has finished." -ForegroundColor "Yellow";

Write-Host "Restarting the PC in 10 seconds..." -ForegroundColor "Green";
Start-Sleep -Seconds 10;
Restart-Computer;