local configs = require "custom.configs"

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,

M.ui = {
  theme = "gruvchad",
  theme_toggle = { "gruvchad", "gruvbox_light" },
}

M.plugins = {
  override = {
    ["NvChad/ui"] = configs.ui,
    ["nvim-treesitter/nvim-treesitter"] = configs.treesitter,
    ["williamboman/mason.nvim"] = configs.masom,
    ["kyazdani42/nvim-tree.lua"] = configs.nvimtree,
  },

  user = require "custom.plugins",
}

return M
