call plug#begin('~/.local/share/nvim/site/autoload/plugged')
    Plug 'itchyny/lightline.vim'
    Plug 'preservim/nerdtree'
    Plug 'easymotion/vim-easymotion'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'caenrique/nvim-toggle-terminal'	
call plug#end()

set number
set textwidth=50
set numberwidth=1
set ruler
set cursorline
set encoding=utf-8
set showmatch
set matchtime=2
set relativenumber
" Size tabs in spaces
set sw=4

let mapleader=" "
" Press space, s, an ocurrence with 2 chars, and jump into text!
nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>n :NERDTreeFind<CR>
nmap <Leader>nm :NERDTreeClose<CR>
nmap <Leader>wq :wq!<CR>

let g:kite_supported_languages = ['*']

let g:lightline = {
	\ 'colorscheme' : 'wombat'	
	\}
"Auto close brackets
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
"Toggle terminal Ctrl Z
nnoremap <silent> <C-z> :ToggleTerminal<Enter>
tnoremap <silent> <C-z> <C-\><C-n>:ToggleTerminal<Enter>
