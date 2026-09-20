local map = vim.keymap.set

--Remap space as leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- better movement in wrapped text
map("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap aware)" })

-- better movement in wrapped text
map("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap aware)" })

map("n", "<leader>ch", ":nohlsearch<CR>", { desc = "Limpiar search highlight", silent = true })

-- map("n", "<leader>re", ":update<CR> :source<CR>", { desc = "Recargar configuración", silent = true })
map("n", "<leader>re", ":restart<CR>", { desc = "Recargar configuración", silent = true })
map("n", "<leader>e", "<CMD>Lexplore<CR>", { desc = "Open explorer as left split in cwd" })
map("n", "<leader>fe", "<CMD>Lexplore %:p:h<CR>", { desc = "open Netrw in the directory of the current file" })

map("n", "<leader>u", function()
	vim.pack.update()
end, { desc = "Actualizar plugins" })

-- Mimic shell movements
map("i", "<C-W>", "<C-o>$")
map("i", "<C-A>", "<C-o>^")

-- God reveals himself
-- Thanks the Primeagen
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "J", "mzJ`z")

map("n", "<C-d>", "<C-d>zz", { desc = "Media pagina abajo (centrado)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Media pagina arriba (centrado)" })
map("n", "n", "nzzzv", { desc = "Siguiente termino de busqueda (centrado)" })
map("n", "N", "Nzzzv", { desc = "Anterior termino de busqueda (centrado)" })

map("n", "<leader>p", '"_dP', { desc = "Pegar texto sin yanking" })
map({ "n", "v" }, "<leader>x", '"_d', { desc = "Borrar texto sin yanking" })

-- Make file executable
map("n", "<leader>xe", "<cmd>!chmod +x %<CR>", { desc = "Hacer archivo ejecutable" })

-- Quit neovim
map("n", "<C-Q>", "<CMD>q<CR>")

-- Save neovim
map("n", "<C-s>", "<CMD>w<CR>")

-- Save and quit neovim
map("n", "<C-z>", "<CMD>x<CR>")

------------------------------------------------
-- ==>   Splits
------------------------------------------------

-- Shortcutting split navigation, saving a keypress:
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Make adjusting split sizes a bit more friendly
map("n", "<C-Left>", "<CMD>vertical resize -2<CR>")
map("n", "<C-Right>", "<CMD>vertical resize +2<CR>")
map("n", "<C-Up>", "<CMD>resize -2<CR>")
map("n", "<C-Down>", "<CMD>resize +2<CR>")

-- Close and split
map("n", "<leader>vs", ":vsplit<CR>:bnext<CR>", { desc = "Split y buffer" }) -- ver split + open next buffer
map("n", "<leader>ss", ":split<CR>:bnext<CR>", { desc = "Split horizontal y buffer" }) -- hor split + open next buffer

vim.keymap.set("n", "<Leader>b", function()
	local buflist = vim.api.nvim_list_bufs()
	for _, bufnr in ipairs(buflist) do
		local buf_name = vim.api.nvim_buf_get_name(bufnr)
		if buf_name == "" then
			vim.cmd("bd" .. tostring(bufnr))
		end
	end
end, { silent = true, desc = "Close all unnamed buffers" })

-- Change 2 split windows from vert to horiz or horiz to vert
map("n", "<Leader>th", "<C-w>t<C-w>H", { desc = "Move split window to horizontal" })
map("n", "<Leader>tk", "<C-w>t<C-w>K", { desc = "Move split window to vertical" })

-- Compile document, be it groff/LaTeX/markdown/etc.
map("n", "<leader>cp", ':w! | !compiler.sh "<c-r>%"<CR>', { desc = "Compile this file" })

-- Perform dot commands over visual blocks:
map("x", ".", ":normal .<CR>")

-- Control all select
map("n", "<C-a>", "ggVG")

map({ "n", "i" }, "<A-ñ>", "<CMD>setlocal spelllang=es<CR>", { desc = "Poner corrector en español" })
map({ "n", "i" }, "<A-i>", "<CMD>setlocal spelllang=en<CR>", { desc = "Poner corrector en inglés" })

-- Diagnostics
map("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

-- misc
map("n", "<leader>sa", ":%s//g<Left><Left>", { desc = "Reemplazar todo" }) -- replace all
map({ "n", "v" }, "<leader>cr", "1z=", { desc = "Corregir spelling" })
map({ "n", "v" }, "<leader>y", '"+y') -- copy to system clipboard
map({ "n", "v" }, "<leader>d", '"+d') -- cut to system clipboard
