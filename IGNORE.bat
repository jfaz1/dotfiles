del %userprofile%\.config\wezterm\wezterm.lua
mklink /H %userprofile%\.config\wezterm\wezterm.lua wezterm.lua

del %userprofile%\Documents\PowerShell\profile.ps1
mklink /H %userprofile%\Documents\PowerShell\profile.ps1 profile.ps1

del %appdata%\helix\config.toml
mklink /H %appdata%\helix\config.toml config.toml

pause
