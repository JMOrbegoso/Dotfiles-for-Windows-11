function Set-WindowsExplorer-ShowFileExtensions
{
  Write-Host "Configuring Windows File Explorer to show file extensions:" -ForegroundColor "Green";

  $RegPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced";
  Set-ItemProperty -Path $RegPath -Name "HideFileExt" -Value 0;
}

function Set-WindowsFileExplorer-StartFolder
{
  Write-Host "Configuring start folder of Windows File Explorer:" -ForegroundColor "Green";

  $RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced";

  if (-not (Test-PathRegistryKey -Path $RegPath -Name "LaunchTo"))
  {
    New-ItemProperty -Path $RegPath -Name "LaunchTo" -PropertyType DWord;
  }

  Set-ItemProperty -Path $RegPath -Name "LaunchTo" -Value 1; # [This PC: 1], [Quick access: 2], [Downloads: 3]
}

function Set-SetAsBackground-To-Extended-ContextMenu
{
  Write-Host "Configuring Context Menu to show the option 'Set as Background' just in Extended Context Menu:" -ForegroundColor "Green";

  $Extensions = ".bmp", ".dib", ".gif", ".jfif", ".jpe", ".jpeg", ".jpg", ".png", ".tif", ".tiff", ".wdp";

  foreach ($Extension in $Extensions)
  {
    $RegPath = "HKCR:\SystemFileAssociations\${Extension}\Shell\setdesktopwallpaper";

    if (Test-Path $RegPath)
    {
      if (-not (Test-PathRegistryKey -Path $RegPath -Name "Extended"))
      {
        New-ItemProperty -Path $RegPath -Name "Extended" -PropertyType String;
      }
    }
  }
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
Set-WindowsFileExplorer-StartFolder;
Set-SetAsBackground-To-Extended-ContextMenu;
Set-Power-Configuration;
Rename-PC;