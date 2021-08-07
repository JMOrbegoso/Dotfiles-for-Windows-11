function Register-DotfilesScript-As-RunOnce()
{
  $RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce";
  $ScriptName = "DotfilesScript";
  $DotfilesMainScriptPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "setup.ps1";

  if (-not (Test-PathRegistryKey $RegPath $ScriptName))
  {
    New-ItemProperty -Path $RegPath -Name $ScriptName -PropertyType String -Value "powershell ${DotfilesMainScriptPath}";
  }
}

function Remove-DotfilesScript-From-RunOnce()
{
  $RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce";
  $ScriptName = "DotfilesScript";

  if (Test-PathRegistryKey $RegPath $ScriptName)
  {
    Remove-ItemProperty -Path $RegPath -Name $ScriptName;
  }
}