local configs = require "custom.plugins.configs"

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,

M.ui = {
  theme = "gruvchad",
  theme_toggle = { "gruvchad", "gruvbox_light" },
  transparency = true,
}

M.plugins = {
  override = {
    ["NvChad/ui"] = configs.ui,
    ["williamboman/mason.nvim"] = configs.masom,
    ["kyazdani42/nvim-tree.lua"] = configs.nvimtree,
  },

  user = {
    ["neovim/nvim-lspconfig"] = {
      config = function()
        require "plugins.configs.lspconfig"
        require "custom.plugins.lspconfig"
      end,
    },
    ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
        require "custom.plugins.null-ls"
      end,
    },
    ["goolord/alpha-nvim"] = {
      disable = false,
    },
    ["folke/which-key.nvim"] = {
      disable = false,
    },
  },
}

return M
