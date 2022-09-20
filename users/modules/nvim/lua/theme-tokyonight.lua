require("tokyonight").setup({})
require('lualine').setup {
  options = {
    theme = 'tokyonight'
  }
}

vim.opt.background = 'dark'
vim.cmd[[colorscheme tokyonight-night]]