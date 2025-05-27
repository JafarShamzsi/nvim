vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Better window navigation
    map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", noremap = true, silent = true })
    map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", noremap = true, silent = true })
    map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", noremap = true, silent = true })
    map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", noremap = true, silent = true })

    -- Resize windows
    map("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize window up", noremap = true, silent = true })
    map("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize window down", noremap = true, silent = true })
    map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize window left", noremap = true, silent = true })
    map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize window right", noremap = true, silent = true })

    -- Better buffer navigation
    map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer", noremap = true, silent = true })
    map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer", noremap = true, silent = true })
    map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer", noremap = true, silent = true })

    -- Telescope
    map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find Files", noremap = true, silent = true })
    map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live Grep", noremap = true, silent = true })
    map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find Buffers", noremap = true, silent = true })
    map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help Tags", noremap = true, silent = true })
    map("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent Files", noremap = true, silent = true })

    -- NvimTree
    map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer", noremap = true, silent = true })
    map("n", "<leader>o", ":NvimTreeFocus<CR>", { desc = "Focus File Explorer", noremap = true, silent = true })

    -- LSP
    map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition", noremap = true, silent = true })
    map("n", "gr", vim.lsp.buf.references, { desc = "Go to References", noremap = true, silent = true })
    map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation", noremap = true, silent = true })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", noremap = true, silent = true })
    map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol", noremap = true, silent = true })
    map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type Definition", noremap = true, silent = true })
    map("n", "<leader>ds", vim.lsp.buf.document_symbol, { desc = "Document Symbols", noremap = true, silent = true })
    map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { desc = "Workspace Symbols", noremap = true, silent = true })

    -- LLM.nvim
    map("n", "<leader>ll", ":Llm<CR>", { desc = "Open LLM Chat", noremap = true, silent = true })
    map("n", "<leader>lc", ":LlmContext<CR>", { desc = "Open LLM Context", noremap = true, silent = true })
    map("v", "<leader>ll", ":Llm<CR>", { desc = "Open LLM Chat with Selection", noremap = true, silent = true })
    map("v", "<leader>lc", ":LlmContext<CR>", { desc = "Open LLM Context with Selection", noremap = true, silent = true })

    -- Git
    map("n", "<leader>gg", ":LazyGit<CR>", { desc = "LazyGit", noremap = true, silent = true })
    map("n", "<leader>gb", ":GitBlameToggle<CR>", { desc = "Toggle Git Blame", noremap = true, silent = true })

    -- Terminal
    map("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle Terminal", noremap = true, silent = true })
    map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode", noremap = true, silent = true })

    -- Quickfix
    map("n", "<leader>co", ":copen<CR>", { desc = "Open Quickfix", noremap = true, silent = true })
    map("n", "<leader>cc", ":cclose<CR>", { desc = "Close Quickfix", noremap = true, silent = true })
    map("n", "<leader>cn", ":cnext<CR>", { desc = "Next Quickfix Item", noremap = true, silent = true })
    map("n", "<leader>cp", ":cprev<CR>", { desc = "Previous Quickfix Item", noremap = true, silent = true })

    -- Misc
    map("n", "<leader>w", ":w<CR>", { desc = "Save File", noremap = true, silent = true })
    map("n", "<leader>q", ":q<CR>", { desc = "Quit", noremap = true, silent = true })
    map("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear Search Highlight", noremap = true, silent = true })
    map("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undo Tree", noremap = true, silent = true })
  end,
})
