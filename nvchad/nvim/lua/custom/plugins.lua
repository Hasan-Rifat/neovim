local plugins = {
    {
    "zbirenbaum/copilot.lua",
    lazy = false,
    event = "InsertEnter",
    cmd = "Copilot",
    build = ":Copilot auth",
    config = function()
      local opts = require("custom.configs.copilot").opts
      require("copilot").setup(opts)
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      require("dapui").setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require "custom.configs.dap"
      require("core.utils").load_mappings("dap")
    end
  },
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --     return require "custom.configs.null-ls"
  --   end,
  -- },
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.formatter"
    end
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "custom.configs.lint"
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "js-debug-adapter",
        "prettierd",
        "tailwindcss-language-server",
        "typescript-language-server"
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    'nvimtools/none-ls.nvim',
    event = "VeryLazy",
    opts = function ()
      return require "custom.configs.null-ls"
    end
  },
  -- auto close tags

  {
    "windwp/nvim-ts-autotag",
    ft = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

{
    "NvChad/nvim-colorizer.lua",
    config = function()
      require('colorizer').setup {
        filetypes = { "css", "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
        user_default_options = {
          tailwind = true,
          mode = "background",
        },
      }
    end
  },


  {
      "okuuva/auto-save.nvim",
      event = { "FocusLost", "InsertLeave", "TextChanged" }, -- triggers auto-save based on events
      config = function()
         require("auto-save").setup({
            enabled = true, -- enable auto-save
            execution_message = {
               enabled = true,
               message = function() -- custom save message
                  return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
               end,
               dim = 0.18, -- dim the message display color
               cleaning_interval = 1250, -- clean MsgArea after displaying the message
            },
            trigger_events = {
               immediate_save = { "FocusLost" }, -- save immediately on focus lost
               defer_save = { "InsertLeave", "TextChanged" }, -- deferred save on text change or insert leave
               cancel_defered_save = { "InsertEnter" }, -- cancel deferred save when entering insert mode
            },
            debounce_delay = 1000, -- auto-save after 1 second of inactivity
            condition = nil, -- no specific condition, save all buffers
            write_all_buffers = false, -- save only the current buffer
            noautocmd = false, -- execute autocmds when saving
            lockmarks = false, -- don't lock marks when saving
         })
      end
   }
--{
--    "nvim-treesitter/nvim-treesitter",
--    opts = function()
--      local opts = require "plugins.configs.treesitter"
--      opts.ensure_installed = {
--      "lua",
--      "html",
--      "css",
--      "javascript",
--      "typescript",
--      "tsx",
--      "typescriptreact",
--      "vue",
--      "scss",
--      "sass",
--      "css",
--      "jsx"
--      }
--      return opts
--    end,
--  }





}
return plugins
