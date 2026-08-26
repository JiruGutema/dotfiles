return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			sources = {
				explorer = {
					layout = {
						auto_hide = { "input" },
					},
				},
			},
		},
		dashboard = {
			enabled = true,
			sections = {
				function()
					return {
						padding = 2,
						header = require("modules.dashboard").header,
					}
				end,
			},
		},
	},
}
