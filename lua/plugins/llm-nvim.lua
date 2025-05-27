return {
  "David-Kunz/llm.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("llm").setup({
      backend = "openai",
      openai = {
        api_key = "ollama",
        base_url = "http://localhost:11434/v1",
        chat_completions_url = "/chat/completions"
      },
      model = "codellama:7b-instruct",
      -- UI Configuration
      ui = {
        -- Use a floating window for the chat
        floating = true,
        -- Position the window in the center
        position = "center",
        -- Set a reasonable size
        width = 0.8,
        height = 0.8,
        -- Use a nice border
        border = "rounded",
        -- Use a nice title
        title = "LLM Chat",
        -- Use a nice title position
        title_pos = "center",
      },
      -- Chat Configuration
      chat = {
        -- Enable markdown rendering
        markdown = true,
        -- Enable syntax highlighting
        syntax = true,
        -- Enable line wrapping
        wrap = true,
        -- Enable line numbers
        number = false,
        -- Enable relative line numbers
        relativenumber = false,
        -- Enable cursor line
        cursorline = true,
        -- Enable sign column
        signcolumn = "no",
        -- Enable fold column
        foldcolumn = "0",
        -- Enable list
        list = false,
        -- Enable spell checking
        spell = false,
        -- Enable word wrap
        wrap = true,
        -- Enable line break
        linebreak = true,
        -- Enable show break
        showbreak = "↪ ",
      },
      -- Context Configuration
      context = {
        -- Enable markdown rendering
        markdown = true,
        -- Enable syntax highlighting
        syntax = true,
        -- Enable line wrapping
        wrap = true,
        -- Enable line numbers
        number = true,
        -- Enable relative line numbers
        relativenumber = true,
        -- Enable cursor line
        cursorline = true,
        -- Enable sign column
        signcolumn = "yes",
        -- Enable fold column
        foldcolumn = "1",
        -- Enable list
        list = true,
        -- Enable spell checking
        spell = false,
        -- Enable word wrap
        wrap = true,
        -- Enable line break
        linebreak = true,
        -- Enable show break
        showbreak = "↪ ",
      },
    })
  end,
}
