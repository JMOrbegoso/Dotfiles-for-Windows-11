# Dotfiles for Microsoft Windows 11

Repeatable, reboot resilient Dotfiles script to setup a development environment in Microsoft Windows 11.

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
- Install Notepad++.
- Configure Notepad++.
- Set Notepad++ as the default program to open .txt, .xml, .ini, .bat, .cmd and .ps1 files.
- Install .NET SDK.
- Install Visual Studio 2019.
- Enable Windows Subsystem form Linux.
- Install Ubuntu 20.04 LTS in WSL.
- Install Docker Desktop.
- Configure File Explorer:
  - Show file extensions.
  - Open file explorer to This PC.
  - Set as background option only for extended Context Menu.
  - Disable recently opened items from JumpList.
- Microsoft Windows optional features:
  - Disable Windows Media Player.
  - Disable Internet Explorer.
  - Disable Microsoft XPS Document Writer.
  - Disable WorkFolders Client.
  - Enable Microsoft Hyper-V.
  - Enable Windows Sandbox.
- Configure Windows 11 power plan.
- Rename PC.
