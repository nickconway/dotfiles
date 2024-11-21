vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"
vim.opt.mousemoveevent = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.inccommand = "split"

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 8
vim.opt.clipboard:append({ "unnamedplus", "unnamed" })

vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}
vim.opt.laststatus = 3

vim.opt.updatetime = 50

vim.opt.virtualedit = "block"

vim.opt.signcolumn = "yes"

vim.opt.conceallevel = 2

vim.opt.listchars:append("space:·")

vim.o.sessionoptions = "buffers,curdir,folds,globals,help,tabpages,winsize,winpos,skiprtp,terminal,localoptions"

vim.opt.smoothscroll = true

local f = io.open(os.getenv("HOME") .. "/.cache/nvim/colorscheme", "r")
if f then
    local colorscheme = f:read()
    if colorscheme:find("noctu") then
        vim.opt.termguicolors = false
    else
        vim.opt.termguicolors = true
    end
    vim.cmd.colorscheme(colorscheme)
    f:close()
else
    f = io.open(os.getenv("HOME") .. "/.cache/nvim/colorscheme", "w+")
    if f then
        local walExists = io.open(os.getenv("HOME") .. "/.cache/wal/colors", "r")
        if walExists then
            f:write("neopywal")
            vim.cmd.colorscheme("neopywal")
        else
            f:write("onedark")
            vim.cmd.colorscheme("onedark")
        end
    end
end


vim.cmd("highlight Normal ctermbg=none guibg=none")
vim.cmd("highlight NormalFloat ctermbg=none guibg=none")
vim.cmd("highlight FloatBorder ctermbg=none guibg=none")
vim.cmd("highlight SignColumn ctermbg=none guibg=none")
vim.cmd("highlight EndOfBuffer ctermbg=none guibg=none")
vim.cmd("highlight WinBar ctermbg=none guibg=none")
vim.cmd("highlight WinBarNC ctermbg=none guibg=none")
vim.cmd("highlight MiniClueBorder ctermbg=none guibg=none")
vim.cmd("highlight MiniClueDescGroup ctermbg=none guibg=none")
vim.cmd("highlight MiniClueDescSingle ctermbg=none guibg=none")
vim.cmd("highlight MiniFilesBorder ctermbg=none guibg=none")
vim.cmd("highlight MiniFilesNormal ctermbg=none guibg=none")
vim.cmd("highlight MiniFilesCursorLine ctermbg=none guibg=none")
vim.cmd("highlight LspInfoBorder ctermfg=none")
