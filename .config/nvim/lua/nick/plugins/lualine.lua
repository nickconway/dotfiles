return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local colors = require("onedark.colors")
		local transparent = require("lualine.themes.onedark")

		transparent.normal.a.bg = "none"
		transparent.normal.a.fg = colors.grey
		transparent.normal.b.bg = "none"
		transparent.normal.b.fg = colors.grey
		transparent.normal.c.bg = "none"
		transparent.normal.c.fg = colors.grey
		transparent.inactive.c.bg = "none"

		local lualine_sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {},
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		}

		local winbar_sections = {
			lualine_c = {
				"filename",
				"navic",
				color_correction = nil,
				navic_opts = nil,
			},
		}

		require("lualine").setup({
			options = {
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
				theme = transparent,
				section_separators = { left = "|", right = "|" },
				component_separators = { left = "|", right = "|" },
				padding = 1,
				globalstatus = true,
				icons_enabled = true,
			},
			sections = lualine_sections,
			inactive_sections = lualine_sections,
			winbar = winbar_sections,
			inactive_winbar = winbar_sections,
		})
	end,
}
