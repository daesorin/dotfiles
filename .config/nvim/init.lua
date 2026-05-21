-- CORE SETTINGS
-- define leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- editor behaviour
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.termguicolors = true

-- wayland clipboard integration
vim.opt.clipboard = "unnamedplus"

-- regional standardisation
vim.opt.spelllang = "en_gb"

-- PACKAGE MANAGER
-- bootstrap lazy nvim
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

-- PLUGINS
-- load flexoki and core utilities
require("lazy").setup({
  {
    "kepano/flexoki-neovim",
    name = "flexoki",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme flexoki-dark")
      -- override specific highlights to match your sway environment
      vim.api.nvim_set_hl(0, "Normal", { bg = "#100F0F" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#100F0F" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- INSTALLATION
      -- trigger parser downloads
      require("nvim-treesitter").install({ "lua", "bash", "markdown", "markdown_inline" })

      -- HIGHLIGHTING
      -- activate native treesitter engine per filetype
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lua", "sh", "markdown" },
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require("cmp")
      
      -- COMPLETION ENGINE SETUP
      -- initialise strictly local sources for paths and buffer text
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), 
        }),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "buffer" },
        })
      })
    end,
  }
})
