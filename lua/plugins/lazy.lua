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
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = function()
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
    })
  end },
  { "neovim/nvim-lspconfig", dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig"
  } },
  { "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
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
        "ts_ls",
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

    -- Use buffer source for `/` and `?`
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':'
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
        theme = "tokyonight",
        section_separators = "",
        component_separators = "",
      },
    })
  end },
  { "nvim-tree/nvim-tree.lua", config = function()
    require("nvim-tree").setup({
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
    })
  end },
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
  { "yacineMTB/dingllm.nvim", 
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- No setup needed, the plugin is ready to use
    end
  },
  { "olimorris/codecompanion.nvim", lazy = false, dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" }, opts = { strategies = { inline = { adapter = "anthropic" }, chat = { adapter = "anthropic" } }, anthropic = { api_key = os.getenv("ANTHROPIC_API_KEY"), model = "claude-3-7-sonnet-20241022" }, suggestion = { enabled = true, auto_trigger = true, debounce = 75, accept_keymap = "<C-l>" }, log_level = "DEBUG" }, config = function(_, opts) require("codecompanion").setup(opts) vim.notify("🧠 Claude 3.7 online. This crap works", vim.log.levels.INFO) vim.api.nvim_create_autocmd("User", { pattern = "CodeCompanionTokensUsed", callback = function(args) local tokens = args.data and args.data.tokens or 0 vim.notify("🧾 Claude used " .. tokens .. " tokens in that suggestion", vim.log.levels.INFO) end }) end }
}