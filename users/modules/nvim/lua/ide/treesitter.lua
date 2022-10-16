require 'nvim-treesitter.configs'.setup {
    highlight = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm"
        }
    },
    indent = { enable = true },
    refactor = { highlight_definitions = { enable = true } },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner"
            }
        },
        swap = {
            enable = true,
            swap_next = { ["<leader>npn"] = "@parameter.inner" },
            swap_previous = { ["<leader>npp"] = "@parameter.inner" }
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
    },
    context_commentstring = {
        enable = true
    }
}

local keyopts = { noremap = true, silent = true }
vim.keymap.set({'n', 'v', 'o'}, 'H', require('tree-climber').goto_parent, keyopts)
vim.keymap.set({'n', 'v', 'o'}, 'L', require('tree-climber').goto_child, keyopts)
vim.keymap.set({'n', 'v', 'o'}, 'J', require('tree-climber').goto_next, keyopts)
vim.keymap.set({'n', 'v', 'o'}, 'K', require('tree-climber').goto_prev, keyopts)
--[[ vim.keymap.set({'v', 'o'}, 'in', require('tree-climber').select_node, keyopts) ]]
vim.keymap.set('n', '<c-k>', require('tree-climber').swap_prev, keyopts)
vim.keymap.set('n', '<c-j>', require('tree-climber').swap_next, keyopts)
