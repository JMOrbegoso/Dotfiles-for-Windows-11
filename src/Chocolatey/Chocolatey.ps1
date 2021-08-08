function Install-Chocolatey {
  Write-Host "Installing Chocolatey:" -ForegroundColor "Green";
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
  Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://chocolatey.org/install.ps1"));
}

function Set-Chocolatey-Configuration {
  Write-Host "Configuring Chocolatey:" -ForegroundColor "Green";
  choco feature enable -n=useRememberedArgumentsForUpgrades;
}

function Enable-Chocolatey-Helpers {
  Write-Host "Loading Chocolatey helpers:" -ForegroundColor "Green";

  $ChocolateyProfile = Join-Path -Path $env:ChocolateyInstall -ChildPath "helpers" | Join-Path -ChildPath "chocolateyProfile.psm1";

  if (Test-Path($ChocolateyProfile)) {
    Import-Module $ChocolateyProfile;
  };
}

Install-Chocolatey;
Set-Chocolatey-Configuration;
Enable-Chocolatey-Helpers;