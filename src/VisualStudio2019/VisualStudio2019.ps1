function Set-OpenWithVSCommunity-To-Extended-ContextMenu {
  $RegPaths = "HKCR:\Directory\Background\shell\AnyCode", "HKCR:\Directory\shell\AnyCode";

  foreach ($RegPath in $RegPaths) {
    if (-not (Test-PathRegistryKey -Path $RegPath -Name "Extended")) {
      Write-Host "Moving 'Open with Visual Studio' to extended context menu:" -ForegroundColor "Green";
      New-ItemProperty -Path $RegPath -Name "Extended" -PropertyType String;
    }
  }
}

choco install -y "visualstudio2019community" --package-parameters "--passive --locale en-US";
choco install -y "visualstudio2019-workload-netweb" --package-parameters "--passive --locale en-US";
Set-OpenWithVSCommunity-To-Extended-ContextMenu;