require("config.autocmds")

local diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true, -- "always"
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end

	local bufnr = ev.buf

	vim.keymap.set(
		"n",
		"<leader>lf",
		vim.lsp.buf.format,
		{ desc = "Format code", noremap = true, silent = true, buffer = bufnr }
	)

	vim.keymap.set(
		"n",
		"<leader>li",
		":checkhealth vim.lsp<CR>",
		{ desc = "LSP server info", noremap = true, silent = true, buffer = bufnr }
	)

	vim.keymap.set(
		"n",
		"<leader>ln",
		vim.lsp.buf.rename,
		{ desc = "Rename variable", noremap = true, silent = true, buffer = bufnr }
	)

	vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr })

	vim.keymap.set(
		"n",
		"<leader>lk",
		vim.lsp.buf.signature_help,
		{ desc = "Signature help", noremap = true, silent = true, buffer = bufnr }
	)

	vim.keymap.set(
		"n",
		"<leader>lD",
		vim.lsp.buf.definition,
		{ desc = "Definitions", noremap = true, silent = true, buffer = bufnr }
	)

	if client:supports_method("textDocument/codeAction", bufnr) then
		vim.keymap.set("n", "<leader>la", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
				bufnr = bufnr,
			})
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, { desc = "Code actions", noremap = true, silent = true, buffer = true })
	end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},
})

vim.lsp.config("elf", {})
vim.lsp.config("markdown_oxide", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("bashls", {})
vim.lsp.config("tinymist", {})
vim.lsp.config("clangd", {})

vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"bashls",
	"clangd",
	"tinymist",
	"markdown_oxide",
	"elf",
})
