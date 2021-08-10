function Set-NotepadPlusPlus-Configuration {
  $NotepadPlusPlusConfigurationPath = Join-Path -Path $env:appdata -ChildPath "Notepad++";
  $DotfilesNotepadPlusPlusConfigurationPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Notepad++";

  if (-not (Test-Path -Path $NotepadPlusPlusConfigurationPath)) {
    Write-Host "Notepad++ is not installed or configured." -ForegroundColor "Green";
  }
  else {
    Write-Host "Configuring Notepad++:" -ForegroundColor "Green";
    
    Get-ChildItem -Path "${DotfilesNotepadPlusPlusConfigurationPath}\*" -Include *.xml -Recurse | Copy-Item -Destination $NotepadPlusPlusConfigurationPath -Force;

    Write-Host "Notepad++ was successfully configured." -ForegroundColor "Green";
  }
}

function Set-NotepadPlusPlus-Extensions {
  $NotepadPlusPlusExePath = Join-Path -Path $env:ProgramFiles -ChildPath "Notepad++" | Join-Path -ChildPath "notepad++.exe";
  $NotepadPlusPlusIconPath = Join-Path -Path $env:ProgramFiles -ChildPath "Notepad++" | Join-Path -ChildPath "NppShell_06.dll";
  $PowerShellIconPath = Join-Path -Path $env:SystemRoot -ChildPath "System32" | Join-Path -ChildPath "WindowsPowerShell" | Join-Path -ChildPath "v1.0" | Join-Path -ChildPath "powershell_ise.exe";
  $Shell32Path = Join-Path -Path $env:SystemRoot -ChildPath "System32" | Join-Path -ChildPath "SHELL32.dll";

  Write-Host "Configuring Microsoft Windows to open files with the .bat extension with Notepad++:" -ForegroundColor "Green";
  Register-FTA $NotepadPlusPlusExePath ".bat" -Icon "${Shell32Path},71";

  Write-Host "Configuring Microsoft Windows to open files with the .cmd extension with Notepad++:" -ForegroundColor "Green";
  Register-FTA $NotepadPlusPlusExePath ".cmd" -Icon "${Shell32Path},71";

  Write-Host "Configuring Microsoft Windows to open files with the .ini extension with Notepad++:" -ForegroundColor "Green";
  Register-FTA $NotepadPlusPlusExePath ".ini" -Icon "${Shell32Path},69";

  Write-Host "Configuring Microsoft Windows to open files with the .ps1 extension with Notepad++:" -ForegroundColor "Green";
  Register-FTA $NotepadPlusPlusExePath ".ps1" -Icon "${PowerShellIconPath},1";

  Write-Host "Configuring Microsoft Windows to open files with the .sh extension with Notepad++:" -ForegroundColor "Green";
  Register-FTA $NotepadPlusPlusExePath ".sh" -Icon "${Shell32Path},71";

  Write-Host "Configuring Microsoft Windows to open files with the .txt extension with Notepad++:" -ForegroundColor "Green";
  Register-FTA $NotepadPlusPlusExePath ".txt" -Icon "${Shell32Path},70";

  Write-Host "Configuring Microsoft Windows to open files with the .xml extension with Notepad++:" -ForegroundColor "Green";
  Register-FTA $NotepadPlusPlusExePath ".xml" -Icon "${NotepadPlusPlusIconPath},0";
  
  Write-Host "Notepad++ was successfully configured as Microsoft Windows default program." -ForegroundColor "Green";
}

choco install -y "notepadplusplus";
Set-NotepadPlusPlus-Configuration;
Set-NotepadPlusPlus-Extensions;