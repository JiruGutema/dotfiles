local utils = require("utils.general")
local system_type = utils.system_type()

local has_fastfetch
local fastfetch_cache = nil

local function fetch_stats()
	if fastfetch_cache then
		return fastfetch_cache
	end

	if has_fastfetch == false then
		return nil
	end

	if has_fastfetch == nil then
		has_fastfetch = utils.term_cmd("command -v fastfetch") ~= ""
	end

	if not has_fastfetch then
		return nil
	end

	local json_output =
		utils.term_cmd([[fastfetch -s CPUUsage:Memory:Swap:Disk:Uptime:Battery:Processes:LocalIP --format json]])

	if json_output == "" then
		return nil
	end

	local ok, data = pcall(vim.json.decode, json_output)
	if not ok or not data then
		return nil
	end

	local stats = {}
	for _, item in ipairs(data) do
		if item.type == "CPUUsage" and item.result then
			local sum = 0
			for _, val in ipairs(item.result) do
				sum = sum + val
			end
			stats.cpu_load = math.floor((sum / #item.result) + 0.5)
		elseif item.type == "Memory" and item.result then
			stats.ram_total = item.result.total
			stats.ram_used = item.result.used
		elseif item.type == "Swap" and item.result and item.result[1] then
			stats.swap_total = item.result[1].total
			stats.swap_used = item.result[1].used
		elseif item.type == "Disk" and item.result and item.result[1] then
			stats.disk_total = item.result[1].bytes.total
			stats.disk_used = item.result[1].bytes.used
		elseif item.type == "Battery" and item.result and item.result[1] then
			stats.battery_capacity = item.result[1].capacity
			stats.battery_status = item.result[1].status
		elseif item.type == "Processes" and item.result then
			stats.processes = tostring(item.result)
		elseif item.type == "LocalIp" and item.result and item.result[1] then
			stats.local_ip = item.result[1].ipv4
		end
	end

	fastfetch_cache = stats
	return stats
end

local function gen_graph(percent, width)
	percent = tonumber(percent)
	if not percent or percent ~= percent then
		percent = 0
	end
	if percent < 0 then
		percent = 0
	elseif percent > 100 then
		percent = 100
	end
	width = width or 20

	local filled = math.floor((percent / 100) * width + 0.5)
	if filled > width then
		filled = width
	end

	-- Block elements render single-width in every monospace/terminal font,
	-- so the bar is always exactly `width` columns wide.
	return string.rep("█", filled) .. string.rep("░", width - filled)
end

local function wsl_version()
	if system_type == "wsl" then
		return "󰖳 WSL "
			.. utils.term_cmd(
				"wsl.exe -v 2>&1 | iconv -f UTF-16LE -t UTF-8 | grep 'WSL version' | cut -d ':' -f2 | xargs"
			)
			.. " | "
	end
	return ""
end

local function os_version()
	local uname = system_type
	if uname ~= "darwin" then
		local linux_name = utils.term_cmd("lsb_release -is"):lower()
		if linux_name == "" then
			linux_name = utils.term_cmd("cat /etc/os-release | grep '^ID=' | cut -d '=' -f2"):lower()
		end

		local os_pretty_name = utils.term_cmd("lsb_release -ds")
		if os_pretty_name == "" then
			os_pretty_name = utils.term_cmd("cat /etc/os-release | grep '^PRETTY_NAME=' | cut -d '\"' -f2")
		end

		local icon = "" -- default Linux icon
		if linux_name:find("ubuntu") then
			icon = ""
		elseif linux_name:find("debian") then
			icon = ""
		elseif linux_name:find("arch") then
			icon = "󰣇"
		end

		return icon .. " " .. (os_pretty_name ~= "" and os_pretty_name or "linux")
	else
		local name = utils.term_cmd("sw_vers -productName")
		local version = utils.term_cmd("sw_vers -productVersion")
		return " " .. name .. " " .. version
	end
end

-- NEOVIM VERSION
local function vim_version()
	return " " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
end

-- NEOVIDE VERSION
local function neovide_version()
	if vim.g.neovide then
		return " |  " .. vim.g.neovide_version
	end
	return ""
end

local ff_stats = fetch_stats()

local cpu_load = 0
if ff_stats and ff_stats.cpu_load then
	cpu_load = ff_stats.cpu_load
else
	cpu_load = tonumber((utils.term_cmd("uptime"):match("load averages?:%s*([%d%.]+)"))) or 0
end

local function ram()
	if ff_stats and ff_stats.ram_total and ff_stats.ram_used then
		local ff_total_gb = tonumber(ff_stats.ram_total) / 1024 ^ 3
		local ff_used_gb = tonumber(ff_stats.ram_used) / 1024 ^ 3
		return math.floor(ff_used_gb * 10) / 10, math.floor(ff_total_gb * 10) / 10
	end

	if system_type ~= "darwin" then
		local memory_output = utils.term_cmd("free -m | awk '/Mem:/ {print $3, $2}'")
		local used_mb, total_mb = memory_output:match("(%d+)%s+(%d+)")
		return tonumber(used_mb), tonumber(total_mb)
	end
	local vm_stat = utils.term_cmd("vm_stat")
	local page_size = 4096
	local active_pages = tonumber(vm_stat:match("Pages active:%s*(%d+)")) or 0
	local inactive_pages = tonumber(vm_stat:match("Pages inactive:%s*(%d+)")) or 0
	local wired_pages = tonumber(vm_stat:match("Pages wired down:%s*(%d+)")) or 0
	local memsize_str = utils.term_cmd("sysctl -n hw.memsize"):gsub("[^%d]", "")
	local total_bytes = tonumber(memsize_str) or (8 * 1024 ^ 3)
	local used_bytes = (active_pages + inactive_pages + wired_pages) * page_size
	local used_gb = used_bytes / 1024 ^ 3
	local total_gb = total_bytes / 1024 ^ 3
	return math.floor(used_gb), math.floor(total_gb)
end

local function swap()
	if ff_stats and ff_stats.swap_total and ff_stats.swap_used then
		local total_gb = tonumber(ff_stats.swap_total) / 1000 ^ 3
		local used_gb = tonumber(ff_stats.swap_used) / 1000 ^ 3
		return math.floor(used_gb * 10) / 10, math.floor(total_gb * 10) / 10
	end

	if system_type ~= "darwin" then
		local memory_output = utils.term_cmd("free -m | awk '/Swap:/ {print $3, $2}'")
		local used_mb, total_mb = memory_output:match("(%d+)%s+(%d+)")
		return tonumber(used_mb), tonumber(total_mb)
	end
	local swap_output = utils.term_cmd("sysctl vm.swapusage")
	local total = tonumber(swap_output:match("total = ([%d%.]+)M"))
	local used = tonumber(swap_output:match("used = ([%d%.]+)M"))
	return math.floor(used), math.floor(total)
end

local function disk()
	if ff_stats and ff_stats.disk_used and ff_stats.disk_total then
		local used_gb = tonumber(ff_stats.disk_used) / 1000 ^ 3
		local total_gb = tonumber(ff_stats.disk_total) / 1000 ^ 3
		return math.floor(used_gb + 0.5), math.floor(total_gb + 0.5)
	end

	local uname = system_type
	local flag = "-H"
	if uname ~= "darwin" then
		flag = "-h"
	end
	local mount_path = utils.in_yadm_env(function()
		return utils.term_cmd("git config local.class")
	end) == "42" and "~" or "/"
	if uname == "wsl" then
		mount_path = "/mnt/c"
	elseif uname == "darwin" then
		mount_path = "/System/Volumes/Data"
	end
	local used, total = utils
		.term_cmd("df " .. flag .. " " .. mount_path .. " | awk 'NR==2 {print $3, $2}'")
		:match("([%d%.]+)[GMKTB]?%s+([%d%.]+)[GMKTB]?")
	return math.floor(tonumber(used or 0) + 0.5), math.floor(tonumber(total or 1) + 0.5)
end

local function battery_capacity()
	if ff_stats and ff_stats.battery_capacity then
		return math.floor(ff_stats.battery_capacity + 0.5)
	end

	local output = utils.term_cmd([[
		for d in /sys/class/power_supply/*; do
			case "$d" in */BAT*|*/CMD*|*/battery*)
				[ -f "$d/capacity" ] && cat "$d/capacity" && exit
			esac
		done
		pmset -g batt | grep -Eo '\d+%' | head -1 | tr -d '%'
	]])
	return tonumber(output and output:match("%d+")) or 0
end

local function battery_status()
	if ff_stats and ff_stats.battery_status then
		-- fastfetch reports status as a string ("AC Connected") on newer
		-- versions and as an array of strings on older ones; handle both.
		local statuses = ff_stats.battery_status
		if type(statuses) == "string" then
			statuses = { statuses }
		end
		for _, s in ipairs(statuses) do
			if s == "Charging" or s == "AC Connected" then
				return true
			end
		end
		return false
	end
	if system_type ~= "darwin" then
		local status = utils.term_cmd([[
      (for d in /sys/class/power_supply/*; do
        case "$d" in */BAT*|*/CMD*|*/battery*)
          [ -f "$d/status" ] && cat "$d/status" && break
        esac
      done) || pmset -g batt | grep 'AC Power'
    ]])

		if not status then
			return false
		end
		return status and status:match("Charging") or status:match("AC Power") or false
	else
		local status = utils.term_cmd("pmset -g batt")
		if not status then
			return false
		end

		return status and status:match(" charging") or status:match("AC Power") or false
	end
end

local function battery_icon(capacity, battery_stat)
	if battery_stat then
		return "󰂄"
	end

	local index = math.floor(capacity / 10) + 1
	local capacity_icons = {
		"󰂎",
		"󰁺",
		"󰁻",
		"󰁼",
		"󰁽",
		"󰁾",
		"󰁿",
		"󰂀",
		"󰂁",
		"󰂂",
		"󰁹",
	}
	if index > #capacity_icons then
		index = #capacity_icons
	end
	return capacity_icons[index]
end

local function processes()
	if ff_stats and ff_stats.processes then
		return ff_stats.processes
	end

	if system_type ~= "darwin" then
		return utils.term_cmd("ps -e --no-headers | wc -l")
	end
	return utils.term_cmd("ps ax | wc -l | awk '{print $1}'")
end

local function local_ip_address()
	if ff_stats and ff_stats.local_ip then
		return ff_stats.local_ip:match("([^/]+)")
	end

	if system_type ~= "darwin" then
		return utils.term_cmd("hostname -I | awk '{print $1}'")
	end
	local ip = utils.term_cmd("ipconfig getifaddr en0")
	if ip == "" then
		ip = utils.term_cmd("ipconfig getifaddr en1")
	end
	return ip ~= "" and ip or "N/A"
end

local function public_ip_address()
	if ff_stats and ff_stats.public_ip then
		return ff_stats.public_ip
	end

	return utils.term_cmd("curl -s4 ifconfig.me")
end

-- RAM/SWAP/DISK
local ram_used, ram_total = ram()
local ram_percent = ram_used / ram_total * 100
local swap_used, swap_total = swap()
local swap_percent = swap_used / swap_total * 100
local disk_used, disk_total = disk()
local disk_percent = disk_used / disk_total * 100

-- Box interior: 8-col label column + 1-col divider + 41-col body column.
local BODY_WIDTH = 41

-- Display width in terminal columns. Nerd-font glyphs and block elements render
-- single-width, so counting UTF-8 codepoints (every byte that is not a 0x80-0xBF
-- continuation byte) matches what the terminal draws. LuaJIT lacks the `utf8`
-- stdlib, so the codepoints are counted by hand.
local function disp_width(str)
	local count = 0
	for i = 1, #str do
		local byte = string.byte(str, i)
		if byte < 0x80 or byte >= 0xC0 then
			count = count + 1
		end
	end
	return count
end

-- Pad a body string with trailing spaces to the exact interior width so the
-- right border always lands in the same column.
local function pad_body(body)
	local width = disp_width(body)
	if width >= BODY_WIDTH then
		return body
	end
	return body .. string.rep(" ", BODY_WIDTH - width)
end

-- One labelled row: 8-col label cell, divider, then the padded body.
local function box_row(label, body)
	return "│" .. string.format(" %-7s", label) .. "│" .. pad_body(body) .. "│"
end

-- A stat row with a value and its bar gauge.
local function gauge_row(label, value, percent)
	return box_row(label, string.format(" %-16s %s ", value, gen_graph(percent)))
end

-- Users / processes / local IP: count on the left, IP pinned to the right.
local user_count = utils.term_cmd("users | tr ' ' '\\n' | sort -u | wc -l | tr -d ' '")
local class = utils.in_yadm_env(function()
	return utils.term_cmd("git config local.class")
end)
local info_left = " " .. user_count .. (class ~= "" and ("  " .. class) or "") .. "    " .. processes()
local info_right = "󰩠 " .. local_ip_address() .. " "
local info_gap = math.max(1, BODY_WIDTH - disp_width(info_left) - disp_width(info_right))
local info_body = info_left .. string.rep(" ", info_gap) .. info_right

local system_info = {
	"╭────────┬─────────────────────────────────────────╮",
	gauge_row("CPU", cpu_load .. "%", cpu_load),
	gauge_row("RAM", ram_used .. "/" .. ram_total .. "GB", ram_percent),
	gauge_row("SWAP", swap_used .. "/" .. swap_total .. "GB", swap_percent),
	gauge_row("DISK", disk_used .. "/" .. disk_total .. "GB", disk_percent),
	"╰────────┴─────────────────────────────────────────╯",
}

local header = vim.g.neovide
		and [[
  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗██████╗ ███████╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║██╔══██╗██╔════╝
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██║  ██║█████╗
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║  ██║██╔══╝
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██████╔╝███████╗
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═════╝ ╚══════╝]]
	or [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]

return {
	header = header
		.. "\n\n"
		.. wsl_version()
		.. os_version()
		.. " | "
		.. vim_version()
		.. neovide_version()
		.. "\n"
		.. table.concat(system_info, "\n")
		.. "\n"
		.. os.date(),

	system_info = system_info,
}
