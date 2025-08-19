--[[ return { ]]
--[[   { ]]
--[[     "okuuva/auto-save.nvim", ]]
--[[     cmd = "ASToggle",                       -- optional for lazy loading on command ]]
--[[     event = { "TextChanged", "FocusLost" }, -- "InsertLeave" optional for lazy loading on trigger events ]]
--[[     opts = { ]]
--[[       -- ]]
--[[       -- All of these are just the defaults ]]
--[[       -- ]]
--[[       enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it) ]]
--[[       execution_message = { ]]
--[[         enabled = true, ]]
--[[         message = function() -- message to print on save ]]
--[[           return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S")) ]]
--[[         end, ]]
--[[         dim = 0.18,                                    -- dim the color of message ]]
--[[         cleaning_interval = 1250,                      -- (milliseconds) automatically clean MsgArea after displaying message. See :h MsgArea ]]
--[[       }, ]]
--[[       trigger_events = {                               -- See :h events ]]
--[[         immediate_save = { "BufLeave", "FocusLost" },  -- vim events that trigger an immediate save ]]
--[[         defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after debounce_delay) ]]
--[[         cancel_defered_save = { "InsertEnter" },       -- vim events that cancel a pending deferred save ]]
--[[       }, ]]
--[[       -- function that takes the buffer handle and determines whether to save the current buffer or not ]]
--[[       -- return true: if buffer is ok to be saved ]]
--[[       -- return false: if it's not ok to be saved ]]
--[[       -- if set to nil then no specific condition is applied ]]
--[[       condition = nil, ]]
--[[       write_all_buffers = false, -- write all buffers when the current one meets condition ]]
--[[       -- Do not execute autocmds when saving ]]
--[[       -- This is what fixed the issues with undo/redo that I had ]]
--[[       -- https://github.com/okuuva/auto-save.n... ]]
--[[       noautocmd = false, ]]
--[[       lockmarks = false, -- lock marks when saving, see :h lockmarks for more details ]]
--[[       -- delay after which a pending save is executed (default 1000) ]]
--[[       debounce_delay = 5000, ]]
--[[       -- log debug messages to 'auto-save.log' file in neovim cache directory, set to true to enable ]]
--[[       debug = false, ]]
--[[     }, ]]
--[[   }, ]]
--[[]]
--[[]]
--[[ } ]]
--[[]]
--
return {
  -- Auto-save core functionality
  {
    "okuuva/auto-save.nvim",
    event = "BufReadPost", -- Load after file is opened
    dependencies = { "folke/which-key.nvim" }, -- Explicit dependency
    config = function()
      local autosave = require "auto-save"

      -- Enhanced configuration with debugging
      autosave.setup {
        enabled = true,
        execution_message = {
          enabled = true,
          message = "⚡ AutoSaved: " .. os.date "%X",
          dim = 0.3,
          cleaning_interval = 1750,
        },
        trigger_events = {
          immediate_save = { "BufLeave", "FocusLost", "VimLeavePre" },
          defer_save = { "TextChanged", "InsertLeave", "CursorHold" },
          cancel_defered_save = { "InsertEnter" },
        },
        condition = function(buf)
          local ok, utils = pcall(require, "auto-save.utils.data")
          return vim.bo[buf].modified -- Only if modified
            and vim.fn.expand "%" ~= "" -- Has filename
            and (
              not ok
              or utils.not_in( -- Check buffer type if utils available
                vim.bo[buf].buftype,
                { "terminal", "prompt", "nofile" }
              )
            )
        end,
        debounce_delay = 1500,
        noautocmd = false,
        debug = true, -- Logs to ~/.cache/nvim/auto-save.log
        callbacks = {
          before_saving = function() vim.notify("💾 Saving changes...", vim.log.levels.INFO) end,
          after_saving = function() vim.notify("✔ Saved successfully!", vim.log.levels.INFO) end,
        },
      }

      -- Status check command
      vim.api.nvim_create_user_command("AutoSaveStatus", function()
        local status = autosave.is_enabled() and "✅ ENABLED" or "❌ DISABLED"
        vim.notify(
          string.format("AutoSave Status: %s\nLast save: %s", status, autosave.last_save_time or "Never"),
          vim.log.levels.INFO
        )
      end, {})
    end,
  },

  -- Proper which-key integration
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require "which-key"
      wk.register {
        ["<leader>a"] = {
          name = "+auto-save",
          s = { "<cmd>ASToggle<cr>", "Toggle auto-save" },
          c = { "<cmd>AutoSaveStatus<cr>", "Check status" },
          e = {
            function() require("auto-save").enable() end,
            "Enable now",
          },
          d = {
            function() require("auto-save").disable() end,
            "Disable now",
          },
        },
      }

      -- Additional visual feedback
      wk.register {
        ["<leader>as"] = "Toggle auto-save", -- Single key description
      }
    end,
  },

  -- Optional: Statusline integration
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      local function auto_save_status() return require("auto-save").is_enabled() and "🔁" or "⏸️" end
      table.insert(opts.sections.lualine_x, { auto_save_status })
    end,
  },
}
