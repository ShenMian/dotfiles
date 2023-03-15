-- set vim options here (vim.<first_key>.<second_key> = value)
local options = {
  opt = {
    -- set to true or false etc.
    relativenumber = true, -- sets vim.opt.relativenumber
    number = true, -- sets vim.opt.number
    spell = false, -- sets vim.opt.spell
    signcolumn = "auto", -- sets vim.opt.signcolumn to auto
    wrap = false, -- sets vim.opt.wrap
    scrolloff = 5,
    tabstop = 4,
    shiftwidth = 4,
    softtabstop = 4,
    expandtab = true,
  },
  g = {
    mapleader = " ", -- sets vim.g.mapleader
    autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true, -- enable completion at start
    autopairs_enabled = true, -- enable autopairs at start
    diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements
    instant_username = "sms", -- instant.nvim
  },
}

-- Neovide configuration
if vim.fn.exists "g:neovide" then
  -- local_vim.opt.guifont = { "Cascadia Code PL", ":h12" }
  options.opt.guifont = { "CaskaydiaCove Nerd Font", ":h12" }
  options.g.neovide_hide_mouse_when_typing = true
  options.g.neovide_fullscreen = false

  -- transparency and blur
  -- options.g.neovide_transparency = 0.97
  -- options.g.neovide_floating_opacity = 1
  -- options.g.neovide_floating_blur_amount_x = 2.0
  -- options.g.neovide_floating_blur_amount_y = 2.0

  options.opt.whichwrap = vim.opt.whichwrap - { "b", "s" } -- removing option from list
  options.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
end

return options

-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end
