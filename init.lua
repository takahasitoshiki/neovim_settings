vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus"

-- lua/options.lua を読み込む
require("options")
-- lua/keymaps.lua を読み込む
require("keymaps")

-- lazy.nvimのインストールスクリプト
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 前に書いたrequireをこの下に移動させる
require("options")
require("keymaps")

-- pluginsフォルダの中身を読み込む設定
require("lazy").setup("plugins")

vim.opt.clipboard = "unnamedplus"

