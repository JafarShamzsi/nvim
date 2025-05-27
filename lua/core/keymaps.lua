vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Better window navigation
    map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", ...opts })
    map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", ...opts })
    map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", ...opts })
    map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", ...opts })

    -- Resize windows
    map("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize window up", ...opts })
    map("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize window down", ...opts })
    map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize window left", ...opts })
    map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize window right", ...opts })

    -- Better buffer navigation
    map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer", ...opts })
    map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer", ...opts })
    map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer", ...opts })

    -- Telescope
    map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find Files" })
    map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live Grep" })
    map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find Buffers" })
    map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help Tags" })
    map("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent Files" })

    -- NvimTree
    map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
    map("n", "<leader>o", ":NvimTreeFocus<CR>", { desc = "Focus File Explorer" })

    -- LSP
    map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
    map("n", "gr", vim.lsp.buf.references, { desc = "Go to References" })
    map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
    map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
    map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type Definition" })
    map("n", "<leader>ds", vim.lsp.buf.document_symbol, { desc = "Document Symbols" })
    map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { desc = "Workspace Symbols" })

    -- LLM.nvim
    map("n", "<leader>ll", ":Llm<CR>", { desc = "Open LLM Chat" })
    map("n", "<leader>lc", ":LlmContext<CR>", { desc = "Open LLM Context" })
    map("v", "<leader>ll", ":Llm<CR>", { desc = "Open LLM Chat with Selection" })
    map("v", "<leader>lc", ":LlmContext<CR>", { desc = "Open LLM Context with Selection" })

    -- Git
    map("n", "<leader>gg", ":LazyGit<CR>", { desc = "LazyGit" })
    map("n", "<leader>gb", ":GitBlameToggle<CR>", { desc = "Toggle Git Blame" })

    -- Terminal
    map("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle Terminal" })
    map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })

    -- Quickfix
    map("n", "<leader>co", ":copen<CR>", { desc = "Open Quickfix" })
    map("n", "<leader>cc", ":cclose<CR>", { desc = "Close Quickfix" })
    map("n", "<leader>cn", ":cnext<CR>", { desc = "Next Quickfix Item" })
    map("n", "<leader>cp", ":cprev<CR>", { desc = "Previous Quickfix Item" })

    -- Misc
    map("n", "<leader>w", ":w<CR>", { desc = "Save File" })
    map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
    map("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear Search Highlight" })
    map("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undo Tree" })
  end,
})
