# Neovim Setup Backup

Portable backup of the current Doom One-inspired Neovim configuration.

## Install on Windows

1. Install [Neovim](https://neovim.io/) 0.10 or newer and Git.
2. Close every Neovim instance.
3. Clone this repository:

```powershell
git clone git@github.com:JafarShamzsi/nvim.git "$HOME\nvim-backup"
```

4. Back up any existing configuration, then copy this one into place:

```powershell
if (Test-Path "$HOME\.config\nvim") { Move-Item "$HOME\.config\nvim" "$HOME\.config\nvim.backup-$(Get-Date -Format yyyyMMdd-HHmmss)" }
Copy-Item "$HOME\nvim-backup\nvim" "$HOME\.config\nvim" -Recurse
```

5. Start Neovim and allow Lazy.nvim to install plugins:

```powershell
nvim
```


## Install on Linux

1. Install Neovim 0.10 or newer, Git, and a Nerd Font through your distribution's package manager.
2. Clone this repository:

```bash
git clone git@github.com:JafarShamzsi/nvim.git ~/nvim-backup
```

3. Back up any existing Neovim configuration, then install this one:

```bash
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.backup-$(date +%Y%m%d-%H%M%S)
mkdir -p ~/.config
cp -R ~/nvim-backup/nvim ~/.config/nvim
```

4. Start Neovim and allow Lazy.nvim to install plugins:

```bash
nvim
```
## Included

- Official Doom Nvim dashboard banner and Doom One palette
- Telescope, Neo-tree, Treesitter, LSP/Mason, completion, Git signs
- Bufferline, sessions, formatting, integrated terminal, and Which-Key

## Key bindings

- `Space f f`: find files
- `Space f r`: recent files
- `Space f g`: search text
- `Space e`: file explorer
- `Space b b`: buffers
- `Space t t`: terminal
- `gd`, `gr`, `K`: LSP navigation

## Updating

```powershell
cd "$HOME\nvim-backup"
git pull
Copy-Item .\nvim "$HOME\.config\nvim" -Recurse -Force
```

