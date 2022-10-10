local wk = require("which-key")

wk.register({
    ["<A-Tab>"] = { "<cmd>wincmd w<cr>", "Switch to next window" },
    ["<S-Tab>"] = { "<cmd>wincmd W<cr>", "Switch to previous window" },
    ["<left>"] = { "<cmd>wincmd h<cr>", "Switch to window on the left" },
    ["<down>"] = { "<cmd>wincmd j<cr>", "Switch to window on the bottom" },
    ["<up>"] = { "<cmd>wincmd k<cr>", "Switch to window on the top" },
    ["<right>"] = { "<cmd>wincmd l<cr>", "Switch to window on the right" },
})
