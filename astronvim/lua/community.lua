-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.vscode-nvim" },
  { import = "astrocommunity.recipes.vscode-icons" },

  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.editing-support.vim-visual-multi" },

  { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.editing-support.copilotchat-nvim" },
  { import = "astrocommunity.workflow.hardtime-nvim" },
  { import = "astrocommunity.media.vim-wakatime" },
  { import = "astrocommunity.recipes.neovide" },
  -- { import = "astrocommunity.diagnostics.lsp_lines-nvim" },

  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.markdown-and-latex.markview-nvim" },
  { import = "astrocommunity.pack.typst" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.pack.haskell" },
  -- import/override with your plugins folder
}
