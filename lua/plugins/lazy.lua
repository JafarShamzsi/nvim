local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)


vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd [[
      highlight Normal guibg=NONE ctermbg=NONE
      highlight NormalNC guibg=NONE ctermbg=NONE
      highlight Pmenu guibg=NONE ctermbg=NONE
      highlight FloatBorder guibg=NONE ctermbg=NONE
      highlight NormalFloat guibg=NONE ctermbg=NONE
      highlight TelescopeNormal guibg=NONE
      highlight TelescopeBorder guibg=NONE
    ]]
  end,
})


require("lazy").setup {
  { "folke/lazy.nvim", lazy = true },
  { "folke/tokyonight.nvim", name = "tokyonight", priority = 1000, lazy = false, opts = { style = "storm", transparent = true }, config = function()
    require("tokyonight").setup({ style = "storm", transparent = true })
    vim.cmd.colorscheme("tokyonight")
  end },
  { "neovim/nvim-lspconfig", dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig"
  } },
  { "williamboman/mason.nvim", config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      },
      ensure_installed = {
        -- LSP servers
        "typescript-language-server",
        "pyright",
        "gopls",
        "haskell-language-server",
        "rust-analyzer",
        "clangd",
        "lua-language-server",
        
        -- Formatters
        "stylua",
        "prettier",
        "black",
        "isort",
        "gofumpt",
        "goimports",
        "fourmolu",
        "rustfmt",
        "clang-format",
        "cmake-format",
        "uncrustify",
        
        -- Linters
        "eslint",
        "flake8",
        "golangci-lint",
        "hlint",
        "clang-tidy",
        "cmake-lint",
        
        -- Code actions
        "shellcheck"
      }
    })
  end },
  { "williamboman/mason-lspconfig.nvim", config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "typescript_language_server",
        "pyright",
        "gopls",
        "hls",
        "rust_analyzer",
        "clangd",
        "lua_ls"
      },
      automatic_installation = true
    })
  end },
  { "hrsh7th/nvim-cmp", dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets"
  }, config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
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
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })

    -- Set configuration for specific filetype
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" },
        { name = "buffer" },
      }),
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore)
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore)
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
      }),
    })
  end },
  { "goolord/alpha-nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⣠⡾⠛⠉⠙⠛⠉⠙⠻⣦⡀⠀⠀⠀⠀",
      "⠀⠀⠀⣼⡏⠀⠀⢀⣀⠀⠀⠀⠀⠈⣿⡆⠀⠀⠀",
      "⠀⠀⠀⣿⡇⠀⢰⡿⠿⠿⣷⡄⠀⠀⢸⣿⠀⠀⠀",
      "⠀⠀⠀⣿⡇⠀⢸⡇⠀⠀⢸⡇⠀⠀⢸⣿⠀⠀⠀",
      "⠀⠀⠀⠹⣧⡀⠀⠻⣶⣶⡿⠃⠀⢀⣼⠏⠀⠀⠀",
      "⠀⠀⠀⠀⠈⠛⠷⣤⣤⣤⣤⠶⠛⠋⠁⠀⠀⠀⠀",
      "",
      "  the eye of truth type shi",
    }

    dashboard.section.buttons.val = {
      dashboard.button("f", "🔍 Find File", ":Telescope find_files<CR>"),
      dashboard.button("r", "🕰️  Recent Files", ":Telescope oldfiles<CR>"),
      dashboard.button("e", "📂 Explorer", ":NvimTreeToggle<CR>"),
      dashboard.button("c", "⚙️  Config", ":e ~/.config/nvim/init.lua<CR>"),
      dashboard.button("q", "🛑 Quit", ":qa<CR>"),
    }

    dashboard.section.footer.val = {
      "",
      "\"Hokage Dattebayo\"",
      " — Naruto",
    }

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function()
    require("lualine").setup({
      options = {
        theme = "rose-pine",
        section_separators = "",
        component_separators = "",
      },
    })
  end },
  { "nvim-tree/nvim-tree.lua" },
  { "folke/zen-mode.nvim", config = function()
    require("zen-mode").setup({
      window = {
        width = 80,
        options = {
          number = false,
          relativenumber = false,
        },
      },
      plugins = {
        twilight = { enabled = true },
      },
    })
  end },
  { "folke/twilight.nvim", config = function()
    require("twilight").setup({})
  end },
  { "lewis6991/gitsigns.nvim", config = function()
    require("gitsigns").setup()
  end },
  { "giusgad/pets.nvim", dependencies = { "MunifTanjim/nui.nvim" }, config = function()
    require("pets").setup({
      row = 2,
      col = 2,
      speed = 25,
      default_pet = "dog",
      default_style = "brown",
    })
  end },
  { "Kurama622/llm.nvim", dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" }, config = function()
    require("llm").setup({
      backend = "openai",
      openai = {
        api_key = os.getenv("OPENAI_API_KEY"),
        base_url = "https://api.openai.com/v1",
        chat_completions_url = "/chat/completions"
      },
      model = "gpt-4",
      ui = {
        floating = true,
        position = "center",
        width = 0.8,
        height = 0.8,
        border = "rounded",
        title = "LLM Chat",
        title_pos = "center",
      },
      chat = {
        markdown = true,
        syntax = true,
        wrap = true,
        number = false,
        relativenumber = false,
        cursorline = true,
        signcolumn = "no",
        foldcolumn = "0",
        list = false,
        spell = false,
        wrap = true,
        linebreak = true,
        showbreak = "↪ ",
      },
      context = {
        markdown = true,
        syntax = true,
        wrap = true,
        number = true,
        relativenumber = true,
        cursorline = true,
        signcolumn = "yes",
        foldcolumn = "1",
        list = true,
        spell = false,
        wrap = true,
        linebreak = true,
        showbreak = "↪ ",
      },
    })
  end },
  { "olimorris/codecompanion.nvim", lazy = false, dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" }, opts = { strategies = { inline = { adapter = "anthropic" }, chat = { adapter = "anthropic" } }, anthropic = { api_key = os.getenv("ANTHROPIC_API_KEY"), model = "claude-3-7-sonnet-20241022" }, suggestion = { enabled = true, auto_trigger = true, debounce = 75, accept_keymap = "<C-l>" }, log_level = "DEBUG" }, config = function(_, opts) require("codecompanion").setup(opts) vim.notify("🧠 Claude 3.7 online. This crap works", vim.log.levels.INFO) vim.api.nvim_create_autocmd("User", { pattern = "CodeCompanionTokensUsed", callback = function(args) local tokens = args.data and args.data.tokens or 0 vim.notify("🧾 Claude used " .. tokens .. " tokens in that suggestion", vim.log.levels.INFO) end }) end }
}
