---@diagnostic disable-next-line: undefined-global
local hl = hl

hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")

	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("dunst")

	hl.exec_cmd("gsettings set org.gnome.desktop.interface font-name 'JetBrainsMono Nerd Font 10'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface document-font-name 'JetBrainsMono Nerd Font 10'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font Mono 10'")

	hl.exec_cmd("brightnessctl --device='platform::kbd_backlight' set 2")
end)
