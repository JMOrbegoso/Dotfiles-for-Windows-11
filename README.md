# Dotfiles for Microsoft Windows 11

Dotfiles script to setup a development environment in Microsoft Windows 11.

## Usage

Open a PowerShell console as administrator and run:

```Powershell
$GitHubRepositoryAuthor = "JMOrbegoso"; `
$GitHubRepositoryName = "Dotfiles-for-Windows-11"; `
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; `
Invoke-Expression (Invoke-RestMethod -Uri "https://raw.githubusercontent.com/${GitHubRepositoryAuthor}/${GitHubRepositoryName}/main/Download.ps1");
```

## What does

- Install Chocolatey.
- Configure Chocolatey to remembered arguments for upgrades.
- Install Hack Nerd Font.
- Install Git;
- Configure Git.
- Install Vim;
- Install Vim-Plug.
- Install Vim plugins.
- Install Visual Studio Code.
- Configure Visual Studio Code.
- Install Visual Studio Code extensions.
- Install Oh My Posh for PowerShell.
- Configure Oh My Posh theme.
- Configure Windows Terminal.
- Install TeraCopy.
- Configure Windows 11 power plan.
