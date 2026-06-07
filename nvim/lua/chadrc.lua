-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

-- ── Appearance-aware theme selection ─────────────────────────────────
-- Configure your preferred light and dark base46 theme names here.
local themes = {
    dark  = "gruvbox",
    light = "gruvbox_light",
}

-- Detect macOS system appearance.
-- `defaults read -g AppleInterfaceStyle` prints "Dark" in dark mode and
-- exits non-zero (with no output) in light mode.
local function macos_appearance()
    local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
    if handle then
        local result = handle:read("*a")
        handle:close()
        if result:match("Dark") then
            return "dark"
        end
    end
    return "light"
end

local appearance = macos_appearance()
-- ─────────────────────────────────────────────────────────────────────

M.base46 = {
    theme = themes[appearance],

    -- hl_override = {
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
    -- },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

return M
