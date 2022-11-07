local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
    virtual_text = {
        format = function(diagnostic)
            local message =
            diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
        end,
    },
}, neotest_ns)

local neotest = require("neotest")
neotest.setup({
    adapters = {
        require("neotest-go"),
        require("neotest-rust"),
    },
    summary = {
        enabled = true,
        animated = true,
        follow = true,
        expand_errors = true,
        mappings = {
            expand = { "<CR>", "<2-LeftMouse>" },
            expand_all = "e",
            output = "o",
            short = "O",
            attach = "a",
            jumpto = "i",
            stop = "u",
            run = "r",
            mark = "m",
            run_marked = "R",
            clear_marked = "M",
            target = "t",
            clear_target = "T",
            next_failed = "J",
            prev_failed = "K",
        },
    },
})

local wk = require("which-key")
wk.register({
    t = {
        name = 'testing',
        r = { neotest.run.run, "Run nearest test" },
        f = {
            function()
                neotest.run.run(vim.fn.expand("%"))
            end, "Run tests in file"
        },
        d = {
            function()
                neotest.run.run({ strategy = "dap" })
            end, "Debug the nearest test"
        },
        o = {
            function()
                neotest.output.open({ enter = true })
            end, "Open test output"
        },
        s = {
            function()
                neotest.summary.toggle()
            end, "Toggle summary"
        },
        m = {
            function()
                neotest.summary.run_marked()
            end, "Run marked targets"
        },
    }
}, { prefix = '<leader>' })
