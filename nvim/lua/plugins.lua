return {
  { "NTBBloodbath/doom-one.nvim", priority = 1000, lazy = false, config = function()
      vim.g.doom_one_terminal_colors = true
      vim.cmd.colorscheme("doom-one")
      vim.api.nvim_set_hl(0, "Normal", { bg = "#181A20" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#181A20" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "#181A20" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#181A20", bg = "#181A20" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "#181A20" })
    end },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require("lualine").setup({ options = { theme = "auto", section_separators = "", component_separators = "" } }) end },
  { "akinsho/bufferline.nvim", event = "VeryLazy", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = { options = { diagnostics = "nvim_lsp", separator_style = "slant", always_show_bufferline = false } } },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = function() require("telescope").setup({ defaults = { sorting_strategy = "ascending", layout_config = { prompt_position = "top" } } }) end },
  { "nvim-neo-tree/neo-tree.nvim", cmd = "Neotree", dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" }, opts = { close_if_last_window = true } },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", opts = { ensure_installed = { "lua", "vim", "vimdoc", "python", "javascript", "typescript", "json", "yaml", "bash", "markdown" }, highlight = { enable = true }, indent = { enable = true } } },
  { "williamboman/mason.nvim", opts = {} },
  { "williamboman/mason-lspconfig.nvim", dependencies = { "mason.nvim", "neovim/nvim-lspconfig" }, opts = { ensure_installed = { "lua_ls", "pyright", "ts_ls", "bashls", "jsonls", "yamlls" } } },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" }, config = function()
      local cmp = require("cmp")
      cmp.setup({ snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end }, mapping = cmp.mapping.preset.insert({ ["<C-Space>"] = cmp.mapping.complete(), ["<CR>"] = cmp.mapping.confirm({ select = true }), ["<Tab>"] = cmp.mapping.select_next_item(), ["<S-Tab>"] = cmp.mapping.select_prev_item() }), sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "luasnip" }, { name = "path" }, { name = "buffer" } }) })
    end },
  { "lewis6991/gitsigns.nvim", opts = {} },
  { "stevearc/conform.nvim", opts = { format_on_save = { timeout_ms = 750, lsp_format = "fallback" } } },
  { "akinsho/toggleterm.nvim", version = "*", opts = { direction = "horizontal", size = 12 } },
  { "folke/which-key.nvim", event = "VeryLazy", opts = {}, config = function(_, opts) require("which-key").setup(opts); require("which-key").add({ { "<leader>f", group = "find" }, { "<leader>b", group = "buffers" }, { "<leader>g", group = "git" }, { "<leader>w", group = "workspace" }, { "<leader>c", group = "code" } }) end },
  { "folke/persistence.nvim", event = "BufReadPre", opts = { dir = vim.fn.stdpath("state") .. "/sessions/" } },
  { "glepnir/dashboard-nvim", event = "VimEnter", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function()
      require("dashboard").setup({ theme = "doom", config = { header = {
    "                                                                              ",
    "=================     ===============     ===============   ========  ========",
    "\\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //",
    "||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||",
    "|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||",
    "||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||",
    "|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||",
    "||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||",
    "|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||",
    "||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||",
    "||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||",
    "||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||",
    "||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||",
    "||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||",
    "||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||",
    "||   .=='    _-'          `-__\\._-'         `-_./__-'         `' |. /|  |   ||",
    "||.=='    _-'                                                     `' |  /==.||",
    "=='    _-'                        N E O V I M                         \\/   `==",
    "\\   _-'                                                                `-_   /",
    " `''                                                                      ``'  ",
  }, center = { { desc = "Find file", key = "f", action = "Telescope find_files" }, { desc = "Recent files", key = "r", action = "Telescope oldfiles" }, { desc = "Search text", key = "g", action = "Telescope live_grep" }, { desc = "File explorer", key = "e", action = "Neotree toggle" }, { desc = "Plugins", key = "l", action = "Lazy" }, { desc = "LSP tools", key = "m", action = "Mason" }, { desc = "Quit", key = "q", action = "qa" } }, footer = { "", "Doom Nvim loaded" } } })
      vim.cmd("hi! DashboardHeader guifg=#586268")
      vim.cmd("hi! DashboardCenter guifg=#51afef")
      vim.cmd("hi! DashboardDesc guifg=#51afef")
      vim.cmd("hi! DashboardKey guifg=#a9a1e1")
      vim.cmd("hi! DashboardCenterIcon guifg=#51afef")
      vim.cmd("hi! DashboardShortCut guifg=#a9a1e1")
      vim.cmd("hi! DashboardFooter guifg=#586268")
    end },
}






