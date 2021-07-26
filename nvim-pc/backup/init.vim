""setup plug
if filereadable(expand("~/.config/nvim/plug-setup.vim"))
  source ~/.config/nvim/plug-setup.vim
endif

"" Configs

if filereadable(expand("~/.config/nvim/config/local_init.vim"))
  source ~/.config/nvim/config/local_init.vim
endif
if filereadable(expand("~/.config/nvim/config/conf.vim"))
  source ~/.config/nvim/config/conf.vim
endif
if filereadable(expand("~/.config/nvim/config/keybindings.vim"))
  source ~/.config/nvim/config/keybindings.vim
endif
if filereadable(expand("~/.config/nvim/config/vim-airtline-conf.vim"))
  source ~/.config/nvim/config/vim-airtline-conf.vim
endif
if filereadable(expand("~/.config/nvim/config/deoplete.vim"))
  source ~/.config/nvim/config/deoplete.vim
endif

