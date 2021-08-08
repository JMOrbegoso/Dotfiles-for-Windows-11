function Get-Module-Installation-Status {
  [CmdletBinding()]
  param(
    [Parameter(Position = 0, Mandatory = $TRUE)]
    [string]
    $ModuleName,

    [Parameter(Position = 1, Mandatory = $FALSE)]
    [string]
    $ModuleMinimumVersion
  )

  try {
    if (-not ([string]::IsNullOrEmpty($ModuleMinimumVersion))) {
      if ((Get-Module -ListAvailable -Name $ModuleName).Version -ge $ModuleMinimumVersion) {
        return $TRUE;
      }
      return $FALSE;
    }

    if (Get-Module -ListAvailable -Name $ModuleName) {
      return $TRUE;
    }
    else {
      return $FALSE;
    }
  }
  catch [Exception] {
    return $FALSE;
  }
}