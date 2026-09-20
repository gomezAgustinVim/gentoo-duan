local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	[[██████╗ ██╗   ██╗ █████╗ ███╗   ██╗████████╗██╗  ██╗███████╗██╗     ██╗███████╗███████╗]],
	[[██╔══██╗██║   ██║██╔══██╗████╗  ██║╚══██╔══╝██║  ██║██╔════╝██║     ██║██╔════╝██╔════╝]],
	[[██║  ██║██║   ██║███████║██╔██╗ ██║   ██║   ███████║█████╗  ██║     ██║█████╗  █████╗  ]],
	[[██║  ██║██║   ██║██╔══██║██║╚██╗██║   ██║   ██╔══██║██╔══╝  ██║     ██║██╔══╝  ██╔══╝  ]],
	[[██████╔╝╚██████╔╝██║  ██║██║ ╚████║   ██║   ██║  ██║███████╗███████╗██║██║     ███████╗]],
	[[╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝╚═╝     ╚══════╝]],
}

dashboard.section.buttons.val = {
	dashboard.button("n", "  Nuevo archivo", ":ene <BAR> startinsert <CR>"),
	-- dashboard.button("w", "󰯂  Vimwiki", ":VimwikiIndex <CR>"),
	dashboard.button("f", "󰍉  Buscar archivo", ":Pick files<CR>"),
	dashboard.button("e", "  Buscar en cwd", ":Oil<CR>"),
	dashboard.button("r", "  Buscar docs", ":e ~/Documentos/<CR>"),
	dashboard.button("s", "󰯂  Buscar scripts", ":e ~/.local/bin/<CR>"),
	dashboard.button("c", "  Config", ":e ~/.config/nvim/<CR>"),
	dashboard.button("m", "  Mapeos", ":e ~/.config/nvim/lua/config/keymaps.lua<CR>"),
	dashboard.button("p", "  Plugins", function()
		vim.pack.update()
	end),
	dashboard.button("q", "󰅙  Salir", ":q!<CR>"),
}

dashboard.section.footer.val = function()
	return vim.g.startup_time_ms or "Los duanes venceremos NWN... "
end

dashboard.section.buttons.opts.hl = "Keyword"
dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
