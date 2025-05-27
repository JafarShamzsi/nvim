local M = {}

-- LSP servers to install
local servers = {
  -- TypeScript/JavaScript
  tsserver = {
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
        suggest = {
          completeFunctionCalls = true,
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
        suggest = {
          completeFunctionCalls = true,
        },
      },
    },
  },

  -- Python
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
          inlayHints = {
            variableTypes = true,
            functionReturnTypes = true,
            parameterTypes = true,
          },
        },
      },
    },
  },

  -- Go
  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
        gofumpt = true,
        usePlaceholders = true,
        completeUnimported = true,
        buildFlags = { "-tags=integration,e2e" },
      },
    },
  },

  -- Haskell
  hls = {
    settings = {
      haskell = {
        formattingProvider = "fourmolu",
        plugin = {
          tactics = {
            globalOn = true,
          },
          class = {
            globalOn = true,
          },
          importLens = {
            globalOn = true,
          },
          refineImports = {
            globalOn = true,
          },
          moduleName = {
            globalOn = true,
          },
          eval = {
            globalOn = true,
          },
          splice = {
            globalOn = true,
          },
          codeRange = {
            globalOn = true,
          },
          retrieve = {
            globalOn = true,
          },
          callHierarchy = {
            globalOn = true,
          },
          typeSignature = {
            globalOn = true,
          },
          rename = {
            globalOn = true,
          },
          hlint = {
            globalOn = true,
          },
          pragmas = {
            globalOn = true,
          },
        },
      },
    },
  },

  -- Rust
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
        },
        procMacro = {
          enable = true,
          ignored = {
            ["async-trait"] = { "async_trait" },
            ["napi-derive"] = { "napi" },
            ["async-recursion"] = { "async_recursion" },
          },
        },
        checkOnSave = {
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
        diagnostics = {
          enable = true,
          experimental = {
            enable = true,
          },
        },
        inlayHints = {
          enable = true,
          showParameterHints = true,
          parameterHintsPrefix = "<- ",
          otherHintsPrefix = "=> ",
        },
        lens = {
          enable = true,
          references = true,
          implementations = true,
          run = true,
          debug = true,
          gotoTypeDef = true,
          methodReferences = true,
          referencesADT = true,
          enumVariantReferences = true,
          memoryLayout = true,
        },
        hover = {
          actions = {
            enable = true,
            references = true,
            run = true,
            debug = true,
            gotoTypeDef = true,
            implementations = true,
          },
        },
        completion = {
          autoimport = {
            enable = true,
          },
        },
        assist = {
          importGranularity = "module",
          importPrefix = "self",
        },
        callInfo = {
          full = true,
        },
        caching = {
          enable = true,
        },
        check = {
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
        files = {
          excludeDirs = { ".git", "target" },
        },
        hoverActions = {
          enable = true,
          debug = true,
          gotoTypeDef = true,
          implementations = true,
          references = true,
          run = true,
        },
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        notifications = {
          cargoTomlNotFound = true,
        },
        rustc_private = true,
        semanticHighlighting = {
          enable = true,
        },
        workspace = {
          symbol = {
            search = {
              kind = "all_symbols",
            },
          },
        },
      },
    },
  },

  -- C/C++
  clangd = {
    settings = {
      clangd = {
        arguments = {
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=iwyu",
          "--suggest-missing-includes",
          "--all-scopes-completion",
          "--pch-storage=memory",
          "--log=error",
          "-j=12",
          "--fallback-style=Google",
          "--header-insertion-decorators",
          "--enable-config",
          "--offset-encoding=utf-16",
          "--ranking-model=heuristics",
          "--folding-ranges",
          "--enable-config",
          "--clang-tidy-checks=-*,llvmlibc-*,cata-*,google-*,modernize-*,-google-*",
          "--cross-file-rename",
          "--limit-references=1000",
          "--limit-results=1000",
          "--limit-symbols-to-include-in-quickfix=1000",
        },
      },
    },
  },

  -- Lua
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
        hint = {
          enable = true,
          arrayIndex = "Disable",
          await = true,
          paramName = "Disable",
          paramType = false,
          semicolon = "Disable",
          setType = true,
        },
      },
    },
  },
}

-- LSP keymaps
local function setup_lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local map = vim.keymap.set

  -- LSP keymaps
  map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition", noremap = true, silent = true, buffer = bufnr })
  map("n", "gr", vim.lsp.buf.references, { desc = "Go to References", noremap = true, silent = true, buffer = bufnr })
  map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation", noremap = true, silent = true, buffer = bufnr })
  map("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to Type Definition", noremap = true, silent = true, buffer = bufnr })
  map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation", noremap = true, silent = true, buffer = bufnr })
  map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", noremap = true, silent = true, buffer = bufnr })
  map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol", noremap = true, silent = true, buffer = bufnr })
  map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type Definition", noremap = true, silent = true, buffer = bufnr })
  map("n", "<leader>ds", vim.lsp.buf.document_symbol, { desc = "Document Symbols", noremap = true, silent = true, buffer = bufnr })
  map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { desc = "Workspace Symbols", noremap = true, silent = true, buffer = bufnr })
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add Workspace Folder", noremap = true, silent = true, buffer = bufnr })
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove Workspace Folder", noremap = true, silent = true, buffer = bufnr })
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = "List Workspace Folders", noremap = true, silent = true, buffer = bufnr })
  map("n", "<leader>f", vim.lsp.buf.formatting, { desc = "Format Document", noremap = true, silent = true, buffer = bufnr })
  map("n", "<leader>i", vim.lsp.buf.incoming_calls, { desc = "Incoming Calls", noremap = true, silent = true, buffer = bufnr })
  map("n", "<leader>o", vim.lsp.buf.outgoing_calls, { desc = "Outgoing Calls", noremap = true, silent = true, buffer = bufnr })
  map("n", "<leader>di", vim.diagnostic.open_float, { desc = "Show Diagnostic", noremap = true, silent = true, buffer = bufnr })
  map("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Next Diagnostic", noremap = true, silent = true, buffer = bufnr })
  map("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic", noremap = true, silent = true, buffer = bufnr })
  map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic List", noremap = true, silent = true, buffer = bufnr })
  map("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostic Quickfix", noremap = true, silent = true, buffer = bufnr })
end

-- LSP handlers
local function setup_lsp_handlers()
  -- Show line diagnostics automatically in hover window
  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })

  -- Show diagnostics in hover window
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = " ",
        scope = "cursor",
      }
      vim.diagnostic.open_float(nil, opts)
    end,
  })

  -- LSP handlers
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

-- LSP setup
function M.setup()
  -- Setup LSP handlers
  setup_lsp_handlers()

  -- Setup LSP servers
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local on_attach = function(client, bufnr)
    setup_lsp_keymaps(bufnr)
  end

  -- Setup each LSP server
  for server, config in pairs(servers) do
    lspconfig[server].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = config.settings,
    })
  end

  -- Setup null-ls for formatting and linting
  local null_ls = require("null-ls")
  null_ls.setup({
    sources = {
      -- Formatting
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.gofumpt,
      null_ls.builtins.formatting.goimports,
      null_ls.builtins.formatting.fourmolu,
      null_ls.builtins.formatting.rustfmt,
      null_ls.builtins.formatting.clang_format,
      null_ls.builtins.formatting.cmake_format,
      null_ls.builtins.formatting.uncrustify,

      -- Diagnostics
      null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.diagnostics.flake8,
      null_ls.builtins.diagnostics.golangci_lint,
      null_ls.builtins.diagnostics.hlint,
      null_ls.builtins.diagnostics.clang_check,
      null_ls.builtins.diagnostics.cmake_lint,

      -- Code actions
      null_ls.builtins.code_actions.eslint,
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.refactoring,
      null_ls.builtins.code_actions.shellcheck,

      -- Hover
      null_ls.builtins.hover.dictionary,
      null_ls.builtins.hover.printenv,
    },
    on_attach = on_attach,
  })
end

return M
