return {
  -- Comment.nvim plugin
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup({
        toggler = {
          line = '<C-/>',  -- Keybinding to toggle line comments
          block = '<C-/>', -- Keybinding to toggle block comments
        },
        opleader = {
          line = '<C-/>',  -- Keybinding for operator-pending line comments
          block = '<C-/>', -- Keybinding for operator-pending block comments
        },
        mappings = {
          basic = true,
          extra = true,
        },
        -- This hook is important for JSX/TSX support
        pre_hook = function(ctx)
          -- Use 'ts_context_commentstring' for file types like TSX/JSX
          local U = require('Comment.utils')

          -- Determine whether to use linewise or blockwise
          local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'

          local location = nil
          if ctx.ctype == U.ctype.block then
            location = require('ts_context_commentstring.utils').get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require('ts_context_commentstring.utils').get_visual_start_location()
          end

          return require('ts_context_commentstring.internal').calculate_commentstring({
            key = type,
            location = location,
          })
        end,
      })
    end,
    keys = {
      { "<C-/>", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",            desc = "Toggle comment for current line or selection" },
      { "gc",    "<cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", desc = "Toggle comment for visual selection" },
    },
  },
  -- ts_context_commentstring plugin for JSX/TSX support
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require('nvim-treesitter.configs').setup({
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
    end,
  },
}

