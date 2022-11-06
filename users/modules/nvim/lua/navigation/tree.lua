require('nvim-tree').setup {
    -- update the focused file on `BufEnter`, un-collapses the folders
    -- recursively until it finds the file
    update_focused_file = { enable = true, update_root = true },
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    renderer = {
        indent_markers = { enable = true }
    },
}

local wk = require("which-key")
wk.register({
    ["<leader><CR>"] = { "<cmd>NvimTreeToggle<cr>", "Open Tree" },
})

require("dirbuf").setup {
    hash_padding = 2,
    show_hidden = true,
    sort_order = "default",
    write_cmd = "DirbufSync",
}
