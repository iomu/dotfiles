local actions = require "telescope.actions"

require('telescope').setup {
    mappings = {
        i = {
            ["<Down>"] = actions.cycle_history_next,
            ["<Up>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
        },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
}
require('telescope').load_extension('fzf')

local wk = require("which-key")

wk.register({
    ["<leader>"] = {
        f = {
            name = "file",
            f = { require('telescope.builtin').find_files, "Find File" },
            r = { require('telescope.builtin').oldfiles, "Open Recent File" },
        },
        s = {
            name = "search",
            f = { require('telescope.builtin').find_files, "[S]earch [F]iles" },
            h = { require('telescope.builtin').help_tags, "[S]earch [H]elp" },
            w = { require('telescope.builtin').grep_string, "[S]earch current [W]ord" },
            g = { require('telescope.builtin').live_grep, "[S]earch by [G]rep" },
            d = { require('telescope.builtin').diagnostics, "[S]earch [D]iagnostics" },
        },
        g = {
            name = "git",
            b = { require('telescope.builtin').git_branches, "[G]it [B]ranches" },
            fc = { require('telescope.builtin').git_bcommits, "[G]it [F]ile [C]ommits" },
            s = { require('telescope.builtin').git_status, "[G]it [S]tatus" },
        },
    },
    ["<leader>?"] = { require('telescope.builtin').oldfiles, "Open Recent File" },
    ["<leader><space>"] = { require('telescope.builtin').buffers, "Find existing buffers" },
    ["<leader>/"] = { function() require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            previewer = false,
        })
    end, "Fuzzily search in current buffer" },
})
