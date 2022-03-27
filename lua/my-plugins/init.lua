local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end


vim.cmd "autocmd BufWritePost lua/my-plugins/*.lua PackerCompile" -- Auto compile when there are changes in plugins.lua
return require("packer").startup(function(use)
    -- Packer can manage itself as an optional plugin
    use "wbthomason/packer.nvim"

    use { 'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons'}, -- optional, for file icon 
        config = function() require'nvim-tree'.setup {} end
    }
    use {"ahmedkhalf/lsp-rooter.nvim"} -- with this nvim-tree will follow you
    use {"kyazdani42/nvim-web-devicons"}

    use { "folke/lua-dev.nvim" }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'


    use {
        "ahmedkhalf/project.nvim",
        config = function() require('project_nvim').setup() end,
        event = "ColorScheme"
    }
    -- Telescope
    use {"nvim-lua/plenary.nvim"}
    use {"nvim-telescope/telescope.nvim"}
    use {"nvim-telescope/telescope-fzy-native.nvim"}
    use {"nvim-telescope/telescope-project.nvim"}

    -- Color
    use {"christianchiarulli/nvcode-color-schemes.vim"}
    use { "catppuccin/nvim", as = "catppuccin" }

    use "elihunter173/dirbuf.nvim"

    use { 'j-hui/fidget.nvim', config = function() require"fidget".setup{} end }
    use { "nanozuki/tabby.nvim", config = function() require("tabby").setup() end, }
    use { "folke/which-key.nvim", config = function() require("which-key").setup { } end }

    -- treesitter
    use {
        "windwp/nvim-autopairs",
        event = "ColorScheme",
        config = function()
            require('nvim-autopairs').setup {
                enable_check_bracket_line = false,
                check_ts = true
            }
        end
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        --after = "impatient.nvim",
        config = function() require('my-plugins.treesitter') end
    }

    use { "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter", }
    use { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter", }
    use { "windwp/nvim-ts-autotag", after = "nvim-treesitter" }
    use { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" }

    --Neorg
    use {
        "nvim-neorg/neorg",
        ft = "norg",
        after = "nvim-treesitter", -- You may want to specify Telescope here as well
        config = function() require('my-plugins.neorg') end
    }

    --nvim cmp
    use {
        "hrsh7th/nvim-cmp",
        --event = { "InsertEnter", "CmdlineEnter" },
        config = function() require('my-plugins.cmp') end,
        requires = {
            { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
            { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
            { "hrsh7th/cmp-calc", after = "nvim-cmp" },
            { "hrsh7th/cmp-path", after = "nvim-cmp" },
            { "hrsh7th/cmp-cmdline", after = "nvim-cmp", }
        },
    }
    use 'hrsh7th/cmp-nvim-lsp'
    use {'rcarriga/nvim-notify',
        config = function() vim.notify = require("notify") end
    }


    use { "L3MON4D3/LuaSnip", module = "cmp", }

    if packer_bootstrap then
        require('packer').sync()
    end

end)
