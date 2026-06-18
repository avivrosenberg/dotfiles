require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- General keymaps
--
--

-- Disable arrow keys in normal mode
map("n", "<Down>", "<NOP>")
map("n", "<Up>", "<NOP>")
map("n", "<Left>", "<NOP>")
map("n", "<Right>", "<NOP>")

-- Insert mode navigation/deletion
--
--
map("i", "<C-l>", "<Del>", { desc = "Delete forward" })
map("i", "<C-h>", "<BS>", { desc = "Backspace" })
map("i", "<C-b>", "<Left>", { desc = "Move left" })
map("i", "<C-f>", "<Right>", { desc = "Move right" })

-- Keymaps for plugins
--
--
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })


-- Keymaps for custom functions
--
--
local function insert_project_file_path(prefix)
    local root = vim.fs.root(0, { ".git" }) or vim.uv.cwd()
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")
    local state = require("telescope.actions.state")
    local resolved_prefix = prefix or ""

    builtin.find_files({
        cwd = root,
        hidden = true,
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                local entry = state.get_selected_entry()
                actions.close(prompt_bufnr)
                local rel = entry and (entry.path or entry[1]) -- already relative to cwd/root
                if rel then vim.api.nvim_paste(resolved_prefix .. rel, true, -1) end
            end)
            return true
        end,
    })
end

-- Command to insert project file path and insert-mode mapping
vim.api.nvim_create_user_command(
    "InsertProjectFilePath",
    function(opts)
        local prefix = opts.args ~= "" and opts.args or nil
        insert_project_file_path(prefix)
    end,
    { nargs = "?" }
)
map(
    { "i" },
    "<C-R>@",
    function() insert_project_file_path("@") end,
    { desc = "Insert @project file path" }
)
