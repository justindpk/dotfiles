return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      local lsp_attach = function(client, bufnr)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })

        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr, desc = "Format" })

        -- -- vim.keymap.set("n", "<leader>vws",         -- --   vim.lsp.buf.workspace_symbol()
        -- -- end, opts)
        -- vim.keymap.set("n", "<leader>vd",         -- 	vim.diagnostic.open_float()
        -- end, opts)
        -- vim.keymap.set("n", "[d",         -- 	vim.diagnostic.goto_next()
        -- end, opts)
        -- vim.keymap.set("n", "]d",         -- 	vim.diagnostic.goto_prev()
        -- end, opts)

        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })

        vim.keymap.set("n", "<leader>lc", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })

        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
      end

      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local get_servers = require("mason-lspconfig").get_installed_servers
      for _, server_name in ipairs(get_servers()) do
        if server_name == "lua_ls" then
          require 'lspconfig'.lua_ls.setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
            on_init = function(client)
              local path = client.workspace_folders[1].name
              if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                  Lua = {
                    runtime = {
                      version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                      checkThirdParty = false,
                      library = {
                        vim.env.VIMRUNTIME
                        -- "${3rd}/luv/library"
                        -- "${3rd}/busted/library",
                      }
                      -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                      -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                  }
                })

                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
              end
              return true
            end
          })
        else
          lspconfig[server_name].setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
          })
        end
      end
    end
  },
  {
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        -- "zbirenbaum/copilot-cmp",
      },
      config = function()
        local cmp = require("cmp")
        require("luasnip.loaders.from_vscode").lazy_load()
        cmp.setup({
          completion = {
            -- autocomplete = true,
            -- autocomplete = { "InsertEnter", "TextChanged" },
            -- keyword_lengh = 0,
          },
          experimental = {
            ghost_text = false,
          },
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            end,
          },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
          }),
          sources = cmp.config.sources({
            -- { name = "copilot" },
            { name = "path" },
            { name = "nvim_lsp" },
            { name = "luasnip" },

            { name = "nvim_lua" },
          }, {
            { name = "buffer" },
          }),

        })

        cmp.setup.filetype("lua", {
          sources = cmp.config.sources({
            -- { name = "copilot" },
            { name = "nvim_lsp" },
            { name = "luasnip" },

            { name = "path" },
            { name = "nvim_lua" },
          }, {
            { name = "buffer" },
          }),
        })

        cmp.setup.cmdline({ "/", "?" }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          },
        })

        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            { name = "cmdline" },
          }),
        })
      end,
    },
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          suggestion = {
            enabled = true,
            auto_trigger = true,
            -- keymap = {
            --   accept = "<S-Tab>",
            -- },
          },
          panel = { enabled = false },
          server_opts_overrides = {
            settings = {
              advanced = {
                inlineSuggestCount = 1,
                length = 20,
                temperature = 0,

              },
            },
          },
        })
        vim.keymap.set("i", "<S-Tab>", require("copilot.suggestion").accept_word, { desc = "Copilot Suggest" })
        vim.keymap.set("i", "<C-Tab>", require("copilot.suggestion").accept_line, { desc = "Copilot Suggest" })
      end,
    },
  }
}
