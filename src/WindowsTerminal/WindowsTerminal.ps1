function Set-OhMyPosh-Theme
{
  $DotfilesOhMyPoshThemePath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WindowsTerminal" | Join-Path -ChildPath ".oh-my-posh-custom-theme.omp.json";

  Write-Host "Coping Oh My Posh custom theme:" -ForegroundColor "Green";

  Copy-Item $DotfilesOhMyPoshThemePath -Destination $env:UserProfile;

  Write-Host "Oh My Posh theme was successfully created." -ForegroundColor "Green";
}

Install-Module -Name "oh-my-posh";
Set-OhMyPosh-Theme;