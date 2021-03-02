call plug#begin('~/.local/share/nvim/site/autoload/plugged')
	Plug 'itchyny/lightline.vim'
	Plug 'preservim/nerdtree'
	Plug 'easymotion/vim-easymotion'
	Plug 'christoomey/vim-tmux-navigator'
call plug#end() 

set number
set numberwidth=1
set ruler
set cursorline
set encoding=utf-8
set showmatch
set relativenumber
set sw=2

let mapleader=" "
" Press space, s and jump into text!
nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>n :NERDTreeFind<CR>
nmap <Leader>nm :NERDTreeClose<CR>
nmap <Leader>wq :wq!<CR>

let g:kite_supported_languages = ['*']

let g:lightline = {
	\ 'colorscheme' : 'wombat'	
	\}
