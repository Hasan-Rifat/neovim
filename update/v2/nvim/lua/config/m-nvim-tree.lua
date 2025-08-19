-- ~/.config/nvim/lua/plugins/nvim-tree.lua
return {
	"nvim-tree/nvim-tree.lua",
	opts = function(_, opts)
		-- Extend Nvim-Tree default keymaps
		local tree_cb = require("nvim-tree.config").nvim_tree_callback

		opts.view.mappings.list = vim.list_extend(opts.view.mappings.list, {
			{ key = "y", cb = require("nvim-tree.api").node.copy.node },
			{ key = "p", cb = require("nvim-tree.api").node.paste.node },
		})
	end,
}
