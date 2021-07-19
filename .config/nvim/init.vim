call plug#begin('~/.local/share/nvim/site/autoload/plugged')
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/vim-nerdtree-syntax-highlight'
    Plug 'easymotion/vim-easymotion'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'caenrique/nvim-toggle-terminal'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'pangloss/vim-javascript'
    Plug 'leafgarland/typescript-vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'morhetz/gruvbox'
"    Plug 'chun-yang/auto-pairs'
    Plug 'psliwka/vim-smoothie'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
call plug#end()

colorscheme gruvbox

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='gruvbox'

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
"set textwidth=79
set numberwidth=1
set ruler
set cursorline
set showmatch
set matchtime=1
"set relativenumber

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
" Press mapleader, s, an ocurrence with 2 chars, and jump into text!
nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>n :NERDTreeFind<CR>
nmap <Leader>nn :NERDTreeToggle<CR>
nmap <Leader> nr :NERDTreeRefreshRoot<CR>
nmap <Leader>ww :wq!<CR>
nmap <Leader>qq :q!<CR>
nmap <Leader>w :w<CR>
let NERDTreeShowHidden=1

"next buffer
nmap <Leader>bn :bn<CR>
"delete curent buffer
nmap <Leader>bb :bw<CR>
"let NERDTreeQuitOnOpen=1

"Toggle terminal Ctrl Z
nnoremap <silent> <C-z> :ToggleTerminal<Enter>
tnoremap <silent> <C-z> <C-\><C-n>:ToggleTerminal<Enter>
"Enter without entering in insert mode
"nnoremap o o<Esc>
"nnoremap O O<Esc>

"fzf 
nmap <Leader>ff :Files<CR>

"Move lines
nnoremap <C-A-j> :m .+1<CR>==
nnoremap <C-A-k> :m .-2<CR>==
inoremap <C-A-j> <Esc>:m .+1<CR>==gi
inoremap <C-A-k> <Esc>:m .-2<CR>==gi
vnoremap <C-A-j> :m '>+1<CR>gv=gv
vnoremap <C-A-k> :m '<-2<CR>gv=gv

"COC config

let g:coc_global_extensions=['coc-solargraph','coc-json','coc-css','coc-tsserver','coc-clangd', 'coc-emmet','coc-fzf-preview','coc-highlight','coc-prettier','coc-pyright','coc-sh','coc-sql','coc-html','coc-java']
" TextEdit might fail if hidden is not set.
set hidden
set updatetime=300
set shortmess+=c
"Tab for completion
inoremap <expr><S-TAB> plumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" confirms selection if any or just break line if none
function! EnterSelect()
    " if the popup is visible and an option is not selected
    if pumvisible() && complete_info()["selected"] == -1
        return "\<C-y>\<CR>"

    " if the pum is visible and an option is selected
    elseif pumvisible()
        return coc#_select_confirm()

    " if the pum is not visible
    else
        return "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    endif
endfunction

" makes <CR> confirm selection if any or just break line if none
inoremap <silent><expr> <cr> EnterSelect()
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"COC Prettier with :Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
