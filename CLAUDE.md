# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a Neovim configuration featuring a unique "cursed" approach that combines practical development tools with entertainment features like music playback and terminal pets. The config is fully modular using Lazy.nvim for plugin management.

**Core Structure:**
- `init.lua` - Main entry point with bootstrapping, LSP setup verification, music player commands, and pet commands
- `lua/core/` - Core Neovim configurations (options, keymaps, UI settings)
- `lua/plugins/` - Plugin configurations managed by Lazy.nvim
- `lua/lsp/` - LSP setup and configuration
- `assets/` - Music files for the entertainment features

**Key Architectural Decisions:**
- Uses Lazy.nvim for all plugin management with lazy loading
- LSP setup is deferred until after plugins load via VeryLazy autocmd
- All plugins are configured inline within lazy.lua rather than separate files
- Music player functionality uses mpv as an external process
- Transparent theme setup with custom highlight overrides

## Plugin Ecosystem

**Essential Plugins:**
- Telescope (file finder, live grep) 
- nvim-tree (file explorer)
- nvim-lspconfig + Mason (LSP management)
- nvim-cmp (completion engine)
- gitsigns (Git integration)
- codecompanion (Claude AI integration)
- dingllm (LLM integration)

**Entertainment Features:**
- pets.nvim (terminal pets: `:Doggo`, `:Catto`, `:Bunbun`, `:Frogchamp`)
- Built-in music player using mpv (`:PlayLofi`, `:PlayNightcore`, `:StopMusic`)

## Development Commands

**No traditional build/test commands** - this is a Neovim configuration, not a software project.

**Configuration Management:**
- Edit main config: `:e ~/.config/nvim/init.lua`
- Restart Neovim to reload changes
- Use `:Lazy` to manage plugins
- Use `:Mason` to manage LSP servers and tools

**Key Leader Mappings:**
- `<leader>` = space key
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Live grep
- `<leader>e` - Toggle file explorer
- `<leader>ll` - Open LLM chat
- `<leader>?` - Show keybind cheatsheet

## LSP Configuration

LSP setup uses Mason for automatic installation of language servers. Key servers configured:
- TypeScript: ts_ls (note: updated from deprecated tsserver)
- Python: pyright
- Go: gopls
- Rust: rust_analyzer
- C/C++: clangd
- Lua: lua_ls
- Haskell: hls

All LSP servers are auto-installed via Mason when first opening relevant files.

**Important:** The configuration includes fixes for Neovim 0.11.0 compatibility issues:
- LSP change tracking errors: Patches `vim.lsp._changetracking.send_changes` to handle buffer state initialization issues
- Formatting/linting: Uses `nvimtools/none-ls.nvim` instead of deprecated `jose-elias-alvarez/null-ls.nvim` to fix BufWritePre autocommand errors

## AI Integration

Two AI systems are configured:
- **codecompanion**: Claude AI integration requiring ANTHROPIC_API_KEY environment variable
- **dingllm**: General LLM integration through Ollama keymaps

AI features require proper API keys to be set in shell environment.

## Music Player Integration

Custom mpv-based music player with commands:
- `:PlayLofi` / `:PlayNightcore` - Play specific tracks
- `:PauseMusic` / `:PlayMusic` - Pause/resume
- `:StopMusic` - Stop playback
- Music auto-stops when exiting Neovim

Requires `mpv` installed and music files in `~/.config/nvim/assets/`