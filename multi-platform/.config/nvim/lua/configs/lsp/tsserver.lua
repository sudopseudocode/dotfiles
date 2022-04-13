local lspconfig = require("lspconfig")

return {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end,
    -- Disable for JS since we use flow
    filetypes = {
        -- "javascript",
        -- "javascriptreact",
        -- "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    -- Don't use in a .flowconfig project, but other JS projects could still use TS server
    root_dir = function(fname)
        return lspconfig.util.root_pattern("tsconfig.json")(fname)
    end,
}
