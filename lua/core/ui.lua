-- UI Customization
local function setup_ui()
  -- Set colorscheme
  vim.cmd.colorscheme("rose-pine")

  -- Custom highlight groups
  local highlights = {
    -- Make the cursor line more subtle
    CursorLine = { bg = "#2a2a3a" },
    
    -- Make the sign column more subtle
    SignColumn = { bg = "NONE" },
    
    -- Make the line numbers more subtle
    LineNr = { fg = "#6c7086" },
    CursorLineNr = { fg = "#c0caf5", bold = true },
    
    -- Make the status line more beautiful
    StatusLine = { bg = "#1a1b26", fg = "#c0caf5" },
    StatusLineNC = { bg = "#1a1b26", fg = "#6c7086" },
    
    -- Make the tab line more beautiful
    TabLine = { bg = "#1a1b26", fg = "#6c7086" },
    TabLineFill = { bg = "#1a1b26" },
    TabLineSel = { bg = "#1a1b26", fg = "#c0caf5", bold = true },
    
    -- Make the winbar more beautiful
    WinBar = { bg = "#1a1b26", fg = "#c0caf5" },
    WinBarNC = { bg = "#1a1b26", fg = "#6c7086" },
    
    -- Make the floating windows more beautiful
    FloatBorder = { fg = "#c0caf5", bg = "#1a1b26" },
    FloatTitle = { fg = "#c0caf5", bg = "#1a1b26", bold = true },
    
    -- Make the popup menu more beautiful
    Pmenu = { bg = "#1a1b26", fg = "#c0caf5" },
    PmenuSel = { bg = "#2a2a3a", fg = "#c0caf5", bold = true },
    PmenuSbar = { bg = "#1a1b26" },
    PmenuThumb = { bg = "#2a2a3a" },
    
    -- Make the search highlight more beautiful
    Search = { bg = "#2a2a3a", fg = "#c0caf5" },
    IncSearch = { bg = "#2a2a3a", fg = "#c0caf5" },
    
    -- Make the visual selection more beautiful
    Visual = { bg = "#2a2a3a" },
    VisualNOS = { bg = "#2a2a3a" },
    
    -- Make the cursor more visible
    Cursor = { fg = "#c0caf5", bg = "#c0caf5" },
    lCursor = { fg = "#c0caf5", bg = "#c0caf5" },
    
    -- Make the diff highlights more beautiful
    DiffAdd = { bg = "#1a2a1a", fg = "#9ece6a" },
    DiffChange = { bg = "#1a1a2a", fg = "#7aa2f7" },
    DiffDelete = { bg = "#2a1a1a", fg = "#f7768e" },
    DiffText = { bg = "#1a1a2a", fg = "#7aa2f7", bold = true },
    
    -- Make the fold column more beautiful
    Folded = { bg = "#1a1b26", fg = "#6c7086" },
    FoldColumn = { bg = "NONE", fg = "#6c7086" },
    
    -- Make the non-text elements more beautiful
    NonText = { fg = "#6c7086" },
    SpecialKey = { fg = "#6c7086" },
    Whitespace = { fg = "#6c7086" },
    
    -- Make the error and warning signs more beautiful
    ErrorMsg = { fg = "#f7768e", bold = true },
    WarningMsg = { fg = "#e0af68", bold = true },
    
    -- Make the mode indicator more beautiful
    ModeMsg = { fg = "#c0caf5", bold = true },
    MoreMsg = { fg = "#c0caf5", bold = true },
    
    -- Make the question prompt more beautiful
    Question = { fg = "#c0caf5", bold = true },
    
    -- Make the directory names more beautiful
    Directory = { fg = "#7aa2f7", bold = true },
    
    -- Make the match parenthesis more beautiful
    MatchParen = { bg = "#2a2a3a", fg = "#c0caf5", bold = true },
    
    -- Make the spell checking more beautiful
    SpellBad = { fg = "#f7768e", undercurl = true },
    SpellCap = { fg = "#e0af68", undercurl = true },
    SpellLocal = { fg = "#7aa2f7", undercurl = true },
    SpellRare = { fg = "#bb9af7", undercurl = true },
  }

  -- Apply highlights
  for group, attrs in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, attrs)
  end

  -- Set UI options
  vim.opt.termguicolors = true
  vim.opt.cursorline = true
  vim.opt.cursorlineopt = "number"
  vim.opt.signcolumn = "yes:1"
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.scrolloff = 8
  vim.opt.sidescrolloff = 8
  vim.opt.wrap = false
  vim.opt.linebreak = true
  vim.opt.showbreak = "↪ "
  vim.opt.list = true
  vim.opt.listchars = {
    tab = "→ ",
    extends = "⟩",
    precedes = "⟨",
    trail = "·",
    nbsp = "␣",
    eol = "↲",
  }
  vim.opt.fillchars = {
    fold = " ",
    foldopen = "▼",
    foldclose = "▶",
    foldsep = " ",
    diff = "╱",
    eob = " ",
  }
  vim.opt.showmode = false
  vim.opt.ruler = false
  vim.opt.laststatus = 3
  vim.opt.winbar = "%=%m %f"
  vim.opt.winblend = 10
  vim.opt.pumblend = 10
  vim.opt.pumheight = 10
  vim.opt.pumwidth = 10
  vim.opt.wildoptions = "pum"
  
  -- Valid mouse options
  vim.opt.mouse = "a"
  vim.opt.mousemodel = "extend"
  vim.opt.mousescroll = "ver:1,hor:1"
  vim.opt.mousefocus = true
  vim.opt.mousehide = true
  vim.opt.mousemoveevent = true
  vim.opt.mousetime = 500
end

-- Call setup
setup_ui() 