local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
    local plugin_prefix = fn.stdpath("data") .. "/site/pack/packer/opt/"

    local plugin_path = plugin_prefix .. plugin .. "/"
    --	print('test '..plugin_path)
    local ok, err, code = os.rename(plugin_path, plugin_path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    --	print(ok, err, code)
    if ok then vim.cmd("packadd " .. plugin) end
    return ok, err, code
end

--vim.cmd "autocmd BufWritePost plugins/init.lua PackerCompile" -- Auto compile when there are changes in plugins.lua
   

return require("packer").startup(function(use)
    -- Packer can manage itself as an optional plugin
    use "wbthomason/packer.nvim"
 

    use {"kyazdani42/nvim-tree.lua", opt = true}
    use {"ahmedkhalf/lsp-rooter.nvim", opt = true} -- with this nvim-tree will follow you
    use {"kyazdani42/nvim-web-devicons", opt = true}

    -- Telescope
    use {"nvim-lua/popup.nvim", opt = true}
    use {"nvim-lua/plenary.nvim", opt = true}
    use {"nvim-telescope/telescope.nvim", opt = true}
    use {"nvim-telescope/telescope-fzy-native.nvim", opt = true}
    use {"nvim-telescope/telescope-project.nvim", opt = true}

    -- Color
    use {"christianchiarulli/nvcode-color-schemes.vim", opt = true}

    -- Status Line and Bufferline
    use {"glepnir/galaxyline.nvim", opt = true}
    use {"romgrk/barbar.nvim", opt = true}

    require_plugin("popup.nvim")
    require_plugin("plenary.nvim")
    require_plugin("telescope.nvim")
    require_plugin('telescope-project.nvim')

    require_plugin("nvim-tree.lua")
    require_plugin('lsp-rooter.nvim')
    require_plugin("nvim-web-devicons")


   
    -- TODO remove when open on dir is supported by nvimtree
-- Treesitter
    -- use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    -- use {"windwp/nvim-ts-autotag", opt = true}
    -- use {'andymass/vim-matchup', opt = true}

    -- require_plugin("nvim-treesitter")
end)


