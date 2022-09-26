local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_buf_create_user_command(bufnr, "LspFormatting", function()
            -- or vim.lsp.buf.formatting(bufnr) on 0.8
            vim.lsp.buf.formatting_sync()
        end, {})

        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            command = "undojoin | LspFormatting",
            --     callback = function()
            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
            --       vim.lsp.buf.formatting_sync()
            --   end,
        })
    end
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol
    .make_client_capabilities())

-- go
require 'lspconfig'.gopls.setup {
    on_attach = on_attach,
}

-- JavaScript/TypeScript
require 'lspconfig'.tsserver.setup {
    on_attach = on_attach,
}

-- lua
require 'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = { "lua-language-server" },
    settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
}

-- nix
require 'lspconfig'.rnix.setup {
    on_attach = on_attach,
}

-- Rust
require 'lspconfig'.rust_analyzer.setup {
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
    end
}
require 'rust-tools'.setup()
require('rust-tools').inlay_hints.enable()

-- terraform
require 'lspconfig'.terraformls.setup {
    on_attach = on_attach,
}

require 'lspconfig'.bashls.setup {
    on_attach = on_attach,
}
require 'lspconfig'.cmake.setup {
    on_attach = on_attach,
}
require 'lspconfig'.cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
require 'lspconfig'.dockerls.setup {
    on_attach = on_attach,
}
require 'lspconfig'.html.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

local json_schemas = {
    {
        description = "TypeScript compiler configuration file",
        fileMatch = { "tsconfig.json", "tsconfig.*.json" },
        url = "https://json.schemastore.org/tsconfig.json"
    }, {
        description = "Babel configuration",
        fileMatch = { ".babelrc.json", ".babelrc", "babel.config.json" },
        url = "https://json.schemastore.org/babelrc.json"
    }, {
        description = "ESLint config",
        fileMatch = { ".eslintrc.json", ".eslintrc" },
        url = "https://json.schemastore.org/eslintrc.json"
    }, {
        description = "Prettier config",
        fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
        url = "https://json.schemastore.org/prettierrc"
    }, {
        description = "Stylelint config",
        fileMatch = { ".stylelintrc", ".stylelintrc.json", "stylelint.config.json" },
        url = "https://json.schemastore.org/stylelintrc"
    }, {
        description = "Configuration file as an alternative for configuring your repository in the settings page.",
        fileMatch = { ".codeclimate.json" },
        url = "https://json.schemastore.org/codeclimate.json"
    }, {
        description = "AWS CloudFormation provides a common language for you to describe and provision all the infrastructure resources in your cloud environment.",
        fileMatch = { "*.cf.json", "cloudformation.json" },
        url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/cloudformation.schema.json"
    }, {
        description = "The AWS Serverless Application Model (AWS SAM, previously known as Project Flourish) extends AWS CloudFormation to provide a simplified way of defining the Amazon API Gateway APIs, AWS Lambda functions, and Amazon DynamoDB tables needed by your serverless application.",
        fileMatch = { "serverless.template", "*.sam.json", "sam.json" },
        url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/sam.schema.json"
    }, {
        description = "Json schema for properties json file for a GitHub Workflow template",
        fileMatch = { ".github/workflow-templates/**.properties.json" },
        url = "https://json.schemastore.org/github-workflow-template-properties.json"
    }, {
        description = "golangci-lint configuration file",
        fileMatch = { ".golangci.toml", ".golangci.json" },
        url = "https://json.schemastore.org/golangci-lint.json"
    }, {
        description = "NPM configuration file",
        fileMatch = { "package.json" },
        url = "https://json.schemastore.org/package.json"
    }
}

require 'lspconfig'.jsonls.setup {
    on_attach = on_attach,
    settings = { json = { schemas = json_schemas } }
}
require 'lspconfig'.vimls.setup {
    on_attach = on_attach,
}
require 'lspconfig'.yamlls.setup {
    on_attach = on_attach,
    settings = {
        yaml = {
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://json.schemastore.org/drone.json"] = "/.drone.yml",
                ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "/openapi.yml",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/docker-compose.json"
            }
        }
    }
}

-- null (Various tools as LSP) Setup


local null_ls = require("null-ls")
null_ls.setup {
    sources = {
        -- grammer
        null_ls.builtins.diagnostics.vale,
        -- markdown
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.formatting.markdownlint,
        -- js, html, css, formatting
        null_ls.builtins.formatting.prettier,
        -- nix
        null_ls.builtins.code_actions.statix,
        null_ls.builtins.diagnostics.statix,
        null_ls.builtins.diagnostics.deadnix,
        -- shell scripting
        null_ls.builtins.code_actions.shellcheck,
        -- other
        null_ls.builtins.diagnostics.gitlint,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.yamllint,
    },
    on_attach = on_attach,
}


require 'lsp_signature'.setup({
    bind = true,
    handler_opts = { border = 'single' }
})


-- prettier output for lsp diagnostics/renaming menu/references list/etc
local saga = require 'lspsaga'
saga.init_lsp_saga {
    border_style = "rounded",
    move_in_saga = { prev = 'k', next = 'j' },
    diagnostic_header = { " ", " ", "", " " },
    code_action_icon = " ",
    finder_action_keys = {
        open = '<CR>',
        vsplit = 'v',
        split = 's',
        quit = { 'q', '<Esc>' }
    },
    code_action_keys = {
        quit = { "q", '<Esc>' },
        exec = "<CR>",
    },
}
require 'lspsaga.diagnostic'.show_line_diagnostics()

require("lsp_lines").setup()


local wk = require("which-key")

wk.register({
    ["<leader>"] = {
        d = {
            name = "diagnostics",
            t = { require('lsp_lines').toggle, "Toggle LSP lines" },
            l = { "<cmd>TroubleToggle<cr>", "Open Recent File" },
        },
    },
})

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false
})

local diagnostic_symbol_map = {
    { name = "DiagnosticSignError", symbol = " " },
    { name = "DiagnosticSignWarn", symbol = " " },
    { name = "DiagnosticSignInfo", symbol = "" },
    { name = "DiagnosticSignHint", symbol = " " },
}

for _, elm in ipairs(diagnostic_symbol_map) do
    vim.fn.sign_define(elm.name, { texthl = elm.name, text = elm.symbol, numhl = elm.name })
end


-- Display LSP messages overlayd on the current buffer (instead of the status
-- line) at the bottom right corner
require "fidget".setup {}

require("trouble").setup {
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = { "o" }, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = { "zM", "zm" }, -- close all folds
        open_folds = { "zR", "zr" }, -- open all folds
        toggle_fold = { "zA", "za" }, -- toggle fold of current file
        previous = "k", -- previous item
        next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠"
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}