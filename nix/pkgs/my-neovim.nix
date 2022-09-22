{ wrapNeovim
, neovim
, tree-sitter
, config-nvim
, vimPlugins
, vimExtraPlugins
, pkgs
, ...
}:

wrapNeovim neovim
{
  withPython3 = false;
  withRuby = false;

  configure = {
    customRC = ''
      let g:disable_paq = v:true
      luafile ${config-nvim}/init.lua
      luafile ${../../lua/my/options/init.lua}
      luafile ${../../lua/my/keybinds/init.lua}
      luafile ${../../lua/my/keybinds/lsp.lua}
      luafile ${../../lua/my/keybinds/UI.lua}
    '';

    packages.default = {
      start = with vimPlugins; with vimExtraPlugins; [
        config-nvim
        # Colorscheme {{{1k
        {
          plugin = plenary-nvim;
          config = "lua vim.g.mapleader = ' '"; #hack need to set leader before binding keys
        }
        {
          plugin = catppuccin-nvim;
          config = "colorscheme catppuccin";
        }
        {
          plugin = nvcode-color-schemes-vim;
        }

        # mystuff {{{1
        {
          plugin = neorg;
          config = "luafile ${../../lua/my/plugins/neorg.lua}";
        }
        {
          plugin = nvim-tree-lua;
          config = "lua require('nvim-tree').setup({})";
        }
        {
          plugin = nvim-cmp;
          config = "luafile ${../../lua/my/plugins/cmp.lua}";
        }
        #vimExtraPlugins.lsp-rooter
        {
          plugin = project-nvim;
          config = "lua require('project_nvim').setup({})";
        }
        {
          plugin = lua-dev-nvim;
          config = "lua require('lua-dev').setup({})";
        }
        {
          plugin = which-key-nvim;
          config = "lua require('which-key').setup({})";
        }
        {
          plugin = fidget-nvim;
          config = "lua require('fidget').setup({})";
        }
        {
          plugin = luasnip;
        }
        {
          plugin = nvim-notify;
          config = "lua require('notify').setup({})";
        }
        {
          plugin = tabby-nvim;
          config = "lua require('tabby').setup({ tabline = require('tabby.presets').active_wins_at_tail })";
        }
        #vimExtraPlugins.dirbuf-nvim


        {
          plugin = vimPlugins.toggleterm-nvim;
          config = ''
            lua <<EOF
            require('toggleterm').setup {
              open_mapping = [[<leader>tt]],
            }
            local opts = {buffer = 0}
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            EOF
            nnoremap <leader>tt <Cmd>execute v:count . "ToggleTerm"<CR>
          '';
        }
        {
          plugin = vimPlugins.neogit;
          config = "lua require('neogit').setup {}";
        }
        #{
        #  plugin = lazygit-nvim;
        #  #config = "require('telescope').load_extension('lazygit')";
        #}


        # LSP {{{1
        #{
        #  plugin = vimPlugins.nvim-lspconfig;
        #  config = builtins.readFile ./fnl/config/alpha.fnl;
        #  #type = "fennel";
        #}

        #vimExtraPlugins.lspactions
        {
          plugin = lspkind-nvim;
        }
        #vimExtraPlugins.null-ls-nvim



        # Syntax {{{1
        {
          plugin = (nvim-treesitter.withPlugins (_: tree-sitter.allGrammars));
          config = "luafile ${../../lua/my/plugins/treesitter.lua}";
        }
        {
          plugin = nvim-treesitter-textobjects;
        }
        {
          plugin = nvim-surround;
          config = "lua require('nvim-surround').setup({})";
        }



        # Terminal integration {{{1
        #vimExtraPlugins.smart-term-esc-nvim
        vimExtraPlugins.iron-nvim

        #

        ## Marks {{{1k
        #vimExtraPlugins.marks-nvim

        # Fuzzy finder {{{1k
        {
          plugin = telescope-nvim;
          config = "luafile ${../../lua/my/plugins/telescope.lua}";
        }
        {
          plugin = telescope-symbols-nvim;
        }
        {
          plugin = telescope-fzf-native-nvim;
        }
        #vimExtraPlugins.telescope-heading-nvim



        # Icon {{{1k
        {
          plugin = nvim-web-devicons;
        }

        ## Statusline {{{1k
        #vimExtraPlugins.feline-nvim

        ## Cursorline {{{1k
        #vimPlugins.nvim-cursorline

        ## Git {{{1k
        #vimPlugins.gitsigns-nvim

        ## Comment {{{1k
        #vimPlugins.kommentary

        ## Quickfix {{{1k
        #vimExtraPlugins.nvim-pqf

        ## Motion {{{1k
        #vimPlugins.vim-wordmotion
        #vimPlugins.lightspeed-nvim

        ## Search {{{1k
        #vimPlugins.vim-visualstar

        ## Editing support {{{1k
        #vimExtraPlugins.bullets-vim
        #vimPlugins.vim-repeat
        #vimPlugins.vim-unimpaired
        #vimPlugins.numb-nvim
        #vimExtraPlugins.dial-nvim
        #vimExtraPlugins.nvim-lastplace

        ## Command line {{{1k
        #vimPlugins.vim-rsi

        ## Language specific {{{1

        ### Markdown / LaTeX {{{2k
        #vimExtraPlugins.glow-nvim
        #vimExtraPlugins.vim-gfm-syntax
        #vimPlugins.vim-pandoc-syntax
        #vimPlugins.vim-table-mode
        #vimExtraPlugins.telescope-bibtex-nvim

        ## Nix {{{2k
        #        vimPlugins.vim-nix

        ### Bash {{{2k
        #vimExtraPlugins.bats-vim

        ### Lua {{{2k
        #vimPlugins.BetterLua-vim

        ### Fennel {{{2k
        #vimExtraPlugins.vim-fennel-syntax

        ### Python {{{2
        #vimExtraPlugins.requirements-txt-vim

        # }}}1
      ];
    };
  };
}

# vim: fdm=marker

