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
  -- Ctrl + F1 through F8 to move tabs
  table.insert(mykeys, {
    key = 'F' .. tostring(i),
    mods = 'CTRL',
    action = act.MoveTab(i - 1),
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

-- Open workspace Fuzzy Finder
table.insert(mykeys, {
  key = 'F12',
  mods = 'ALT',
  action = act.ShowLauncherArgs {
    flags = 'FUZZY|WORKSPACES',
  },
})

-- Spawn tab with Alt-T
table.insert(mykeys, {
  key = 't',
  mods = 'ALT',
  action = act.SpawnTab 'CurrentPaneDomain',
})

-- Close tab with Alt-Q
table.insert(mykeys, {
  key = 'q',
  mods = 'ALT',
  action = act.CloseCurrentPane { confirm = true },
})

-- Split pane vertically with Alt-V
table.insert(mykeys, {
  key = 'v',
  mods = 'ALT',
  action = act.SplitVertical { domain = 'CurrentPaneDomain' },
})

-- Switch between open panes
table.insert(mykeys, {
  key = '1',
  mods = 'CTRL',
  action = act.ActivatePaneByIndex(0)
})
table.insert(mykeys, {
  key = '2',
  mods = 'CTRL',
  action = act.ActivatePaneByIndex(1)
})

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace() == 'default' and '1 ' or window:active_workspace() .. ' ')
end)

table.insert(mykeys, {
  key = 'm',
  mods = 'ALT',
  action = wezterm.action_callback(function(win, pane)
    if maximized == false then
      win:maximize()
    else
      win:restore()
    end
    maximized = not maximized
  end),
})

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = wezterm.truncate_right(tab.active_pane.title, max_width - 2)
    return {
      { Text = ' [F' .. tab.tab_index + 1 .. '] ' .. tab.active_pane.title .. ' ' },
    }
  end
)

local scheme = wezterm.color.get_builtin_schemes()['Catppuccin Latte']
local bg = scheme.tab_bar.active_tab.bg_color
scheme.tab_bar.active_tab.bg_color = scheme.tab_bar.inactive_tab.bg_color
scheme.tab_bar.inactive_tab.bg_color = bg

return {
  default_prog = { 'C:/Program Files/PowerShell/7/pwsh.exe' }, -- IMPORTANT, CHANGE SHELL HERE
  font = wezterm.font('scientifica', { weight = "Medium" }),
  font_size = 16,
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
  color_schemes = {
    ['Catppuccin Latte'] = scheme,
  },
  color_scheme = "Catppuccin Latte",
  use_fancy_tab_bar = false,
  tab_max_width = 64,
}
