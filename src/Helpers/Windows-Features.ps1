function Get-WindowsFeature-Installation-Status
{
  [CmdletBinding()]
  param(
    [Parameter(Position = 0, Mandatory = $TRUE)]
    [string]
    $FeatureName
  )

  if ((Get-WindowsOptionalFeature -FeatureName $FeatureName -Online).State -eq "Enabled")
  {
    return $TRUE;
  }
  else
  {
    return $FALSE;
  }
}

function Disable-WindowsFeature
{
  [CmdletBinding()]
  param (
    [Parameter( Position = 0, Mandatory = $TRUE)]
    [String]
    $FeatureKey,

    [Parameter( Position = 1, Mandatory = $TRUE)]
    [String]
    $FeatureName
  )

  if (Get-WindowsFeature-Installation-Status $FeatureKey)
  {
    Write-Host "Disabling" $FeatureName ":" -ForegroundColor "Green";
    Disable-WindowsOptionalFeature -FeatureName $FeatureKey -Online -NoRestart;
  }
  else
  {
    Write-Host $FeatureName "is already disabled." -ForegroundColor "Green";
  }
}

function Enable-WindowsFeature
{
  [CmdletBinding()]
  param (
    [Parameter( Position = 0, Mandatory = $TRUE)]
    [String]
    $FeatureKey,

    [Parameter( Position = 1, Mandatory = $TRUE)]
    [String]
    $FeatureName
  )

  if (-not (Get-WindowsFeature-Installation-Status $FeatureKey))
  {
    Write-Host "Enabling" $FeatureName ":" -ForegroundColor "Green";
    Enable-WindowsOptionalFeature -FeatureName $FeatureKey -Online -All -NoRestart;
  }
  else
  {
    Write-Host $FeatureName "is already enabled." -ForegroundColor "Green";
  }
}