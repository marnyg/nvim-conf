require("nvim-tree").setup({})
require("nvim-surround").setup({})
require("project_nvim").setup({})
require("tabby").setup({})
require("which-key").setup({})
require("fidget").setup({})
vim.notify = require("notify")
require("my.plugins.neorg")
require("my.plugins.cmp")
require("my.plugins.treesitter")
require("my.plugins.telescope")

-- 	use({ "kyazdani42/nvim-web-devicons" })
-- 
-- 	use("elihunter173/dirbuf.nvim")
-- 
-- 
-- 	-- treesitter
-- 	use({
-- 		"windwp/nvim-autopairs",
-- 		event = "ColorScheme",
-- 		config = function()
-- 			require("nvim-autopairs").setup({
-- 				enable_check_bracket_line = false,
-- 				check_ts = true,
-- 			})
-- 		end,
-- 	})
-- 
-- 
-- 	use({ "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" })
-- 	use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })
-- 	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })
-- 	use({ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" })
-- 
-- 
-- 	--nvim cmp
-- 	use({
-- 		"hrsh7th/nvim-cmp",
-- 		--event = { "InsertEnter", "CmdlineEnter" },
-- 		config = function()
-- 			require("my-plugins.cmp")
-- 		end,
-- 		requires = {
-- 			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
-- 			{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
-- 			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
-- 			{ "hrsh7th/cmp-calc", after = "nvim-cmp" },
-- 			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
-- 			{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
-- 		},
-- 	})
-- 	use("hrsh7th/cmp-nvim-lsp")
-- 	use({
-- 		"rcarriga/nvim-notify",
-- 		config = function()
-- 			vim.notify = require("notify")
-- 		end,
-- 	})
-- 
-- 	use({ "L3MON4D3/LuaSnip", module = "cmp" })
-- 
