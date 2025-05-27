vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Function to create and display keybind cheatsheet
    local function show_keybind_cheatsheet()
      local keymaps = {
        { "Window Navigation", {
          { "<C-h>", "Go to left window" },
          { "<C-j>", "Go to lower window" },
          { "<C-k>", "Go to upper window" },
          { "<C-l>", "Go to right window" },
          { "<C-Up>", "Resize window up" },
          { "<C-Down>", "Resize window down" },
          { "<C-Left>", "Resize window left" },
          { "<C-Right>", "Resize window right" },
        }},
        { "Buffer Navigation", {
          { "<S-h>", "Previous buffer" },
          { "<S-l>", "Next buffer" },
          { "<leader>bd", "Delete buffer" },
        }},
        { "Telescope", {
          { "<leader>ff", "Find Files" },
          { "<leader>fg", "Live Grep" },
          { "<leader>fb", "Find Buffers" },
          { "<leader>fh", "Help Tags" },
          { "<leader>fr", "Recent Files" },
        }},
        { "File Explorer", {
          { "<leader>e", "Toggle File Explorer" },
          { "<leader>o", "Focus File Explorer" },
        }},
        { "LSP", {
          { "gd", "Go to Definition" },
          { "gr", "Go to References" },
          { "K", "Hover Documentation" },
          { "<leader>ca", "Code Action" },
          { "<leader>rn", "Rename Symbol" },
          { "<leader>D", "Type Definition" },
          { "<leader>ds", "Document Symbols" },
          { "<leader>ws", "Workspace Symbols" },
        }},
        { "AI Assistant", {
          { "<leader>ll", "Open LLM Chat" },
          { "<leader>lc", "Open LLM Context" },
          { "<leader>ll (visual)", "Open LLM Chat with Selection" },
          { "<leader>lc (visual)", "Open LLM Context with Selection" },
        }},
        { "Git", {
          { "<leader>gg", "LazyGit" },
          { "<leader>gb", "Toggle Git Blame" },
        }},
        { "Terminal", {
          { "<leader>tt", "Toggle Terminal" },
          { "<Esc> (in terminal)", "Exit Terminal Mode" },
        }},
        { "Quickfix", {
          { "<leader>co", "Open Quickfix" },
          { "<leader>cc", "Close Quickfix" },
          { "<leader>cn", "Next Quickfix Item" },
          { "<leader>cp", "Previous Quickfix Item" },
        }},
        { "Misc", {
          { "<leader>w", "Save File" },
          { "<leader>q", "Quit" },
          { "<leader>h", "Clear Search Highlight" },
          { "<leader>u", "Toggle Undo Tree" },
        }},
      }

      -- Create a new buffer
      local buf = vim.api.nvim_create_buf(false, true)
      local width = vim.api.nvim_get_option("columns")
      local height = vim.api.nvim_get_option("lines")
      local win_height = math.ceil(height * 0.8)
      local win_width = math.ceil(width * 0.8)
      local row = math.ceil((height - win_height) / 2)
      local col = math.ceil((width - win_width) / 2)

      -- Create the window
      local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        row = row,
        col = col,
        width = win_width,
        height = win_height,
        style = "minimal",
        border = "rounded",
        title = " Keybind Cheatsheet ",
        title_pos = "center",
      })

      -- Set buffer options
      vim.api.nvim_buf_set_option(buf, "modifiable", true)
      vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
      vim.api.nvim_buf_set_option(buf, "swapfile", false)
      vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
      vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

      -- Add content
      local lines = {}
      for _, section in ipairs(keymaps) do
        table.insert(lines, string.format("# %s", section[1]))
        table.insert(lines, "")
        for _, keymap in ipairs(section[2]) do
          table.insert(lines, string.format("`%s` - %s", keymap[1], keymap[2]))
        end
        table.insert(lines, "")
      end

      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

      -- Set buffer options after content
      vim.api.nvim_buf_set_option(buf, "modifiable", false)
      vim.api.nvim_buf_set_option(buf, "modified", false)
      vim.api.nvim_buf_set_option(buf, "readonly", true)
      vim.api.nvim_buf_set_option(buf, "wrap", true)
      vim.api.nvim_buf_set_option(buf, "linebreak", true)
      vim.api.nvim_buf_set_option(buf, "number", false)
      vim.api.nvim_buf_set_option(buf, "relativenumber", false)
      vim.api.nvim_buf_set_option(buf, "cursorline", true)
      vim.api.nvim_buf_set_option(buf, "signcolumn", "no")
      vim.api.nvim_buf_set_option(buf, "foldcolumn", "0")
      vim.api.nvim_buf_set_option(buf, "list", false)
      vim.api.nvim_buf_set_option(buf, "spell", false)

      -- Set window options
      vim.api.nvim_win_set_option(win, "wrap", true)
      vim.api.nvim_win_set_option(win, "linebreak", true)
      vim.api.nvim_win_set_option(win, "number", false)
      vim.api.nvim_win_set_option(win, "relativenumber", false)
      vim.api.nvim_win_set_option(win, "cursorline", true)
      vim.api.nvim_win_set_option(win, "signcolumn", "no")
      vim.api.nvim_win_set_option(win, "foldcolumn", "0")
      vim.api.nvim_win_set_option(win, "list", false)
      vim.api.nvim_win_set_option(win, "spell", false)

      -- Add keybind to close the window
      vim.keymap.set("n", "q", function()
        vim.api.nvim_win_close(win, true)
      end, { buffer = buf, noremap = true, silent = true })
    end

    -- Add keybind to show cheatsheet
    map("n", "<leader>?", show_keybind_cheatsheet, { desc = "Show Keybind Cheatsheet", noremap = true, silent = true })

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

    -- Ollama
    local ollama = require("plugins.ollama")
    map("n", "<leader>ll", function() ollama.invoke_ollama(true) end, { desc = "Ollama Code Generation", noremap = true, silent = true })
    map("n", "<leader>lh", function() ollama.invoke_ollama(false) end, { desc = "Ollama Help", noremap = true, silent = true })
    map("v", "<leader>ll", function() ollama.invoke_ollama(true) end, { desc = "Ollama Code Generation with Selection", noremap = true, silent = true })
    map("v", "<leader>lh", function() ollama.invoke_ollama(false) end, { desc = "Ollama Help with Selection", noremap = true, silent = true })

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
