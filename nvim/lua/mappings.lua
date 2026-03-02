require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "<C-h>", "<BS>", { desc = "Backspace" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
