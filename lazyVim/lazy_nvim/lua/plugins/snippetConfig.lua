-- snippet-config.lua
-- Snippet support for a wide range of languages in LazyVim

return {
  -- Add LuaSnip snippet engine
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets", -- Prebuilt snippets for various languages
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load() -- Load all snippets
    end,
  },

  -- Completion engine with LuaSnip support
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip", -- LuaSnip completion source for nvim-cmp
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "luasnip" }, -- Enable LuaSnip as a completion source
      }))
    end,
  },

  -- Collection of snippets for various languages
  {
    "rafamadriz/friendly-snippets",
  },
}

