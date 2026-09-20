vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }

vim.opt.winborder = "rounded"
vim.opt.conceallevel = 1 -- markdown conceal
vim.opt.concealcursor = ""
vim.opt.showmode = false -- Don't show mode since we have a statusline
vim.opt.ruler = true -- Disable extra numbering
vim.opt.laststatus = 3 -- have a global statusline at the bottom instead of one for each window

-- Better editing experience
vim.opt.expandtab = true -- Turn tab into spaces
vim.opt.tabstop = 4 -- Tabs counts as 4 spaces
vim.opt.softtabstop = -1 -- If negative, shiftwidth value is used
vim.opt.shiftwidth = 4 -- 	Number of columns that make up one level of (auto)indentation
vim.opt.showmatch = true -- Show matching brackets.
vim.opt.ignorecase = true -- Do case insensitive matching
vim.opt.smartcase = true -- Do smart case matching
vim.opt.hlsearch = true
vim.opt.incsearch = true -- Incremental search
vim.opt.cindent = true -- C like indent
vim.opt.autoindent = false -- Indent with indent from last line value
vim.opt.smarttab = false -- Indent by shiftwidth value
vim.opt.textwidth = 90
vim.opt.autoread = true -- Automatically read file changed from outside
vim.opt.autowrite = false -- Automatically save before commands like :next and :make
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.selection = "inclusive" -- include last char in selection

-- backups
vim.opt.hidden = true -- Hide buffers when they are abandoned
vim.opt.modifiable = true -- Allow editing buffers
vim.opt.swapfile = false -- Do not use swap files
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Better editor UI
vim.opt.numberwidth = 5
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both" -- to enable cursorline!
vim.opt.clipboard = "unnamedplus" -- System clipboard integration
vim.opt.title = true
vim.opt.encoding = "utf-8"
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.spell = false -- do not spell check by default
vim.opt.linebreak = false -- wrap lines at preferred break points

-- Smooth scrolling
vim.opt.ttyfast = true
vim.opt.smoothscroll = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.history = 50 -- Remember 5,0 items in commandline history
vim.opt.jumpoptions = "view" -- Preserve view while jumping
vim.opt.mouse = "a" -- Enable mouse usage (all modes)
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500

vim.opt.spelllang = "es"

-- folding for treesitter
vim.opt.foldmethod = "expr" -- use expression based folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter folding
vim.opt.foldlevel = 99 -- start with all folds open

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.path:append("**")
vim.opt.diffopt:append("linematch:60")

vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 20 -- Set the width of the "drawer"
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_list_hide = "(^|ss)\zs.S+"
vim.g.netrw_banner = 0 -- Hide the Netrw banner on top
