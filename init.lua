-- Set PATH
vim.env.PATH = vim.env.PATH .. ':/opt/homebrew/bin:/usr/local/bin'

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load core configurations
require("core.options")
require("core.keymaps")
require("core.ui")

-- Load plugins
require("plugins.lazy")

-- Wait for plugins to load
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- Setup LSP
    require("lsp").setup()

    -- Verify plugins are loaded
    local required_plugins = {
      "nvim-tree",
      "telescope",
      "lualine",
      "gitsigns",
      "dingllm",
      "codecompanion"
    }

    for _, plugin in ipairs(required_plugins) do
      if not pcall(require, plugin) then
        vim.notify("Plugin " .. plugin .. " failed to load!", vim.log.levels.ERROR)
      end
    end
  end,
})

-- Music player using mpv
local function play_music(track)
  -- Kill any existing mpv (ignore errors)
  vim.fn.system("pkill -f mpv")

  -- Expand path & play track
  local full_path = vim.fn.expand(track)
  local result = vim.fn.jobstart({ "mpv", "--no-video", "--loop", full_path }, { detach = true })

  if result <= 0 then
    vim.notify("💥 Failed to start music!", vim.log.levels.ERROR)
  else
    vim.notify("🎶 Now playing: " .. full_path)
  end
end

-- 🎧 Lofi
vim.api.nvim_create_user_command("PlayLofi", function()
  play_music(vim.fn.expand("~/.config/nvim/assets/lofi.mp3"))
end, {})

-- 🌙 Nightcore
vim.api.nvim_create_user_command("PlayNightcore", function()
  play_music(vim.fn.expand("~/.config/nvim/assets/nightcore.mp3"))
end, {})

-- 🛑 Pause / Resume
vim.api.nvim_create_user_command("PauseMusic", function()
  vim.fn.system("pkill -STOP mpv")
end, {})

vim.api.nvim_create_user_command("PlayMusic", function()
  vim.fn.system("pkill -CONT mpv")
end, {})

-- 💀 Stop everything
vim.api.nvim_create_user_command("StopMusic", function()
  vim.fn.system("pkill mpv")
end, {})

-- Auto stop music when quitting nvim
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.fn.system("pkill mpv")
  end,
})

-- Pet commands
vim.api.nvim_create_user_command("Doggo", function()
  vim.cmd("PetsNew dog")
end, {})

vim.api.nvim_create_user_command("Catto", function()
  vim.cmd("PetsNew cat")
end, {})

vim.api.nvim_create_user_command("Bunbun", function()
  vim.cmd("PetsNew bunny")
end, {})

vim.api.nvim_create_user_command("Frogchamp", function()
  vim.cmd("PetsNew frog")
end, {})

vim.api.nvim_create_user_command("RMPets", function()
  vim.cmd("PetsKillAll")
end, {})
