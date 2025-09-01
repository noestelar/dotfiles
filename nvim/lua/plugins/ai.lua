return {
  {
    "greggh/claude-code.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("claude-code").setup()
      
      -- Function to send selected text to Claude Code
      local function send_to_claude()
        -- Copy selected text or current line to clipboard
        if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
          vim.cmd('normal! "+y')
        else
          vim.cmd('normal! "+yy')
        end
        
        -- Open Claude Code terminal
        require("claude-code").toggle()
        
        -- Show message to user
        vim.notify("Text copied to clipboard. Paste it in Claude Code terminal with Cmd+V", vim.log.levels.INFO)
      end
      
    end,
    keys = {
      { "<C-,>", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
      { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
      { "<leader>cC", "<cmd>ClaudeCodeContinue<cr>", desc = "Claude Code Continue" },
      { "<leader>cV", "<cmd>ClaudeCodeVerbose<cr>", desc = "Claude Code Verbose" },
      { 
        "<leader>cs", 
        function()
          local selected_text = ""
          
          -- Get selected text or current line
          local start_pos = vim.fn.getpos("'<")
          local end_pos = vim.fn.getpos("'>")
          
          if start_pos[2] ~= 0 and end_pos[2] ~= 0 then
            -- There's a visual selection
            local lines = vim.fn.getline(start_pos[2], end_pos[2])
            if type(lines) == "table" then
              selected_text = table.concat(lines, "\n")
            else
              selected_text = lines
            end
          else
            -- Use current line
            selected_text = vim.fn.getline('.')
          end
          
          -- Open Claude Code terminal
          require("claude-code").toggle()
          
          -- Wait a bit for terminal to open, then send text
          vim.defer_fn(function()
            local claude_bufnr = nil
            for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
              local bufname = vim.api.nvim_buf_get_name(bufnr)
              if string.match(bufname, "claude%-code") then
                claude_bufnr = bufnr
                break
              end
            end
            
            if claude_bufnr then
              local wins = vim.fn.win_findbuf(claude_bufnr)
              if #wins > 0 then
                vim.api.nvim_set_current_win(wins[1])
                vim.cmd("startinsert!")
                -- Send the text to terminal
                vim.api.nvim_feedkeys(selected_text .. "\n", "t", false)
              end
            end
          end, 200)
        end,
        desc = "Send to Claude Code",
        mode = { "n", "v" }
      },
    },
  },
}

