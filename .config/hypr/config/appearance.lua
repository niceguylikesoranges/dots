---@diagnostic disable-next-line: undefined-global
local hl = hl

hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 0,

		border_size = 1,

		col = {
			active_border = { colors = { "rgba(ffffffcc)", "rgba(ffffffcc)" }, angle = 45 },
			inactive_border = "rgba(000000ff)",
		},

		resize_on_border = false,
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 0,
		rounding_power = 2,

		active_opacity = 0.9,
		inactive_opacity = 0.9,
		fullscreen_opacity = 1,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 8,
			passes = 2,
			ignore_opacity = true,
		},
	},

	animations = {
		enabled = false,
	},

	misc = {
		font_family = "JetBrainsMono Nerd Font",
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
	},
})
