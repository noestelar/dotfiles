return {
  -- Incremental rename
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
    keys = {
      { "<leader>cr", "<cmd>IncRename<cr>", desc = "Incremental Rename" },
    },
  },
  -- Multiple cursors
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      -- Add cursors above/below the main cursor
      vim.keymap.set({ "n", "v" }, "<C-Up>", function() mc.lineAddCursor(-1) end)
      vim.keymap.set({ "n", "v" }, "<C-Down>", function() mc.lineAddCursor(1) end)

      -- Add a cursor and jump to the next word under cursor
      vim.keymap.set({ "n", "v" }, "<C-n>", function() mc.matchAddCursor(1) end)

      -- Jump to the next word under cursor but do not add a cursor
      vim.keymap.set({ "n", "v" }, "<C-s>", function() mc.matchSkipCursor(1) end)

      -- Add all matches in the document
      vim.keymap.set({ "n", "v" }, "<leader>A", mc.matchAllAddCursors)

      -- Rotate the main cursor
      vim.keymap.set({ "n", "v" }, "<left>", mc.nextCursor)
      vim.keymap.set({ "n", "v" }, "<right>", mc.prevCursor)

      -- Delete the main cursor
      vim.keymap.set({ "n", "v" }, "<leader>x", mc.deleteCursor)

      -- Easy way to add and remove cursors using the main cursor
      vim.keymap.set({ "n", "v" }, "<C-q>", mc.toggleCursor)

      -- Clear all cursors
      vim.keymap.set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          -- Default <esc> handler
        end
      end)

      -- Align cursor columns
      vim.keymap.set("n", "<leader>a", mc.alignCursors)

      -- Split visual selections by regex
      vim.keymap.set("v", "S", mc.splitCursors)

      -- Append/insert for each line of visual selections
      vim.keymap.set("v", "I", mc.insertVisual)
      vim.keymap.set("v", "A", mc.appendVisual)

      -- Match new cursors within visual selections by regex
      vim.keymap.set("v", "M", mc.matchCursors)

      -- Rotate visual selection contents
      vim.keymap.set("v", "<leader>t", function() mc.transposeCursors(1) end)
      vim.keymap.set("v", "<leader>T", function() mc.transposeCursors(-1) end)
    end,
  },
}
