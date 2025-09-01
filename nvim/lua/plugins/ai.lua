return {
  {
    "greggh/claude-code.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("claude-code").setup()
    end,
    keys = {
      { "<C-,>", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
      { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
      { "<leader>cC", "<cmd>ClaudeCodeContinue<cr>", desc = "Claude Code Continue" },
      { "<leader>cV", "<cmd>ClaudeCodeVerbose<cr>", desc = "Claude Code Verbose" },
    },
  },
}

