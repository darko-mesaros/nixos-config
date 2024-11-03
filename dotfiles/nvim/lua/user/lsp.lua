-- Basic LSP setup
local lspconfig = require("lspconfig")
local cmp = require("cmp")
local null_ls = require("null-ls")

-- Keymaps
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Global mappings
map("n", "<space>e", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<space>q", vim.diagnostic.setloclist)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Buffer local mappings
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  map("n", "gD", vim.lsp.buf.declaration, bufopts)
  map("n", "gd", vim.lsp.buf.definition, bufopts)
  map("n", "K", vim.lsp.buf.hover, bufopts)
  map("n", "gi", vim.lsp.buf.implementation, bufopts)
  map("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  map("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  map("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  map("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  map("n", "gr", vim.lsp.buf.references, bufopts)
  map("n", "<space>cf", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)

  -- Illuminate setup
  require("illuminate").on_attach(client)
end

-- JSON schemas configuration
local schemas = {
  {
    description = "TypeScript compiler configuration file",
    fileMatch = { "tsconfig.json", "tsconfig.*.json" },
    url = "https://json.schemastore.org/tsconfig.json",
  },
  {
    description = "ESLint config",
    fileMatch = { ".eslintrc.json", ".eslintrc" },
    url = "https://json.schemastore.org/eslintrc.json",
  },
  {
    description = "Prettier config",
    fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
    url = "https://json.schemastore.org/prettierrc",
  },
  {
    description = "NPM configuration file",
    fileMatch = { "package.json" },
    url = "https://json.schemastore.org/package.json",
  },
  -- Add other schemas as needed from your list
}

-- LSP Configurations per language
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- TypeScript/JavaScript
lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

-- Lua
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
        return
      end
    end

    client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
      },
    })
  end,
})

-- Python
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
      },
    },
  },
})

-- Rust
lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
      cargo = {
        allFeatures = true,
      },
      diagnostics = {
        enable = true,
      },
      hoverActions = {
        enable = true,
      },
      lens = {
        enable = true,
      },
      procMacro = {
        enable = true,
        ignored = {
          leptos_macro = {
            "server",
          },
        },
      },
    },
  },
})

-- JSON
lspconfig.jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    json = {
      schemas = schemas,
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        end,
      },
    },
  },
})

-- Nix
lspconfig.nil_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["nil"] = {
      formatting = {
        command = { "alejandra" },
      },
      diagnostics = {
        enable = true,
        excludePatterns = { "Shell expression" },
      },
      nix = {
        maxMemoryMB = 4096,
        flake = {
          autoEvalInputs = true,
        },
      },
    },
  },
})

-- Optional: Add Nix-specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = "nix",
  callback = function()
    -- Local buffer keymaps for Nix files
    vim.keymap.set("n", "<leader>nf", ":lua vim.lsp.buf.format()<CR>", { buffer = true, desc = "Format Nix file" })
    vim.keymap.set("n", "<leader>na", ":!nix flake check<CR>", { buffer = true, desc = "Check Nix flake" })
  end,
})

-- Set up null-ls
null_ls.setup({
  debug = false,
  sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.formatting.alejandra, -- Nix formatter
    null_ls.builtins.diagnostics.statix,   -- Nix linter
  },
  on_attach = on_attach,
})

-- Completion setup
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
})

-- Actions Preview configuration
require("actions-preview").setup({
  telescope = {
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      width = 0.8,
      height = 0.9,
      prompt_position = "top",
      preview_cutoff = 20,
      preview_height = function(_, _, max_lines)
        return max_lines - 15
      end,
    },
  },
})
