local config_dir = vim.fn.stdpath("config")
local background_file = config_dir .. "/background_state"

local function load_background_state()
  local file = io.open(background_file, "r")
  if file then
    local state = file:read("*line")
    file:close()
    return state == "true"
  end
  return true -- default to enabled
end

local function save_background_state(enabled)
  local file = io.open(background_file, "w")
  if file then
    file:write(tostring(enabled))
    file:close()
  end
end

vim.g.background_enabled = load_background_state()

-- Override the toggle function to save state
_G.toggle_background_with_persistence = function()
  vim.g.background_enabled = not vim.g.background_enabled
  save_background_state(vim.g.background_enabled)
  local current_colorscheme = vim.g.colors_name or "gruvbox"
  
  -- Reconfigure the current colorscheme with new transparency settings
  if current_colorscheme == "gruvbox" then
    local args = {}
    if not vim.g.background_enabled then
      args.transparent_mode = "both"
    end
    require("gruvbox").setup(args)
  elseif current_colorscheme == "tokyonight" then
    local args = {}
    if not vim.g.background_enabled then
      args.transparent = true
    end
    require("tokyonight").setup(args)
  elseif current_colorscheme == "rose-pine" then
    local args = {}
    if not vim.g.background_enabled then
      args.disable_background = true
    end
    require("rose-pine").setup(args)
  end
  
  -- Reapply the same colorscheme
  vim.cmd("colorscheme " .. current_colorscheme)
end