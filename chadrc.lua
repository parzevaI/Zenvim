---@type ChadrcConfig
local M = {}
local g = vim.g
local opt = vim.opt

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "chocolate",
  theme_toggle = { "chocolate", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  nvdash = {
    load_on_startup = true,
  },

  cmp = {
    style = "atom_colored",
  },

  statusline ={
    theme = "minimal",
  },
}


opt.scrolloff = 6

-- -- meddling
-- M.luasnip = function(opts)
--   require("luasnip").config.set_config(opts)
--
--   -- vscode format
--   require("luasnip.loaders.from_vscode").lazy_load()
--   require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }
--
--   -- snipmate format
--   require("luasnip.loaders.from_snipmate").load()
--   require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }
--
--   -- lua format
--   require("luasnip.loaders.from_lua").load()
--   require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }
--
--   -- extend filetypes
--   require("luasnip").filetype_extend("svelte", { "javascript", "html", "css" })
--
--   vim.api.nvim_create_autocmd("InsertLeave", {
--     callback = function()
--       if
--         require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
--         and not require("luasnip").session.jump_active
--       then
--         require("luasnip").unlink_current()
--       end
--     end,
--   })
-- end
-- -- meddling




g.mapleader = ";"

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
