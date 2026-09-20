vim.keymap.set("n", "<leader>p", ":ExportPdf<CR>", { buffer = 0 })

vim.cmd([[
    setlocal formatoptions+=t
	setlocal wrap
	"setlocal wrapmargin=0
	setlocal spell
	setlocal linebreak
]])
