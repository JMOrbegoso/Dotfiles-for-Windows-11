#######################################################################
##                             Oh my Posh                            ##
#######################################################################

Import-Module "oh-my-posh";
Set-PoshPrompt -Theme "~/.oh-my-posh-custom-theme.omp.json";

#######################################################################
##                             Chocolatey                            ##
#######################################################################

# Chocolatey profile
$ChocolateyProfile = Join-Path -Path $env:ChocolateyInstall -ChildPath "helpers" | Join-Path -ChildPath "chocolateyProfile.psm1";
if (Test-Path($ChocolateyProfile)) {
  Import-Module $ChocolateyProfile;
};

#######################################################################
##                         Directory Aliases                         ##
#######################################################################

function Set-Location-One-Time { Set-Location ".."; };
Set-Alias -Name ".." -Value "Set-Location-One-Time";

function Set-Location-Two-Times { Set-Location "..\.."; };
Set-Alias -Name "..." -Value "Set-Location-Two-Times";

function Set-Location-Three-Times { Set-Location "..\..\.."; };
Set-Alias -Name "...." -Value "Set-Location-Three-Times";

function New-Folder-Navigate-To-It {
  param($newFolderName);

  New-Item $newFolderName -ItemType directory;
  Set-Location -Path $newFolderName;
};
Set-Alias -Name "mkcd" -Value "New-Folder-Navigate-To-It";

#######################################################################
##                      WindowsTerminal Profile                      ##
#######################################################################

function Invoke-Edit-WindowsTerminal-Profile {
  vim $PROFILE;
};
Set-Alias -Name "editprofile" -Value "Invoke-Edit-WindowsTerminal-Profile";

function Invoke-Refresh-WindowsTerminal-Profile {
  . $PROFILE;
};
Set-Alias -Name "sourceprofile" -Value "Invoke-Refresh-WindowsTerminal-Profile";

#######################################################################
##                            Git Aliases                            ##
#######################################################################

function Invoke-Git-Super-Clone {
  param($repositoryName);
  $folderName = $repositoryName.Split("/")[-1].Replace(".git", "")
  & git clone $repositoryName $folderName | Out-Null;
  Set-Location $folderName;
  git submodule init;
  git submodule update;
};
Set-Alias -Name "gsc" -Value "Invoke-Git-Super-Clone";

function Invoke-Git-Checkout-Branch {
  param($branchName);

  git checkout -b $branchName;
};
Set-Alias -Name "gcb" -Value "Invoke-Git-Checkout-Branch";

function Invoke-Git-Add {
  param($fileToAdd);

  git add $fileToAdd;
};
Set-Alias -Name "ga" -Value "Invoke-Git-Add";

function Invoke-Git-Add-All {
  git add --all;
};
Set-Alias -Name "gaa" -Value "Invoke-Git-Add-All";

function Invoke-Git-Status {
  git status;
};
Set-Alias -Name "gst" -Value "Invoke-Git-Status";

function Invoke-Git-Commit-Message {
  param($message);

  git commit -m $message;
};
Set-Alias -Name "gcmsg" -Value "Invoke-Git-Commit-Message";

function Invoke-Git-Push-Origin-Current-Branch {
  git push origin HEAD;
};
Set-Alias -Name "ggp" -Value "Invoke-Git-Push-Origin-Current-Branch";

function Invoke-Git-Log-Stat {
  git log --stat;
};
Set-Alias -Name "glg" -Value "Invoke-Git-Log-Stat";

function Invoke-Git-Undo-Last-Commit {
  git reset --soft HEAD^1;
};
Set-Alias -Name "gulc" -Value "Invoke-Git-Undo-Last-Commit";

#######################################################################
##                     System Management Aliases                     ##
#######################################################################

function Update-System {
  Install-WindowsUpdate -IgnoreUserInput -IgnoreReboot -AcceptAll;
  Update-Module;
  Update-Help -Force;
  choco upgrade -y "chocolatey";
  choco upgrade -y all;
};
Set-Alias -Name "updatesystem" -Value "Update-System";

#######################################################################
##                            Vim Aliases                            ##
#######################################################################

function Invoke-Edit-Vimrc {
  vim ~/.vimrc;
};
Set-Alias -Name "editvim" -Value "Invoke-Edit-Vimrc";

#######################################################################
##                       Environment Variables                       ##
#######################################################################

function Invoke-List-Path {
  $env:Path -split ';';
};
Set-Alias -Name "pathl" -Value "Invoke-List-Path";