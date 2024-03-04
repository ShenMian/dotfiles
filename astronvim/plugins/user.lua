return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax

  -- vscode colorscheme
  "Mofiqul/vscode.nvim",

  -- Reopen files at last edit position
  "farmergreg/vim-lastplace",

  -- Motion
  {
    "ggandor/leap.nvim",
    config = function() require("leap").add_default_mappings() end,
    lazy = false,
  },

  -- Multiple cursors
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },

  -- Auto resize focused window
  {
    "beauwilliams/focus.nvim",
    event = "VeryLazy",
    config = function() require("focus").setup() end,
  },

  -- AI code completion
  "Exafunction/codeium.vim",

  -- Remote pair programming
  "jbyuki/instant.nvim",

  -- Tmux integration (navigator)
  "christoomey/vim-tmux-navigator",

  -- Markdown links
  "jghauser/follow-md-links.nvim",

  -- Markdown real-time preview
  -- "iamcco/markdown-preview.nvim",
  -- {
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  -- },

  -- {
  --   "echasnovski/mini.nvim",
  --   event = "VeryLazy",
  --   config = function() require("mini.move").setup() end,
  -- },

  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
}
