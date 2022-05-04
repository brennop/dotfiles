local wezterm = require 'wezterm';

return {
  default_prog = { "wsl", "~" },
  enable_tab_bar = false,
  font = wezterm.font("CaskaydiaCove Nerd Font"),
  font_size = 12,
  color_scheme = "Kolorit",
  window_close_confirmation = "NeverPrompt",
  initial_cols = 88,
  initial_rows = 44,
  window_background_opacity = 0.98,
}
