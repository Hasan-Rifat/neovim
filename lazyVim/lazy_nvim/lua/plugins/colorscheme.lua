-- colorscheme.lua
--return {
--  {
--    "sainnhe/sonokai", -- Sonokai colorscheme
--    priority = 1000,
--    config = function()
--      vim.g.sonokai_transparent_background = "1" -- Enable transparent background
--      vim.g.sonokai_enable_italic = "1"          -- Enable italics for keywords
--      vim.g.sonokai_style = "andromeda"          -- Choose the style (andromeda, atlantis, shiva, etc.)
--      vim.cmd.colorscheme("sonokai")             -- Set the colorscheme
--      -- cascadia code font ligature "editor.fontLigatures": "'ss01', 'ss02', 'ss03', 'ss19', 'ss20'"
--    end,
--  },
--}

return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = function(_, opts)
      opts.transparent = true
      opts.italic_comments = true  -- Enables italics for comments
      opts.italic_keywords = true  -- Enables italics for keywords
      opts.italic_functions = true -- Enables italics for functions
      opts.italic_variables = true -- Enables italics for variables
      opts.borderless_telescope = false
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cyberdream",
    },
  },

  -- modicator (auto color line number based on vim mode)
  {
    "mawkler/modicator.nvim",
    dependencies = "scottmckendry/cyberdream.nvim",
    init = function()
      -- These are required for Modicator to work
      vim.o.cursorline = false
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    opts = {},
  },
}
