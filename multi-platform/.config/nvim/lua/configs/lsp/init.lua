return function()
    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "gf", function()
                vim.lsp.buf.format({ async = true })
            end, opts)
        end,
    })

    -- Diagnostic icons
    local signs =
    { Error = "", Warn = "", Hint = "", Info = "" }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Setup lspconfig with cmp (auto complete)
    local lspconfig = require("lspconfig")
    local default_opts = {
        capabilities = require("configs.lsp.default-capabilities"),
    }
    -- Unix
    lspconfig.awk_ls.setup(default_opts)
    lspconfig.bashls.setup(default_opts)
    lspconfig.jsonls.setup(require("configs.lsp.json"))
    lspconfig.taplo.setup(default_opts)
    lspconfig.yamlls.setup(default_opts)
    -- Web
    lspconfig.cssls.setup(default_opts)
    lspconfig.cssmodules_ls.setup(default_opts)
    lspconfig.emmet_ls.setup(default_opts)
    lspconfig.graphql.setup(default_opts)
    lspconfig.html.setup(default_opts)
    lspconfig.intelephense.setup(default_opts)
    lspconfig.marksman.setup(default_opts)
    lspconfig.svelte.setup(default_opts)
    lspconfig.tsserver.setup(require("configs.lsp.tsserver"))
    -- Server
    lspconfig.clangd.setup(default_opts)
    lspconfig.dockerls.setup(default_opts)
    lspconfig.docker_compose_language_service.setup(default_opts)
    lspconfig.gopls.setup(default_opts)
    lspconfig.lua_ls.setup(default_opts)
    lspconfig.pyright.setup(default_opts)
    lspconfig.rust_analyzer.setup(default_opts)
    lspconfig.terraformls.setup(default_opts)

    -- Format the diagnostic messages
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            underline = true,
            update_in_insert = false,
            virtual_text = false,
        })
end
