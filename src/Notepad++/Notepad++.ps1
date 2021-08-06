function Set-NotepadPlusPlus-Configuration
{
  $NotepadPlusPlusConfigurationPath = Join-Path -Path $env:appdata -ChildPath "Notepad++";
  $DotfilesNotepadPlusPlusConfigurationPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Notepad++";

  if (-not (Test-Path -Path $NotepadPlusPlusConfigurationPath))
  {
    Write-Host "Notepad++ is not installed or configured." -ForegroundColor "Green";
  }
  else
  {
    Write-Host "Configuring Notepad++:" -ForegroundColor "Green";

    Get-ChildItem -Path "${DotfilesNotepadPlusPlusConfigurationPath}\*" -Include *.xml -Recurse | Copy-Item -Destination $NotepadPlusPlusConfigurationPath -Force;

    Write-Host "Notepad++ was successfully configured." -ForegroundColor "Green";
  }
}

choco install -y "notepadplusplus";
Set-NotepadPlusPlus-Configuration;