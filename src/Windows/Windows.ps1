function Set-WindowsExplorer-ShowFileExtensions
{
  Write-Host "Configuring Windows File Explorer to show file extensions:" -ForegroundColor "Green";

  $RegPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced";
  Set-ItemProperty -Path $RegPath -Name "HideFileExt" -Value 0;
}

function Set-Power-Configuration
{
  Write-Host "Configuring power plan:" -ForegroundColor "Green";
  # AC: Alternating Current (Wall socket).
  # DC: Direct Current (Battery).

  # Turn off disk timeout
  powercfg -change "disk-timeout-ac" 0;
  powercfg -change "disk-timeout-dc" 0;
  # Hibernate timeout
  powercfg -change "hibernate-timeout-ac" 0;
  powercfg -change "hibernate-timeout-dc" 0;
  # Sleep timeout
  powercfg -change "standby-timeout-ac" 0;
  powercfg -change "standby-timeout-dc" 0;
  # Turn off screen timeout
  powercfg -change "monitor-timeout-ac" 5;
  powercfg -change "monitor-timeout-dc" 5;

  Write-Host "Power plan successfully updated." -ForegroundColor "Green";
}

function Rename-PC
{
  if ($env:COMPUTERNAME -ne $Config.ComputerName)
  {
    Write-Host "Renaming PC:" -ForegroundColor "Green";

    Rename-Computer -NewName $Config.ComputerName -Force;

    Write-Host "PC renamed, restart it to see the changes." -ForegroundColor "Green";
  }
  else
  {
    Write-Host "The PC name is" $Config.ComputerName "so it is not necessary to rename it." -ForegroundColor "Green";
  }
}

Set-WindowsExplorer-ShowFileExtensions;
Set-Power-Configuration;
Rename-PC;