require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    transparent_background = false,
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_higghts = function(c)
        local prompt = "#313244"
        return {
            TelescopeNormal = {
                bg = c.base,
                --[[ fg = c.fg_dark, ]]
            },
            TelescopeBorder = {
                bg = c.base,
                fg = c.base,
            },
            TelescopePromptNormal = {
                bg = prompt,
            },
            TelescopePromptBorder = {
                bg = prompt,
                fg = prompt,
            },
            TelescopePromptTitle = {
                bg = prompt,
                fg = prompt,
            },
            TelescopePreviewTitle = {
                bg = c.base,
                fg = c.base,
            },
            TelescopeResultsTitle = {
                bg = c.base,
                fg = c.base,
            },
        }
    end,
    integrations = {
        cmp = true,
        fidget = true,
        gitsigns = true,
        leap = true,
        lsp_saga = true,
        lsp_trouble = true,
        noice = true,
        notify = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
    },
})

require('lualine').setup {
    options = {
        theme = 'catppuccin',
        component_separators = '|',
        section_separators = '',
    }
}

vim.opt.background = 'dark'
vim.cmd.colorscheme "catppuccin"
