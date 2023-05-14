local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux
local window = wezterm.window

local maximized = false

local mykeys = {}
for i = 1, 8 do 
  -- F1 through F8 for tabs 
  table.insert(mykeys, {
    key = 'F' .. tostring(i),
    action = act.ActivateTab(i - 1),
  })
  -- Alt + 1 through 8 to change workspace
  table.insert(mykeys, {
    key = tostring(i),
    mods = 'ALT',
    action = act.SwitchToWorkspace {
      name = i == 1 and 'default' or tostring(i)
    },
  })
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = wezterm.truncate_right(tab.active_pane.title, 30)
    if string.len(title) == 30 then title = title .. '..' end
    if title == 'bash.exe' or title == 'zsh.exe' then title = '' end
    return {
      { Text = ' [F' .. tab.tab_index + 1 .. '] ' .. title .. ' ' },
    }
  end
)

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace() == 'default' and '1 ' or window:active_workspace() .. ' ')
end)

return {
  -- default_prog = { 'C:/Program Files/Git/bin/bash.exe' }, -- IMPORTANT, CHANGE SHELL HERE
  font = wezterm.font('FantasqueSansMono Nerd Font', { weight = "Regular" }),
  font_size = 14,
  default_cursor_style = "BlinkingBlock",
  cursor_blink_rate = 600,
  animation_fps = 240,
  max_fps = 240,
  window_padding = {
    left = '0cell',
    right = '0cell',
    top = '0cell',
    bottom = '0cell',
  },
  keys = mykeys,
  window_decorations = "RESIZE",
  pane_focus_follows_mouse = true,
  use_fancy_tab_bar = false,
  tab_max_width = 64,
  color_scheme = "Red Planet",
  colors = {
    cursor_bg = '#B36B59',
    cursor_border = '#B36B59',
    cursor_fg = '#C3BFBC',
    foreground = '#C3BFBC',
    tab_bar = {
      background = '#222222',
      active_tab = {
        bg_color = '#383735',
        fg_color = '#dad7d5',
      },
      inactive_tab = {
        bg_color = '#222222',
        fg_color = '#c2b4a8',
      }
    }
  },
}
