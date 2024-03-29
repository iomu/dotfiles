local wk = require("which-key")

wk.register({
    ["<A-Tab>"] = { "<cmd>wincmd w<cr>", "Switch to next window" },
    ["<S-Tab>"] = { "<cmd>wincmd W<cr>", "Switch to previous window" },
    ["<left>"] = { "<cmd>wincmd h<cr>", "Switch to window on the left" },
    ["<down>"] = { "<cmd>wincmd j<cr>", "Switch to window on the bottom" },
    ["<up>"] = { "<cmd>wincmd k<cr>", "Switch to window on the top" },
    ["<right>"] = { "<cmd>wincmd l<cr>", "Switch to window on the right" },
    ["<S-up>"] = { "<cmd>resize +2<cr>", "Increase height" },
    ["<S-down>"] = { "<cmd>resize -2<cr>", "Decrease height" },
    ["<S-left>"] = { "<cmd>vertical resize -2<cr>", "Decrease width" },
    ["<S-right>"] = { "<cmd>vertical resize +2<cr>", "Increase width" },
    ["<esc>"] = { "<cmd>noh<cr>", "Clear search highligh" },
    ["ZZ"] = { "<cmd>w<cr>", "Save buffer" },
    ["[d"] = { vim.diagnostic.goto_prev, "Goto previous error", noremap = true, silent = true },
    ["]d"] = { vim.diagnostic.goto_next, "Goto next error", noremap = true, silent = true },
    ["<leader>df"] = { vim.diagnostic.open_float, "Open diagnostic error in float", noremap = true, silent = true },
})
