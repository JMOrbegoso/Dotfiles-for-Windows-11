function Set-OpenWithVSCommunity-To-Extended-ContextMenu {
  $RegPaths = "HKCR:\Directory\Background\shell\AnyCode", "HKCR:\Directory\shell\AnyCode";

  foreach ($RegPath in $RegPaths) {
    if (-not (Test-PathRegistryKey -Path $RegPath -Name "Extended")) {
      Write-Host "Moving 'Open with Visual Studio' to extended context menu:" -ForegroundColor "Green";
      New-ItemProperty -Path $RegPath -Name "Extended" -PropertyType String;
    }
  }
}

function Set-VS2019-Nuget-Configuration {
  $NugetConfigPath = Join-Path -Path ${env:ProgramFiles(x86)} -ChildPath "NuGet" | Join-Path -ChildPath "Config";
  $DotfilesNugetConfigFile = Join-Path -Path $DotfilesWorkFolder -ChildPath "VisualStudio2019" | Join-Path -ChildPath "Nuget.Config";

  if (-not (Test-Path -Path $NugetConfigPath)) {
    New-Item $NugetConfigPath -ItemType directory;
  }

  Write-Host "Configuring NuGet package source:" -ForegroundColor "Green";
  Copy-Item $DotfilesNugetConfigFile -Destination $NugetConfigPath;
  Write-Host "NuGet package source successfully configured." -ForegroundColor "Green";
}

choco install -y "visualstudio2019community" --package-parameters "--passive --locale en-US";
choco install -y "visualstudio2019-workload-netweb" --package-parameters "--passive --locale en-US" --execution-timeout 7200;
Set-VS2019-Nuget-Configuration;
Set-OpenWithVSCommunity-To-Extended-ContextMenu;