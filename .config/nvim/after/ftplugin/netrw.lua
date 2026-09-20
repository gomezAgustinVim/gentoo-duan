-- Mark files with v
vim.keymap.set("n", "v", "mf", { remap = true, buffer = true })
vim.keymap.set("n", "L", "<CR><CMD>Lexplore<CR>", { remap = true, buffer = true })
-- Open file/directory with double Vim direction key
vim.keymap.set("n", "ll", "<Plug>NetrwLocalBrowseCheck", { noremap = true, buffer = true })
vim.keymap.set("n", "hh", "<Plug>NetrwBrowseUpDir", { noremap = true, buffer = true })
