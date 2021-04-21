call plug#begin('~/.local/share/nvim/site/autoload/plugged')
    Plug 'preservim/nerdtree'
    Plug 'easymotion/vim-easymotion'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'caenrique/nvim-toggle-terminal'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'pangloss/vim-javascript'
    Plug 'leafgarland/typescript-vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'vim-airline/vim-airline'
    Plug 'morhetz/gruvbox'
call plug#end()

colorscheme gruvbox

"let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 0

set encoding=utf-8

"Some servers have issues with backup files
set nobackup
set noswapfile
"Persist undo history
set undofile 
set undodir=~/.vim/undodir
"stop acting like classic vi
set nocompatible
set history=1000

set number
set textwidth=79
set numberwidth=1
set ruler
set cursorline
set showmatch
set matchtime=1
set relativenumber
"Display 5 lines above the cursor when scrolling with a mouse
set scrolloff=5
"Fixes common backspace problems
set backspace=indent,eol,start
"Speedup scrolling
set ttyfast 
"Automatically wrap text that extends beyond the screen length
set wrap
" Size tabs in spaces
set sw=4

let mapleader=" "
" Press space, s, an ocurrence with 2 chars, and jump into text!
nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>n :NERDTreeFind<CR>
nmap <Leader>nn :NERDTreeClose<CR>
nmap <Leader>wq :wq!<CR>
nmap <Leader>qq :q!<CR>
let NERDTreeQuitOnOpen=1
"Auto close brackets
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O
"inoremap {;<CR> {<CR>};<ESC>O

"Toggle terminal Ctrl Z
nnoremap <silent> <C-z> :ToggleTerminal<Enter>
tnoremap <silent> <C-z> <C-\><C-n>:ToggleTerminal<Enter>

"fzf 
"nmap <Leader>f :Files<CR>
"let g:airline#extensions#tabline#enabled = 0
"coc 
set updatetime=300
set shortmess+=c
"Tab for completion
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Ctrl space to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"Prettier with :Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
