function Test-PathRegistryKey {
  [CmdletBinding()]
  param (
    [Parameter( Position = 0, Mandatory = $TRUE)]
    [String]
    $Path,

    [Parameter( Position = 1, Mandatory = $TRUE)]
    [String]
    $Name
  )

  try {
    $Reg = Get-ItemPropertyValue -Path $Path -Name $Name;
    Return $TRUE;
  }
  catch {
    Return $FALSE;
  }
}

function Set-PSDrive-HKCR {
  Write-Host "Setting alias of HKEY_CLASSES_ROOT:" -ForegroundColor "Green";
  New-PSDrive -PSProvider "registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR" -Scope global;
}