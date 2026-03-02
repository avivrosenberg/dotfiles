require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- Disable arrow keys in normal mode
map("n", "<Down>", "<NOP>")
map("n", "<Up>", "<NOP>")
map("n", "<Left>", "<NOP>")
map("n", "<Right>", "<NOP>")

-- Insert mode navigation/deletion
map("i", "<C-l>", "<Del>", { desc = "Delete forward" })
map("i", "<C-h>", "<BS>", { desc = "Backspace" })
map("i", "<C-b>", "<Left>", { desc = "Move left" })
map("i", "<C-f>", "<Right>", { desc = "Move right" })
