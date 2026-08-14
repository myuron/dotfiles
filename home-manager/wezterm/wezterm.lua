local wezterm = require "wezterm"
local config = wezterm.config_builder()

config.automatically_reload_config = true

-- Font
config.font_size = 10.0
config.use_ime = true

-- UI
config.color_scheme = "Catppuccin Mocha"
config.front_end = "WebGpu"
config.window_background_opacity = 0.85
-- config.wayland_window_background_blur = 20
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}
config.window_background_gradient = {
  colors = { "#1e1e2e" },
}

-- Tab
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5c6d74"
  local foreground = "#FFFFFF"

  if tab.is_active then
    background = "#cba6f7"
    foreground = "#FFFFFF"
  end

  local title = " " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. " "

  return {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
  }
end)

-- --------------------------------------------------
-- Keymap
-- --------------------------------------------------
local act = wezterm.action
config.leader = { key = "q", mods = "CTRL", time_milliseconds = 2000 }
config.keys = {
  -- Tab Management
  { key = "t", mods = "LEADER", action = act({ SpawnTab = "CurrentPaneDomain" }) },
  -- Pane Management
  { key = "v", mods = "LEADER", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "s", mods = "LEADER", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
}

return config
