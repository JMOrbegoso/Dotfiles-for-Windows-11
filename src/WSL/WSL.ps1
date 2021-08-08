choco install -y "wsl2" --params "/Version:2 /Retry:true";
choco install -y "wsl-ubuntu-2004" --params "/InstallRoot:true" --execution-timeout 3600;

Write-Host "Updating Ubuntu package repository:" -ForegroundColor "Green";
wsl sudo apt --yes update;

Write-Host "Upgrading Ubuntu packages:" -ForegroundColor "Green";
wsl sudo apt --yes upgrade;

Write-Host "Installing CURL in Ubuntu:" -ForegroundColor "Green";
wsl sudo apt install --yes --no-install-recommends curl;

Write-Host "Installing NeoFetch in Ubuntu:" -ForegroundColor "Green";
wsl sudo apt install --yes --no-install-recommends neofetch;

Write-Host "Installing Git in Ubuntu:" -ForegroundColor "Green";
wsl sudo apt install --yes --no-install-recommends git;

Write-Host "Installing Vim in Ubuntu:" -ForegroundColor "Green";
wsl sudo apt install --yes --no-install-recommends vim;

Write-Host "Installing Zsh in Ubuntu:" -ForegroundColor "Green";
wsl sudo apt install --yes --no-install-recommends zsh;