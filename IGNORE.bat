del %userprofile%\.config\wezterm\wezterm.lua
mklink /H %userprofile%\.config\wezterm\wezterm.lua wezterm.lua

del %appdata%\helix\config.toml
mklink /H %appdata%\helix\config.toml config.toml

pause
