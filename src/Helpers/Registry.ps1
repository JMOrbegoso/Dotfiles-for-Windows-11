function Test-PathRegistryKey
{
  [CmdletBinding()]
  param (
    [Parameter( Position = 0, Mandatory = $TRUE)]
    [String]
    $Path,

    [Parameter( Position = 1, Mandatory = $TRUE)]
    [String]
    $Name
  )

  try
  {
    $Reg = Get-ItemPropertyValue -Path $Path -Name $Name;
    Return $TRUE;
  }
  catch
  {
    Return $FALSE;
  }
}