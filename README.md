# Dotfiles-for-Windows-11
Dotfiles script to setup a development environment in Microsoft Windows 11.

## Usage

Open a PowerShell console as administrator and run:

```Powershell
$GitHubRepositoryAuthor = "JMOrbegoso"; `
$GitHubRepositoryName = "Dotfiles-for-Windows-11"; `
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; `
Invoke-Expression (Invoke-RestMethod -Uri "https://raw.githubusercontent.com/${GitHubRepositoryAuthor}/${GitHubRepositoryName}/main/Download.ps1");
```
