{ wrapNeovim
, neovim
, tree-sitter
, config-nvim
, vimPlugins
, vimExtraPlugins
}:

wrapNeovim neovim {
  withPython3 = false;
  withRuby = false;

  configure = {
    customRC = ''
      let g:disable_paq = v:true
      luafile ${config-nvim}/init.lua
    '';

    packages.default = {
      start = [
        config-nvim
        # mystuff {{{1
        vimPlugins.neorg
        vimPlugins.nvim-tree-lua
        vimPlugins.nvim-cmp
        #vimExtraPlugins.lsp-rooter
        vimPlugins.project-nvim
        vimPlugins.plenary-nvim
        vimPlugins.lua-dev-nvim
        vimPlugins.which-key-nvim
        vimPlugins.fidget-nvim
        vimPlugins.luasnip
        vimPlugins.nvim-notify
        vimExtraPlugins.tabby-nvim
        vimExtraPlugins.dirbuf-nvim




        # LSP {{{1
        vimPlugins.nvim-lspconfig
        vimExtraPlugins.lspactions
        vimPlugins.lspkind-nvim
        vimExtraPlugins.null-ls-nvim



        # Syntax {{{1
        (vimPlugins.nvim-treesitter.withPlugins (_: tree-sitter.allGrammars))
        vimPlugins.nvim-treesitter-textobjects
        vimExtraPlugins.nvim-surround



        # Terminal integration {{{1
        #vimExtraPlugins.smart-term-esc-nvim
        #vimExtraPlugins.iron-nvim

        #

        ## Marks {{{1k
        #vimExtraPlugins.marks-nvim

        # Fuzzy finder {{{1k
        vimPlugins.telescope-nvim
        vimPlugins.telescope-symbols-nvim
        vimPlugins.telescope-fzf-native-nvim
        vimExtraPlugins.telescope-heading-nvim

        # Colorscheme {{{1k
        vimPlugins.catppuccin-nvim
        vimPlugins.nvcode-color-schemes-vim

        # Icon {{{1k
        vimPlugins.nvim-web-devicons

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

