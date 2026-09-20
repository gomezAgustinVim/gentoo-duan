vim.opt.termguicolors = true
vim.cmd.colorscheme("habamax")

-- move config and plugin config to alternate files
require("config.keymaps")
require("config.options")
require("config.autocmds")
require("config.statusline")

local function set_transparent() -- set UI component to transparent
	local groups = {
		"Normal",
		"NormalNC",
		"EndOfBuffer",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		"StatusLine",
		"StatusLineNC",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
		"ColorColumn",
	}
	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = "none" })
	end
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end

set_transparent()

-- plugins

vim.pack.add({
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	}, -- improved syntax
	"https://github.com/mason-org/mason.nvim", -- look for lsps and formatters in one place
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/creativenull/efmls-configs-nvim", -- linter and formatter
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	}, -- better completion
	"https://github.com/L3MON4D3/LuaSnip", -- more conventional snippets engine
	"https://github.com/prichrd/netrw.nvim", -- netrw icons
	"https://github.com/echasnovski/mini.nvim",
	"https://github.com/epwalsh/obsidian.nvim",
	"https://github.com/ibhagwan/fzf-lua", -- manage files, buffers, git and grepper
	"https://github.com/neovim/nvim-lspconfig",
})

local function packadd(name)
	vim.cmd("packadd " .. name)
end
-- dependencies
packadd("plenary.nvim")
-- other
packadd("nvim-treesitter")
packadd("gitsigns.nvim")
packadd("mini.nvim")
packadd("netrw.nvim")
packadd("render-markdown.nvim")
packadd("obsidian.nvim")
packadd("fzf-lua")
packadd("which-key.nvim")
-- LSP
packadd("nvim-lspconfig")
packadd("mason.nvim")
packadd("mason-lspconfig.nvim")
packadd("efmls-configs-nvim")
packadd("blink.cmp")
packadd("LuaSnip")

require("plugins.lsp")
require("plugins.luasnip")
require("plugins.blink")
require("plugins.treesitter")

require("netrw").setup({})

require("render-markdown").setup({})

require("which-key").setup({
	{ "zg", desc = "Añadir palabra a diccionario" },
	{ "zG", desc = "Añadir palabra a diccionario interno" },
	{ "zw", desc = "Marcar palabra como malonga nwn" },
	{ "z=", desc = "Ver sugerencia de palabras" },
})

require("gitsigns").setup({
	signs = {
		add = { text = "\u{2590}" }, -- ▏
		change = { text = "\u{2590}" }, -- ▐
		delete = { text = "\u{2590}" }, -- ◦
		topdelete = { text = "\u{25e6}" }, -- ◦
		changedelete = { text = "\u{25cf}" }, -- ●
		untracked = { text = "\u{25cb}" }, -- ○
	},
	signcolumn = true,
	current_line_blame = false,
})

-- Gitsigns mappings
vim.keymap.set("n", "]h", function()
	require("gitsigns").next_hunk()
end, { desc = "Next git hunk" })
vim.keymap.set("n", "[h", function()
	require("gitsigns").prev_hunk()
end, { desc = "Previous git hunk" })
vim.keymap.set("n", "<leader>hs", function()
	require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", function()
	require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>hp", function()
	require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hb", function()
	require("gitsigns").blame_line({ full = true })
end, { desc = "Blame line" })
vim.keymap.set("n", "<leader>hB", function()
	require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle inline blame" })
vim.keymap.set("n", "<leader>hd", function()
	require("gitsigns").diffthis()
end, { desc = "Diff this" })

require("fzf-lua").setup({})
vim.keymap.set("n", "<leader>ff", ":FzfLua files<CR>", { desc = "Abrir fzf-lua para archivos" })
vim.keymap.set("n", "<leader>fb", ":FzfLua buffers<CR>", { desc = "Abrir fzf-lua para buffers" })
vim.keymap.set("n", "<leader>fl", ":FzfLua live_grep<CR>", { desc = "Abrir fzf-lua para live grep" })
vim.keymap.set("n", "<leader>fh", ":FzfLua helptags<CR>", { desc = "Abrir fzf-lua para helptags" })
vim.keymap.set(
	"n",
	"<leader>fx",
	":FzfLua diagnostics_document<CR>",
	{ desc = "Abrir fzf-lua para diagnostics document" }
)
vim.keymap.set(
	"n",
	"<leader>fX",
	":FzfLua diagnostics_workspace<CR>",
	{ desc = "Abrir fzf-lua para diagnostics workspace" }
)
vim.keymap.set("n", "<leader>fg", ":FzfLua git_status<CR>", { desc = "Abrir fzf-lua para git status" })

require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.cursorword").setup({})
require("mini.indentscope").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
require("mini.notify").setup({})
require("mini.icons").setup({})

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"ts_ls",
		"bashls",
		"tinymist",
		"markdown_oxide",
	},
})

-- configure linters and formatters
do
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

	local prettier_d = require("efmls-configs.formatters.prettier_d")
	local eslint_d = require("efmls-configs.linters.eslint_d")

	local fixjson = require("efmls-configs.formatters.fixjson")

	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")

	local nixfmt = require("efmls-configs.formatters.nixfmt")
	local clangfmt = require("efmls-configs.formatters.clang_format")

	local taplo = require("efmls-configs.formatters.taplo")

	vim.lsp.config("efm", {
		filetypes = {
			"css",
			"html",
			"prisma",
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"lua",
			"toml",
			"astro",
			"c",
			"markdown",
			"nix",
			"sh",
			"typescript",
			"typescriptreact",
		},
		init_options = { documentFormatting = true },
		settings = {
			languages = {
				css = { prettier_d },
				html = { prettier_d },
				markdown = { prettier_d },
				astro = { prettier_d },
				javascript = { eslint_d, prettier_d },
				javascriptreact = { eslint_d, prettier_d },
				json = { eslint_d, fixjson },
				jsonc = { eslint_d, fixjson },
				lua = { luacheck, stylua },
				sh = { shellcheck, shfmt },
				typescript = { eslint_d, prettier_d },
				typescriptreact = { eslint_d, prettier_d },
				nix = { nixfmt },
				c = { clangfmt },
				toml = { taplo },
			},
		},
	})
end
