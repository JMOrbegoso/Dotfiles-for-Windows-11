function Set-Configuration-File
{
  [CmdletBinding()]
  param (
    [Parameter( Position = 0, Mandatory = $TRUE)]
    [String]
    $DotfilesConfigFile,

    [Parameter( Position = 1, Mandatory = $TRUE)]
    [String]
    $ComputerName,
    
    [Parameter( Position = 2, Mandatory = $TRUE)]
    [String]
    $GitUserName,
    
    [Parameter( Position = 3, Mandatory = $TRUE)]
    [String]
    $GitUserEmail,

    [Parameter( Position = 4, Mandatory = $TRUE)]
    [String]
    $WorkspaceDisk
  )

  if (-not (Test-Path -Path $DotfilesConfigFile))
  {
    Write-Host "Creating config.json file:" -ForegroundColor "Green";
    $ConfigJsonBody = [PSCustomObject]@{
      ComputerName = $ComputerName
      GitUserName = $GitUserName
      GitUserEmail = $GitUserEmail
      WorkspaceDisk = $WorkspaceDisk
    };

    Set-Content -Path $DotfilesConfigFile -Value ($ConfigJsonBody | ConvertTo-Json);

    Write-Host "config.json file successfully created." -ForegroundColor "Green";
  }
}

function Get-Configuration-File
{
  [CmdletBinding()]
  param (
    [Parameter( Position = 0, Mandatory = $TRUE)]
    [String]
    $DotfilesConfigFile
  )
  
  $Config = @{};
  $ConfigContent = Get-Content $DotfilesConfigFile | ConvertFrom-Json;

  Write-Host "Reading config.json file:" -ForegroundColor "Green";

  foreach ($Property in $ConfigContent.PSObject.Properties)
  {
    $Config[$Property.Name] = $Property.Value;
  }
  
  Write-Host "config.json contains:" -ForegroundColor "Green";
  Write-Host -ForegroundColor "Green" ($Config | Out-String);

  return $Config;
}