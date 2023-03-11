return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },

  -- vscode colorscheme
  "Mofiqul/vscode.nvim",

  -- Reopen files at last edit position
  "farmergreg/vim-lastplace",

  -- Motion
  {
    "ggandor/leap.nvim",
    config = function() require("leap").add_default_mappings() end,
  },

  -- Multiple cursors
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },

  {
    "echasnovski/mini.nvim",
    lazy = false,
    config = function() require("mini.move").setup() end,
  },

  -- Auto resize focused window
  {
    "beauwilliams/focus.nvim",
    config = function() require("focus").setup() end,
  },

  -- AI-powered code completion
  "Exafunction/codeium.vim",

  -- "codota/tabnine-nvim",
  -- {
  --   build = "./dl_binaries.sh",
  --   config = function()
  --     require("tabnine").setup()
  --   end,
  -- },

  -- Remote pair programming
  "jbyuki/instant.nvim",

  -- Tmux integration (navigator)
  "christoomey/vim-tmux-navigator",

  -- Markdown links
  "jghauser/follow-md-links.nvim",

  -- Markdown real-time preview
  -- :MarkdownPreview
  -- "iamcco/markdown-preview.nvim",
  -- {
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  -- },
}
