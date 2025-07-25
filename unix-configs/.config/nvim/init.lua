require("settings")
require("mappings")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { "folke/which-key.nvim" }, -- load first
    { import = "plugins.lsp" },
    { import = "plugins.productivity" },
    { import = "plugins.ui" },
  },
  rocks = {
    hererocks = true,
  },
})
