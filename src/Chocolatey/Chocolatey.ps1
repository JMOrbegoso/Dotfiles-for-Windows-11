function Install-Chocolatey
{
  Write-Host "Installing Chocolatey:" -ForegroundColor "Green";
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
  Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://chocolatey.org/install.ps1"));
}

Install-Chocolatey;