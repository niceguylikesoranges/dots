---@diagnostic disable-next-line: undefined-global
local hl = hl
local programs = require("config.programs")

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	match = { class = programs.browserClass },
	opacity = "1.0 override 1.0 override 1.0 override",
})

hl.window_rule({
	name = "bluetui-float",
	match = { class = "^bluetui$" },
	float = true,
	center = true,
	size = "700 450",
})
