-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.vscode-nvim" },
  { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.pack.cpp" },
  -- import/override with your plugins folder
}
