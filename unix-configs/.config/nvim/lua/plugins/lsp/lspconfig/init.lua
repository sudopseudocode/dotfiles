return {
  -- Package manager for LSP/DAP/Linters/Formatters
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- Configs for nvim LSP client
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp", -- Better autocomplete
    },
    config = function()
      -- LSP mappings
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          require("which-key").add({
            {
              "<leader>s",
              group = "LSP",
            },
            {
              "<leader>sd",
              vim.lsp.buf.definition,
              desc = "Go to definition (LSP)",
              buffer = ev.buf,
            },
            {
              "<leader>si",
              vim.lsp.buf.implementation,
              desc = "Go to implementation (LSP)",
              buffer = ev.buf,
            },
            {
              "<leader>sy",
              vim.lsp.buf.type_definition,
              desc = "Go to type def (LSP)",
              buffer = ev.buf,
            },
            {
              "<leader>sR",
              ":LspRestart<CR>",
              desc = "Restart LSP Sources",
            },
            {
              "<leader>sI",
              ":LspInfo<CR>",
              desc = "Show attached LSP clients",
            },
          })
        end,
      })

      -- Diagnostic icons
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "󰌵",
          },
        },
      })

      -- Setup related LSP dependencies
      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })
      -- Setup lspconfig with cmp (auto complete)
      local get_opts = require("plugins.lsp.lspconfig.default_opts")
      local lspconfig = require("lspconfig")
      -- Unix
      -- lspconfig.awk_ls.setup(get_opts())
      lspconfig.bashls.setup(get_opts())
      lspconfig.jsonls.setup(get_opts())
      lspconfig.taplo.setup(get_opts())
      lspconfig.yamlls.setup(get_opts())
      -- Web
      lspconfig.cssls.setup({
        settings = {
          css = { lint = { unknownAtRules = "ignore" } },
        },
      })
      lspconfig.eslint.setup(get_opts({
        format = true,
      }))
      lspconfig.graphql.setup(get_opts())
      lspconfig.html.setup(get_opts())
      lspconfig.marksman.setup(get_opts())
      lspconfig.svelte.setup(get_opts())
      lspconfig.ts_ls.setup(get_opts({ format = false }))
      -- Server
      lspconfig.prismals.setup(get_opts())
      lspconfig.dockerls.setup(get_opts())
      lspconfig.docker_compose_language_service.setup(get_opts())
      lspconfig.gopls.setup(get_opts())
      lspconfig.lua_ls.setup(get_opts())
      lspconfig.pyright.setup(get_opts())
      -- lspconfig.rubocop.setup(get_opts())
      lspconfig.rust_analyzer.setup(get_opts())
      lspconfig.terraformls.setup(get_opts())
      -- lspconfig.omnisharp.setup(get_opts())

      -- Format the diagnostic messages
      vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          underline = true,
          update_in_insert = false,
          virtual_text = false,
        })
    end,
  },

  -- Automatically installs 3rd party tools
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "black",
          "stylua",
          "prettier",
          "prettierd",
          "eslint_d",
        },
        auto_update = true,
      })
    end,
  },
}
