function Remove-Desktop-Shortcuts {
  $UserDesktopPath = [Environment]::GetFolderPath("Desktop");
  $PublicDesktopPath = "${env:Public}\Desktop";

  Write-Host "Deleting shorcuts in desktop:" -ForegroundColor "Green";

  Get-ChildItem -Path "${UserDesktopPath}\*" -Include "*.lnk", "*.url" -Recurse | Remove-Item;
  Get-ChildItem -Path "${PublicDesktopPath}\*" -Include "*.lnk", "*.url" -Recurse | Remove-Item;

  Write-Host "Shorcuts in desktop successfully deleted." -ForegroundColor "Green";
}