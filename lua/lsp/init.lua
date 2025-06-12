local M = {}

-- LSP servers to install
local servers = {
  -- TypeScript/JavaScript
  ts_ls = {
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
  local map = vim.keymap.set

  -- Helper function to safely map keys
  local function safe_map(mode, lhs, rhs, opts)
    if type(rhs) == "function" or (type(rhs) == "table" and rhs ~= nil) then
      map(mode, lhs, rhs, opts)
    else
      -- Check if it's a vim.lsp.buf function that exists
      local func_parts = {}
      if type(rhs) == "string" then
        for part in rhs:gmatch("[^%.]+") do
          table.insert(func_parts, part)
        end
      end
      
      if #func_parts > 0 then
        local func = vim
        for _, part in ipairs(func_parts) do
          if func and func[part] then
            func = func[part]
          else
            func = nil
            break
          end
        end
        
        if func and type(func) == "function" then
          map(mode, lhs, func, opts)
        end
      end
    end
  end

  -- LSP keymaps with safe mapping
  safe_map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition", noremap = true, silent = true, buffer = bufnr })
  safe_map("n", "gr", vim.lsp.buf.references, { desc = "Go to References", noremap = true, silent = true, buffer = bufnr })
  safe_map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation", noremap = true, silent = true, buffer = bufnr })
  safe_map("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to Type Definition", noremap = true, silent = true, buffer = bufnr })
  safe_map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation", noremap = true, silent = true, buffer = bufnr })
  safe_map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", noremap = true, silent = true, buffer = bufnr })
  safe_map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol", noremap = true, silent = true, buffer = bufnr })
  safe_map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type Definition", noremap = true, silent = true, buffer = bufnr })
  safe_map("n", "<leader>ds", vim.lsp.buf.document_symbol, { desc = "Document Symbols", noremap = true, silent = true, buffer = bufnr })
  safe_map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { desc = "Workspace Symbols", noremap = true, silent = true, buffer = bufnr })
  
  -- Safely handle workspace folder functions
  if vim.lsp.buf.add_workspace_folder then
    safe_map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add Workspace Folder", noremap = true, silent = true, buffer = bufnr })
  end
  if vim.lsp.buf.remove_workspace_folder then
    safe_map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove Workspace Folder", noremap = true, silent = true, buffer = bufnr })
  end
  if vim.lsp.buf.list_workspace_folders then
    safe_map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = "List Workspace Folders", noremap = true, silent = true, buffer = bufnr })
  end
  
  -- Format function (updated for Neovim 0.11.0)
  safe_map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format Document", noremap = true, silent = true, buffer = bufnr })
  
  -- Call hierarchy functions (may not exist in all versions)
  if vim.lsp.buf.incoming_calls then
    safe_map("n", "<leader>i", vim.lsp.buf.incoming_calls, { desc = "Incoming Calls", noremap = true, silent = true, buffer = bufnr })
  end
  if vim.lsp.buf.outgoing_calls then
    safe_map("n", "<leader>o", vim.lsp.buf.outgoing_calls, { desc = "Outgoing Calls", noremap = true, silent = true, buffer = bufnr })
  end
  
  -- Diagnostic keymaps
  safe_map("n", "<leader>di", vim.diagnostic.open_float, { desc = "Show Diagnostic", noremap = true, silent = true, buffer = bufnr })
  safe_map("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Next Diagnostic", noremap = true, silent = true, buffer = bufnr })
  safe_map("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic", noremap = true, silent = true, buffer = bufnr })
  safe_map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic List", noremap = true, silent = true, buffer = bufnr })
  safe_map("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostic Quickfix", noremap = true, silent = true, buffer = bufnr })
end

-- LSP handlers
local function setup_lsp_handlers()
  -- Patch the change tracking issue in Neovim 0.11.0
  local original_send_changes = vim.lsp._changetracking.send_changes
  vim.lsp._changetracking.send_changes = function(client, bufnr)
    -- Safely call the original function with error handling
    local ok, err = pcall(original_send_changes, client, bufnr)
    if not ok then
      -- Silently ignore change tracking errors
      vim.schedule(function()
        vim.notify("LSP change tracking error suppressed (this is expected in Neovim 0.11.0)", vim.log.levels.DEBUG)
      end)
    end
  end

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
  
  -- Add change tracking capabilities
  capabilities.textDocument.synchronization = {
    dynamicRegistration = false,
    willSave = true,
    willSaveWaitUntil = true,
    didSave = true
  }
  
  local on_attach = function(client, bufnr)
    -- Ensure buffer is valid and attach is called properly
    if not vim.api.nvim_buf_is_valid(bufnr) then
      return
    end
    
    -- Initialize change tracking for this buffer
    pcall(function()
      vim.lsp._changetracking.init(client, bufnr)
    end)
    
    setup_lsp_keymaps(bufnr)
    
    -- Set up buffer-specific autocommands to handle change tracking
    vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
      buffer = bufnr,
      callback = function()
        -- Safely handle change tracking
        pcall(function()
          if client and client.server_capabilities and client.server_capabilities.textDocumentSync then
            vim.lsp._changetracking.flush(client, bufnr)
          end
        end)
      end,
    })
  end

  -- Setup each LSP server
  for server, config in pairs(servers) do
    lspconfig[server].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = config.settings,
    })
  end

  -- Setup none-ls for formatting and linting (maintained fork of null-ls)
  local ok, null_ls = pcall(require, "null-ls")
  if ok then
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
  else
    vim.notify("none-ls.nvim not found - formatting and linting disabled", vim.log.levels.WARN)
  end
end

return M
