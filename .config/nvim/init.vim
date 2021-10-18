"            $$\                     
"            \__|                    
" $$\    $$\ $$\ $$$$$$\$$$$\        
" \$$\  $$  |$$ |$$  _$$  _$$\       
"  \$$\$$  / $$ |$$ / $$ / $$ |      
"   \$$$  /  $$ |$$ | $$ | $$ |      
"    \$  /   $$ |$$ | $$ | $$ |      
"     \_/    \__|\__| \__| \__|  

call plug#begin('~/.local/share/nvim/site/autoload/plugged')
    Plug 'preservim/nerdtree'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'caenrique/nvim-toggle-terminal'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'sheerun/vim-polyglot'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'rafi/awesome-vim-colorschemes'
    Plug 'chun-yang/auto-pairs'
    Plug 'psliwka/vim-smoothie'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'ryanoasis/vim-devicons'
    Plug 'tpope/vim-commentary'
		
		Plug 'tpope/vim-rails'
		Plug 'tpope/vim-endwise'
		Plug 'ctrlpvim/ctrlp.vim'
		Plug 'francoiscabrol/ranger.vim'
		Plug 'rbgrouleff/bclose.vim'
		Plug 'airblade/vim-rooter'
		Plug 'Yggdroot/indentLine'
call plug#end()

"let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
let g:sonokai_transparent_background = 0

colorscheme sonokai

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='sonokai'

set termguicolors
syntax on
set encoding=utf-8
set nobackup
set noswapfile
set undofile 
set undodir=~/.vim/undodir
set nocompatible
set history=1000
set number
set numberwidth=1
set ruler
set cursorline
set showmatch
set matchtime=1
"set relativenumber
set scrolloff=12
set backspace=indent,eol,start
set ttyfast 
set wrap
set sw=4
set timeoutlen=400
filetype plugin on

let mapleader=" "
nmap <Leader>nn :call NERDTreeToggleAndRefresh()<CR>
nmap <Leader>nr :NERDTreeRefreshRoot<CR>
nmap <Leader>wq :wq!<CR>
nmap <Leader>qq :q!<CR>
nmap <Leader>w :w<CR>

let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=0

function NERDTreeToggleAndRefresh()
  :NERDTreeToggle
  if g:NERDTree.IsOpen()
    :NERDTreeRefreshRoot
  endif
endfunction

nmap <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>bb :bp<BAR>bd#<CR>
nnoremap <silent> <C-z> :ToggleTerminal<Enter>
tnoremap <silent> <C-z> <C-\><C-n>:ToggleTerminal<Enter>

"Copying and pasting 
vnoremap <C-y> "*y :let @+=@*<CR>
map <C-p> "+p

nmap <Leader>ff :Files<CR>

"Move lines
nnoremap <C-A-j> :m .+1<CR>==
nnoremap <C-A-k> :m .-2<CR>==
inoremap <C-A-j> <Esc>:m .+1<CR>==gi
inoremap <C-A-k> <Esc>:m .-2<CR>==gi
vnoremap <C-A-j> :m '>+1<CR>gv=gv
vnoremap <C-A-k> :m '<-2<CR>gv=gv
" Use shift alt and hjkl to resize
nnoremap <S-M-j> :resize -2<CR>
nnoremap <S-M-k> :resize +2<CR>
nnoremap <S-M-h> :vertical resize -2 <CR>
nnoremap <S-M-l> :vertical resize +2 <CR>
"move between buffers
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>
"easy write and quit
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q!<CR>
"Ctrl c is Esc
map <C-c> <ESC>





"COC config

let g:coc_global_extensions=['coc-vimtex','coc-solargraph','coc-json','coc-css','coc-tsserver','coc-clangd','coc-emmet','coc-fzf-preview','coc-highlight','coc-prettier','coc-pyright','coc-sh','coc-sql','coc-html','coc-java']
" TextEdit might fail if hidden is not set.
set hidden
set updatetime=300
set shortmess+=c
"Tab for completion confirmr
inoremap <silent><expr> <TAB>
						\ pumvisible() ? "\<C-n>" :
						\ <SID>check_back_space() ? "\<TAB>" :
						\ coc#refresh()
inoremap <expr><S-TAB> plumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
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


