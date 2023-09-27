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
    lazy = false,
  },

  -- Multiple cursors
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },

  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function() require("mini.move").setup() end,
  },

  -- Auto resize focused window
  {
    "beauwilliams/focus.nvim",
    event = "VeryLazy",
    config = function() require("focus").setup() end,
  },

  -- AI-powered code completion
  "Exafunction/codeium.vim",

  {
    "zbirenbaum/neodim",
    event = "LspAttach",
    config = function()
      require("neodim").setup {
        alpha = 0.75,
        blend_color = "#000000",
        update_in_insert = {
          enable = true,
          delay = 100,
        },
        hide = {
          virtual_text = true,
          signs = true,
          underline = true,
        },
      }
    end,
  },

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

  {
    "m4xshen/hardtime.nvim",
    opts = { disable_mouse = false },
  },

  -- Markdown real-time preview
  -- :MarkdownPreview
  -- "iamcco/markdown-preview.nvim",
  -- {
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  -- },
}
