require("toggleterm").setup({
    open_mapping = '<C-\\>',
    direction = 'float',
    shade_terminals = true,
})

local Terminal = require('toggleterm.terminal').Terminal
local k9s      = Terminal:new({ cmd = 'k9s', hidden = true })

function _toggle_k9s()
    k9s:toggle()
end

local wk = require('which-key')
wk.register({
    p = {
        name = 'terminal',
        k = { _toggle_k9s, "Toggle K9s", noremap = true, silent = true }
    }
}, { prefix = '<leader>' })

