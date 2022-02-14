local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end


vim.cmd "autocmd BufWritePost lua/my-plugins/init.lua PackerCompile" -- Auto compile when there are changes in plugins.lua
return require("packer").startup(function(use)
    -- Packer can manage itself as an optional plugin
    use "wbthomason/packer.nvim"
 

    use { 'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons'}, -- optional, for file icon 
        config = function() require'nvim-tree'.setup {} end
    }
    use {"ahmedkhalf/lsp-rooter.nvim"} -- with this nvim-tree will follow you
    use {"kyazdani42/nvim-web-devicons"}

    -- Telescope
    use {"nvim-lua/plenary.nvim"}
    use {"nvim-telescope/telescope.nvim"}
    use {"nvim-telescope/telescope-fzy-native.nvim"}
    use {"nvim-telescope/telescope-project.nvim"}

    -- Color
    use {"christianchiarulli/nvcode-color-schemes.vim"}
    use { "catppuccin/nvim", as = "catppuccin" }

    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    -- use {"windwp/nvim-ts-autotag", opt = true}
    -- use {'andymass/vim-matchup', opt = true}

    if packer_bootstrap then
    	require('packer').sync()
    end

end)


