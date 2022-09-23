require('nvim-tree').setup {
    -- update the focused file on `BufEnter`, un-collapses the folders
    -- recursively until it finds the file
    update_focused_file = { enable = true },
    renderer = {
        indent_markers = { enable = true }
    }
}

local wk = require("which-key")
wk.register({
    ["<leader>t"] = { "<cmd>NvimTreeToggle<cr>", "Open Tree" },
})
