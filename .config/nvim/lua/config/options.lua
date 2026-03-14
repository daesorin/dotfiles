-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Make Neovim transparent to match Tmux
vim.cmd([[ highlight Normal guibg=NONE ctermbg=NONE ]])
vim.cmd([[ highlight NonText guibg=NONE ctermbg=NONE ]])
