---@diagnostic disable-next-line: undefined-global
local hl = hl
local programs = require("config.programs")

local mainMod = "SUPER"

local bind = hl.bind

-- Apps and session
bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(programs.terminal), { description = "Open terminal" })
bind(mainMod .. " + space", hl.dsp.exec_cmd("rofi -show drun"), { description = "App launcher" })
bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager), { description = "File manager" })
bind(mainMod .. " + B", hl.dsp.exec_cmd(programs.browser), { description = "Open browser" })
bind(mainMod .. " + R", hl.dsp.exec_cmd(programs.menu), { description = "Run launcher (wofi)" })
bind(mainMod .. " + K", hl.dsp.exec_cmd("~/.local/bin/keybinds"), { description = "Keybind cheat sheet" })
bind(
	mainMod .. " + SHIFT + L",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"),
	{ description = "Log out" }
)
hl.bind(
	mainMod .. " + SHIFT + B",
	hl.dsp.exec_cmd("kitty --class bluetui -e bluetui"),
	{ description = "Bluetooth manager" }
)

-- Window management
bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close(), { description = "Close window" })
bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating" })
bind(mainMod .. " + P", hl.dsp.window.pseudo(), { description = "Toggle pseudotile" })
bind(mainMod .. " + J", hl.dsp.layout("togglesplit"), { description = "Toggle split direction" })

-- Focus
for _, dir in ipairs({ "left", "right", "up", "down" }) do
	bind(mainMod .. " + " .. dir, hl.dsp.focus({ direction = dir }), { description = "Focus " .. dir })
	bind(
		mainMod .. " + SHIFT + " .. dir,
		hl.dsp.window.move({ direction = dir }),
		{ description = "Move window " .. dir }
	)
end

-- Resize
local resize = {
	{ "minus", -40, 0, "Shrink window width" },
	{ "equal", 40, 0, "Grow window width" },
	{ "SHIFT + minus", 0, -40, "Shrink window height" },
	{ "SHIFT + equal", 0, 40, "Grow window height" },
}
for _, r in ipairs(resize) do
	bind(
		mainMod .. " + " .. r[1],
		hl.dsp.window.resize({ x = r[2], y = r[3], relative = true }),
		{ repeating = true, description = r[4] }
	)
end

-- Workspaces
for i = 1, 10 do
	local key = i % 10
	bind(
		mainMod .. " + " .. key,
		hl.dsp.focus({ workspace = i }),
		{ description = "Switch to workspace 1-10 (0 = 10)" }
	)
	bind(
		mainMod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ workspace = i }),
		{ description = "Move window to workspace 1-10 (0 = 10)" }
	)
end

bind(mainMod .. " + W", hl.dsp.workspace.toggle_special("magic"), { description = "Toggle scratchpad" })
bind(
	mainMod .. " + SHIFT + W",
	hl.dsp.window.move({ workspace = "special:magic" }),
	{ description = "Move window to scratchpad" }
)

bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Next workspace" })
bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Previous workspace" })

-- Mouse
bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Drag window" })
bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true, description = "Resize window (mouse)" })
bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window (mouse)" })

-- Media and hardware keys
local function lockedOpts(description)
	return { locked = true, repeating = true, description = description }
end

bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), lockedOpts("Volume up"))
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), lockedOpts("Volume down"))
bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), lockedOpts("Mute speakers"))
bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), lockedOpts("Mute microphone"))
bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), lockedOpts("Brightness up"))
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), lockedOpts("Brightness down"))

-- Requires playerctl
bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true, description = "Next track" })
bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Play / pause" })
bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Play / pause" })
bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true, description = "Previous track" })
bind(mainMod .. " + comma", hl.dsp.exec_cmd("playerctl previous"), { description = "Previous track" })
bind(mainMod .. " + period", hl.dsp.exec_cmd("playerctl next"), { description = "Next track" })
bind(mainMod .. " + slash", hl.dsp.exec_cmd("playerctl play-pause"), { description = "Play / pause" })

-- Clipboard and capture
bind(mainMod .. " + V", hl.dsp.exec_cmd("~/.local/bin/cliphist-rofi-img"), { description = "Clipboard history" })
bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("cliphist wipe"), { description = "Clear clipboard history" })
bind(
	mainMod .. " + SHIFT + S",
	hl.dsp.exec_cmd("hyprshot -m region --freeze --clipboard-only"),
	{ description = "Screenshot region to clipboard" }
)
bind(mainMod .. " + R", hl.dsp.exec_cmd("~/.local/bin/record"), { description = "Screen recorder (start/stop)" })
