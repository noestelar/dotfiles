return {
  "nvim-tree/nvim-web-devicons",
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣧⠀⢀⡏⢸⡇⠀⠀⢠⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣀⣤⠤⣤⣄⣀⠀⢀⣠⡴⠶⠛⠛⠉⠉⠉⠉⠉⠉⠛⠛⠓⠲⠶⢾⣥⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣠⡴⠟⠋⠀⠀⠀⠈⣹⡿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠳⢦⣄⡀⠀⠀⠀⣀⣀⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⣠⡾⠋⠀⠀⠀⠀⠀⣠⡞⠁⠀⣀⣤⠤⠶⠖⠒⠚⠓⠒⠲⠶⢤⡾⠿⣷⠄⠀⠀⠀⠀⠀⠀⠀⢿⣿⣦⠶⠛⠉⠁⠀⠀⠉⠛⢶⣄⡀⠀⠀⠀⠀⠀⠀⠀
⢰⠏⠀⠀⠀⠀⢀⣴⣾⠋⠠⠾⠿⠯⠤⠴⠶⠦⠶⠄⠀⠦⢤⣤⣤⣿⣶⣛⣶⣄⠀⠀⠀⠀⠀⠀⠀⣿⣿⢷⣤⡀⠀⠀⠀⠀⠀⠀⠈⠛⢦⡀⠀⠀⠀⠀⠀
⣸⠀⠀⠀⣠⣾⣿⡿⠃⠀⠀⠀⠀⠀⠀⢠⡆⠀⠀⠀⠀⠀⠀⠀⢰⡀⠀⠈⠉⠉⠁⠀⠀⠀⠀⠀⠀⣿⡈⠀⠘⠻⢷⣤⡀⠀⠀⠀⠀⠀⠀⠹⡆⠀⠀⠀⠀
⢹⡆⠀⣾⣻⣹⣿⠁⠀⠀⠀⠀⠀⠀⠀⡿⠀⠀⠀⠀⠀⠀⠀⠀⠘⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⢀⣤⡀⠀⠀⠙⠿⢷⣄⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀
⠨⣷⠀⠘⢿⣿⠃⠀⠀⠀⠀⠀⠀⠀⢸⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡟⠘⢿⣿⣆⡀⠀⠀⠈⠝⣷⡄⠀⠀⢠⡏⠀⠀⠀⠀
⠀⢹⣇⠀⢀⡟⠀⠀⠀⠀⠀⢸⠃⢀⣾⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⢸⣧⠀⠀⠀⠀⠀⣤⠀⠀⠀⢸⡇⠀⠘⣿⢻⣆⠤⠀⣀⣶⡿⠃⠀⠀⣼⠃⠀⠀⠀⠀
⠀⠀⢻⡄⣼⠁⠀⠀⠀⠀⢀⣿⡤⣾⣿⣷⣶⡆⠀⣀⣴⡿⠟⠰⠶⣾⠾⣷⢤⣄⡀⠀⣿⠀⠀⠀⢸⡏⠀⠀⢻⡇⠹⣿⣤⡿⠋⠀⠀⠀⣰⠏⠀⠀⠀⠀⠀
⠀⠀⠀⢿⡏⠀⠀⠀⠀⠐⢻⡇⣸⠃⣿⠈⢙⣿⣾⣟⠋⠀⠀⠀⠀⡿⠀⠘⣧⠈⠙⠶⢻⠀⠀⠀⠘⠷⣴⣶⡿⠟⠀⠀⠉⠀⠀⠀⠀⢠⡟⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⢸⢣⡏⠀⣸⣶⡿⠛⠉⠻⢿⣦⡀⠀⢰⡇⠀⠀⠸⣆⠀⠀⣼⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⢠⡟⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢸⠀⠀⠀⠀⠀⣤⣸⣿⡀⠀⠙⣏⠀⢰⡇⠀⠀⢹⡇⠀⣼⠀⠀⠀⠀⠹⣆⠀⣿⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⢠⡟⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢸⡇⠀⠀⠀⠀⠘⢻⣟⠛⡿⠿⣿⣿⣟⡛⠒⠒⠛⠛⠻⢷⣺⣧⣴⣶⣶⣿⣦⣯⣠⡤⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⢀⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠨⣷⠀⠀⣄⠀⠀⢸⣯⠀⣷⠠⠎⠾⣽⠛⠀⠀⠀⠀⠚⠛⣿⣁⣼⣹⡀⣸⢹⣿⠇⠀⠀⠀⠀⠀⣸⡇⠀⠀⠀⠀⠀⣼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢀⣼⣧⡀⢻⣦⡀⠘⣿⡿⣞⣿⠛⠛⠛⠀⠀⠀⠀⠀⠀⠀⠹⠶⢶⡶⣼⠯⣾⠁⠀⠀⣠⡾⠀⢠⡿⡇⠀⠀⠀⠀⢰⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢀⣴⠟⠁⠈⣻⣾⣿⣷⣤⡹⣷⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠁⣴⠃⠀⣠⡾⣿⠃⣰⠟⢠⡇⠀⠀⠀⠀⠀⠻⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀
⢰⡟⠁⠐⠛⡿⠋⠉⢀⡴⠋⣿⠻⣧⡀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣷⠶⡿⣯⡸⠿⠞⠁⠀⠸⢧⣄⣀⣀⠀⠀⠀⠈⠻⣦⡀⠀⠀⠀⠀⠀⠀
⠸⢷⡀⠀⢸⡇⠀⠀⠻⣦⣀⠹⣆⠈⠛⠶⣤⣀⠀⠈⠛⠀⠀⠀⠀⢀⣠⣴⣿⣿⠁⢰⠇⠈⣻⡄⠀⠀⠀⠀⠀⠀⢉⠉⣹⡿⣿⠲⠶⠀⠹⣦⠀⠀⠀⠀⠀
⠀⠈⢷⣄⠀⢷⡀⠀⠀⠀⠙⠳⢿⣦⠀⠀⠀⠉⠙⠓⠶⣦⡴⣶⠟⠻⣷⠟⠁⢸⣷⣯⢶⡿⠙⠷⢶⣄⠀⠀⠀⠀⣾⡆⢻⡄⢸⡇⠀⠀⣠⡟⠀⠀⠀⠀⠀
⠀⠀⠀⠙⢷⣌⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡾⠁⢠⣿⡄⣠⡶⠶⣤⣘⡏⢀⡾⠁⠀⠀⠀⠘⣧⠀⠀⠀⠘⢷⠾⣷⣾⠁⢀⣴⠏⠀⠀⢀⡀⠀⠀
⠀⠀⠀⠀⠀⠈⠙⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣷⠀⢸⣡⣿⡟⠀⣀⠘⣿⣧⡾⠁⠀⠀⠀⠀⠀⢹⣷⡄⠀⠀⠀⢠⡾⣃⣴⠞⠁⠀⠀⠀⢸⡏⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣇⢨⡯⣿⠟⠿⣯⠀⣹⠈⡇⢠⡄⠀⠀⠀⠀⠘⣇⢻⣆⣀⣴⣿⣿⣹⡆⠀⠀⠀⠀⢀⣾⠇⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣾⠁⠙⣧⡀⣠⡾⠋⠀⣧⡀⣷⠀⠀⠀⠀⠀⢻⣼⣿⣿⣿⠿⠿⠻⣷⣤⡀⢠⡶⠟⠉⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠿⣦⡀⠈⡿⣿⢀⣴⡿⠻⠟⢿⡆⠀⠀⠀⠀⠘⣿⢽⡇⣿⠃⠀⠀⠀⣻⣷⢿⡇⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡿⠂⠉⢿⣶⡇⣿⠟⠉⠁⠀⠀⢸⣷⠀⠀⠀⠀⠀⢿⣿⢱⡿⠀⠀⠀⠀⢹⣷⣾⠇⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠈⢹⡇⣿⠄⠀⠀⠀⠀⠸⢿⡆⠀⠀⠀⠀⠸⣧⣿⠘⠀⠀⠀⠀⠀⣿⠋⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣷⣧⣀⠀⢸⣷⢹⣆⡆⠀⠀⠀⠀⢸⣷⠀⠀⠀⠀⠀⣿⣔⠀⠀⠀⠀⠀⠀⣿⢶⣄⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⢾⣥⣬⣿⣷⣝⢷⣥⣄⣤⣤⠾⢿⡆⠀⠀⠀⠀⢸⡟⠀⠀⠀⠀⠀⣾⡟⠈⠁⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢹⡏⠻⣯⣥⣭⣭⣶⣶⣿⣻⣷⠀⠀⠀⠀⠈⣷⢀⠀⣀⣤⣾⠿⣇⠀⠀⠀⠀⢀⣀⡀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡄⠀⠀⠀⠀⢻⡈⠉⠉⢻⡄⠀⠀⠀⠀⢻⢿⣿⣿⠟⠋⠀⢻⣴⡿⣧⣴⠟⠋⠁
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣷⠀⠀⠀⠀⠘⣧⠀⠀⠘⣇⠀⠀⠀⠀⢸⡟⣷⡏⠀⠀⠀⠀⠋⠀⢻⣆⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣆⠀⠀⠀⣠⣿⡆⠀⠀⣿⠀⠀⠀⠀⠀⣧⢸⡇⠀⠀⠀⠀⠀⠀⠀⠙⣷⡄⠀
   ]],
        },
      },
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      vim.cmd("colorscheme rose-pine")
    end,
    opts = {
      variant = "main", -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      bold_vert_split = false,
      dim_inactive_windows = false,
      terminal_colors = true,
      groups = {
        background = "base",
        background_nc = "_experimental_ignore",
        panel = "surface1",
        border = "highlight_med",
        comment = "muted",
        link = "iris",
        punctuation = "subtle",

        error = "love",
        hint = "iris",
        info = "foam",
        warn = "gold",

        headings = {
          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        }
      },
      highlight_groups = {
        -- Comment = { fg = "foam" },
        -- VertSplit = { fg = "muted", bg = "muted" },
      }
    }
  },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      vim.keymap.set({ "n", "x" }, "<ScrollWheelUp>", function()
        mouse_scrolled = true
        return "<ScrollWheelUp>"
      end, { expr = true, silent = true })
      vim.keymap.set({ "n", "x" }, "<ScrollWheelDown>", function()
        mouse_scrolled = true
        return "<ScrollWheelDown>"
      end, { expr = true, silent = true })

      local animate = require("mini.animate")
      return {
        cursor = {
          enable = true,
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        },
        scroll = {
          enable = true,
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          hooks = {
            pre = function()
              if mouse_scrolled then
                mouse_scrolled = false
                return true
              end
            end,
          },
        },
      }
    end,
  },
}
