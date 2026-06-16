require "nvchad.autocmds"

-- Configure settings for markdown files
local md = vim.api.nvim_create_augroup("md_settings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = md,
    pattern = "markdown",
    -- textwidth, wrap guide, auto-wrap if over width
    command = "setlocal textwidth=88 colorcolumn=89 formatoptions+=t",
})
