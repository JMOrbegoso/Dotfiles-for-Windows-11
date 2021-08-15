function Set-Workspace-Folder-Windows {
  $WorkspaceFolder = Join-Path -Path $Config.WorkspaceDisk -ChildPath "Workspace";

  if (-not (Test-Path $WorkspaceFolder)) {
    Write-Host "Creating your development workspace folder in Windows 11:" -ForegroundColor "Green";
    New-Item $WorkspaceFolder -ItemType directory;
  }
}

function Set-Workspace-Folder-Ubuntu {
  Write-Host "Creating your development workspace folder in Ubuntu:" -ForegroundColor "Green";
  wsl mkdir -p -v ~/Workspace;
}

Set-Workspace-Folder-Windows;
Set-Workspace-Folder-Ubuntu;