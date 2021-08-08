function Get-PSRepository-Trusted-Status {
  [CmdletBinding()]
  param(
    [Parameter(Position = 0, Mandatory = $TRUE)]
    [string]
    $PSRepositoryName
  )

  try {
    if (-not (Get-PSRepository -Name $PSRepositoryName -ErrorAction SilentlyContinue)) {
      return $FALSE;
    }

    if ((Get-PSRepository -Name $PSRepositoryName).InstallationPolicy -eq "Trusted") {
      return $TRUE;
    }
    return $FALSE;
  }
  catch [Exception] {
    return $FALSE;
  }
}