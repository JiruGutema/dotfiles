-- DMS user keybind overrides (edit via Control Center or dms; do not remove this header)

hl.unbind("SUPER + C")
hl.bind("SUPER + C", hl.dsp.exec_cmd("dms ipc call control-center toggle"), { description = "Control Center" })
hl.unbind("SUPER + SHIFT + space")
hl.bind("SUPER + SHIFT + space", hl.dsp.exec_cmd("dms ipc call bar toggle"), { description = "Toggle bar" })
hl.unbind("SUPER + comma")
hl.bind(
	"SUPER + comma",
	hl.dsp.exec_cmd("dms ipc call notifications dismiss"),
	{ description = "Dismiss notification" }
)
hl.unbind("CTRL + ALT + H")
hl.bind(
	"CTRL + ALT + H",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/ws-step.sh -1"),
	{ description = "Previous workspace" }
)
hl.unbind("CTRL + ALT + L")
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("~/.config/hypr/scripts/ws-step.sh +1 "), { description = "Next workspace" })
hl.unbind("CTRL + ALT + N")
hl.bind("CTRL + ALT + N", hl.dsp.focus({ workspace = "emptyn" }))
hl.unbind("SUPER + 0")
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = "10" }))
hl.unbind("SUPER + S")
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("scratchpad"))
hl.unbind("SUPER + SHIFT + 0")
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))
hl.unbind("SUPER + SHIFT + S")
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))
hl.unbind("SUPER + SHIFT + TAB")
hl.bind("SUPER + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))
hl.unbind("SUPER + TAB")
hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "e+1" }))
hl.unbind("SUPER + ALT + J")
hl.bind("SUPER + ALT + J", hl.dsp.focus({ direction = "d" }), { description = "Focus down" })
hl.unbind("CTRL + RETURN")
hl.bind("CTRL + RETURN", hl.dsp.exec_cmd("kitty"), { description = "Terminal" })
hl.unbind("SUPER + E")
hl.bind("SUPER + E", hl.dsp.exec_cmd("nautilus"), { description = "File manager" })
hl.unbind("SUPER + Print")
hl.bind("SUPER + Print", hl.dsp.exec_cmd("hyprpicker -a"), { description = "Color picker" })
hl.unbind("SUPER + RETURN")
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"), { description = "Terminal" })
hl.unbind("SUPER + SHIFT + N")
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("kitty -e nvim"), { description = "Code Editor" })
hl.unbind("SUPER + SHIFT + R")
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"), { description = "Reload Hyprland" })
hl.unbind("SUPER + SHIFT + RETURN")
hl.bind("SUPER + SHIFT + RETURN", hl.dsp.exec_cmd("firefox"), { description = "Browser" })
hl.unbind("SUPER + SHIFT + T")
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("kitty -e btop"), { description = "System monitor" })
hl.unbind("SUPER + ALT + F")
hl.bind(
	"SUPER + ALT + F",
	hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
	{ description = "Fullscreen" }
)
hl.unbind("SUPER + G")
hl.bind("SUPER + G", hl.dsp.group.toggle())
hl.unbind("SUPER + J")
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"), { description = "Toggle split" })
hl.unbind("SUPER + P")
hl.bind("SUPER + P", hl.dsp.window.pseudo({ action = "toggle" }))
hl.unbind("SUPER + T")
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(
	"SUPER + SHIFT + L",
	hl.dsp.exec_cmd("hyprlock -c ~/.config/hypr/hyprlock.conf"),
	{ description = "Lock screen" }
)
