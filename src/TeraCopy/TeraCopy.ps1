function Install-TeraCopy
{
  $DotfilesTeraCopyInstallerPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "TeraCopy" | Join-Path -ChildPath "teracopy23.exe";

  if (-not (Test-Path "${env:ProgramFiles}\TeraCopy\TeraCopy.exe"))
  {
    if (-not (Test-Path $DotfilesTeraCopyInstallerPath))
    {
      Write-Host "Downloading TeraCopy 2.3:" -ForegroundColor "Green";
      Invoke-WebRequest -uri "https://www.codesector.com/files/teracopy23.exe" -O $DotfilesTeraCopyInstallerPath;
      Write-Host "TeraCopy was successfully downloaded." -ForegroundColor "Green";
    }
    
    Write-Host "Installing TeraCopy:" -ForegroundColor "Green";
    Start-Process -FilePath $DotfilesTeraCopyInstallerPath -ArgumentList "/VERYSILENT /NORESTART";
    Write-Host "TeraCopy was successfully installed." -ForegroundColor "Green";
  }
}

function Set-TeraCopy-As-Default-Copy-Handler
{
  $TeraCopyRegPath = "${env:ProgramFiles}\TeraCopy\DefaultHandler.reg";

  if (Test-Path $TeraCopyRegPath)
  {
    Write-Host "Setting TeraCopy as default copy and move handler:" -ForegroundColor "Green";
    
    reg import $TeraCopyRegPath;

    Write-Host "TeraCopy was successfully configured as default copy and move handler." -ForegroundColor "Green";
  }
  else
  {
    Write-Host "${TeraCopyRegPath} was not found." -ForegroundColor "Green";
  }
}

function Set-TeraCopy-Configuration
{
  $TeraCopySettingsPath = Join-Path -Path $env:appdata -ChildPath "TeraCopy";
  $DotfilesTeraCopySettingsPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "TeraCopy" | Join-Path -ChildPath "Options.ini";

  if (-not (Test-Path $TeraCopySettingsPath))
  {
    New-Item $TeraCopySettingsPath -ItemType directory;
  }

  Write-Host "Configuring TeraCopy:" -ForegroundColor "Green";
  Copy-Item $DotfilesTeraCopySettingsPath -Destination $TeraCopySettingsPath;
  Write-Host "TeraCopy was successfully configured." -ForegroundColor "Green";
}

Install-TeraCopy;
Set-TeraCopy-As-Default-Copy-Handler;
Set-TeraCopy-Configuration;