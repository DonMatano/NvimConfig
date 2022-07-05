local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    clone_timeout = 180, -- Timeout, in seconds, for git clones
  }
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim", commit = "00ec5adef58c5ff9a07f11f45903b9dbbaa1b422" }  -- Have packer manage itself
  use { "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" } -- Useful lua functions used ny lots of plugins
  use { "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e"}
  use { "kyazdani42/nvim-tree.lua", commit = "ec09b80c7bbf8a34c82b6de5f0a67ff78cbc8ae0"}
  use { "windwp/nvim-autopairs", commit = "4a95b3982be7397cd8e1370d1a09503f9b002dbf"}
  use { "nvim-lualine/lualine.nvim", commit = "5113cdb32f9d9588a2b56de6d1df6e33b06a554a"}
  use { "numToStr/Comment.nvim", commit = "4086630ce2aaf76b2652516ee3169f0b558f6be1"}
  use 'wakatime/vim-wakatime'

  -- Colorschemes
  use "folke/tokyonight.nvim"
  use 'folke/lsp-colors.nvim'

  -- Telescope
  use { 'nvim-telescope/telescope.nvim', commit = "1aa74b231c6f93152c4ac51549a0563dca9b4453" }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    commit = "78931d8bf15468d8f11f0c7910d470e88493b36b",
    run = ":TSUpdate",
  }

  -- LSP 
  use { "neovim/nvim-lspconfig", commit = "83dceed599b1236de4c18e31db3e0a0878b6fb59" }
  use { "williamboman/nvim-lsp-installer", commit = "c13ea61d85e2170af35c06b47bcba143cf2f244b" }

  -- CMP
  use { "hrsh7th/nvim-cmp", commit = "9897465a7663997b7b42372164ffc3635321a2fe" }
  use { "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" }
  use { "hrsh7th/cmp-path", commit = "981baf9525257ac3269e1b6701e376d6fbff6921" }
  use { "L3MON4D3/LuaSnip", commit = "295cc9e422060b3200234b42cbee6dde1dfee765" }
  use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }
  use { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
  use { "rafamadriz/friendly-snippets", commit = "688691050074f39e6ec987321738494e08ba562e" }

  -- Git
  use { 'tpope/vim-fugitive', commit = "f809dde0e719f89a6fb5cb80f3be65f5cbc1d1fe" }
  use { 'lewis6991/gitsigns.nvim', commit = "4883988cf8b623f63cc8c7d3f11b18b7e81f06ff" }

  -- Debugger
  use { "folke/trouble.nvim", commit = "da61737d860ddc12f78e638152834487eabf0ee5" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
