augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Format on save (ONLY real file buffers, ONLY when efm is attached)
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	pattern = {
		"*.lua",
		"*.py",
		"*.go",
		"*.js",
		"*.jsx",
		"*.ts",
		"*.nix",
		"*.tsx",
		"*.json",
		"*.css",
		"*.scss",
		"*.html",
		"*.astro",
		"*.toml",
		"*.sh",
		"*.bash",
		"*.zsh",
		"*.c",
		"*.cpp",
		"*.h",
		"*.hpp",
	},
	callback = function(args)
		-- avoid formatting non-file buffers (helps prevent weird write prompts)
		if vim.bo[args.buf].buftype ~= "" then
			return
		end
		if not vim.bo[args.buf].modifiable then
			return
		end
		if vim.api.nvim_buf_get_name(args.buf) == "" then
			return
		end

		local has_efm = false
		for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
			if c.name == "efm" then
				has_efm = true
				break
			end
		end
		if not has_efm then
			return
		end

		pcall(vim.lsp.buf.format, {
			bufnr = args.buf,
			timeout_ms = 2000,
			filter = function(c)
				return c.name == "efm"
			end,
		})
	end,
})

-- disable automatic comment on newline
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	group = augroup,
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	group = augroup,
	callback = function()
		vim.hl.on_yank({ timeout = 300 })
	end,
})

-- return to last cursor position when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Return to last cursor position when opening a file",
	callback = function()
		if vim.o.diff then
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- line, col
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "gitcommit", "text", "typst" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})

-- Set the 'filetype' when reading Xresources or Xdefaults files and
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = augroup,
	pattern = { "Xresources", "Xdefaults", "xdresources", "xdefaults" },
	callback = function()
		vim.bo.filetype = "xdefaults"
	end,
})

-- Run 'xrdb' after writing changes to Xresources or Xdefaults files
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	pattern = { "Xresources", "Xdefaults", "xdresources", "xdefaults" },
	callback = function()
		vim.fn.system("!xrdb " .. vim.fn.expand("%"))
	end,
})

-- close unused buffers
local id = vim.api.nvim_create_augroup("startup", {
	clear = false,
})

local persistbuffer = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	vim.fn.setbufvar(bufnr, "bufpersist", 1)
end

vim.api.nvim_create_autocmd({ "BufRead" }, {
	group = id,
	pattern = { "*" },
	callback = function()
		vim.api.nvim_create_autocmd({ "InsertEnter", "BufModifiedSet" }, {
			buffer = 0,
			once = true,
			callback = function()
				persistbuffer()
			end,
		})
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	group = augroup,
	desc = "Cargar obsidian.nvim si estamos dentro de un vault de Obsidian",
	callback = function()
		local vault_root = vim.fs.root(0, ".obsidian")

		if not vault_root then
			return
		end

		-- Evita configurar el plugin más de una vez
		if vim.g.obsidian_loaded then
			return
		end

		vim.g.obsidian_loaded = true

		require("obsidian").setup({
			workspaces = {
				{
					name = "Notas",
					path = "~/.local/share/Obsidian/Notas/",
				},
			},

			daily_notes = {
				folder = "Diarias",
				date_format = "%d-%m-%Y",
				alias_format = "%B %-d, %Y",
				default_tags = { "daily-notes" },
			},
		})

		vim.keymap.set("n", "<Leader>nd", "<CMD>ObsidianToday<CR>", { desc = "Crea una nueva nota diaria" })
	end,
})

-- vim.keymap.set("n", "<Leader>b", function()
-- 	local curbufnr = vim.api.nvim_get_current_buf()
-- 	local buflist = vim.api.nvim_list_bufs()
-- 	for _, bufnr in ipairs(buflist) do
-- 		if vim.bo[bufnr].buflisted and bufnr ~= curbufnr and (vim.fn.getbufvar(bufnr, "bufpersist") ~= 1) then
-- 			vim.cmd("bd " .. tostring(bufnr))
-- 		end
-- 	end
-- end, { silent = true, desc = "Close unused buffers" })
