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
}