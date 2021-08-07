function Get-PackageProvider-Installation-Status
{
  [CmdletBinding()]
  param(
    [Parameter(Position = 0, Mandatory = $TRUE)]
    [string]
    $PackageProviderName
  )

  try
  {
    Get-PackageProvider -Name $PackageProviderName;
    return $TRUE;
  }
  catch [Exception]
  {
    return $FALSE;
  }
}