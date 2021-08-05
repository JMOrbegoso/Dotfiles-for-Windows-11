function Install-Chocolatey
{
  Write-Host "Installing Chocolatey:" -ForegroundColor "Green";
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
  Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://chocolatey.org/install.ps1"));
}

function Set-Chocolatey-Configuration
{
  Write-Host "Configuring Chocolatey:" -ForegroundColor "Green";
  choco feature enable -n=useRememberedArgumentsForUpgrades;
}

Install-Chocolatey;
Set-Chocolatey-Configuration;