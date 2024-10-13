return {
  {
    "akinsho/toggleterm.nvim", -- The toggleterm plugin
    version = "*",             -- Use the latest version
    config = function()
      require("toggleterm").setup {
        -- General Options
        open_mapping = [[<C-`>]], -- Keybinding to open terminal
        direction = "horizontal", -- Open terminal in horizontal split (like VSCode)
        shade_filetypes = {},     -- Don't shade specific filetypes
        hide_numbers = true,      -- Hide line numbers in terminal
        insert_mappings = true,   -- Open terminal with insert mappings
        terminal_mappings = true, -- Enable terminal-specific mappings
        start_in_insert = true,   -- Start in insert mode when terminal opens
        close_on_exit = true,     -- Automatically close terminal when the process exits
        size = 15,                -- Height of the terminal in horizontal mode
      }

      -- Scroll in terminal (ensure you are in terminal mode)
      vim.api.nvim_set_keymap('t', '<C-Up>', [[<C-\><C-N>10j]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('t', '<C-Down>', [[<C-\><C-N>10k]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('t', '<C-S-Up>', [[<C-\><C-N>20j]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('t', '<C-S-Down>', [[<C-\><C-N>20k]], { noremap = true, silent = true })
    end,
    -- Keybindings: Ensure terminal can be opened with Ctrl + `
    keys = { { "<C-`>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" } },
  }
}
