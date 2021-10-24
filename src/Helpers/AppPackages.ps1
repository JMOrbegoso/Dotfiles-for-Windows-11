function Uninstall-AppPackage {
  [CmdletBinding()]
  param (
    [Parameter( Position = 0, Mandatory = $TRUE)]
    [String]
    $Name
  )

  try {
    Get-AppxPackage $Name -AllUsers | Remove-AppxPackage;
    Get-AppXProvisionedPackage -Online | Where-Object DisplayName -like $Name | Remove-AppxProvisionedPackage -Online;    
  }
  catch {
    
  }  
}