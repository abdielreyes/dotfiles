call plug#begin('~/.local/share/nvim/site/autoload/plugged')
	Plug 'mhinz/vim-startify'
	Plug 'preservim/nerdtree'
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'tpope/vim-repeat'
	Plug 'easymotion/vim-easymotion'
	Plug 'caenrique/nvim-toggle-terminal'
	Plug 'airblade/vim-rooter'
	Plug 'jceb/vim-orgmode'

	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'kaicataldo/material.vim', { 'branch': 'main' }

	Plug 'rafi/awesome-vim-colorschemes'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'jiangmiao/auto-pairs'  
	Plug 'psliwka/vim-smoothie'
	Plug 'mg979/vim-visual-multi', {'branch': 'master'}
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-fugitive'
	Plug 'ryanoasis/vim-devicons'
	Plug 'tpope/vim-commentary'
	Plug 'AndrewRadev/tagalong.vim'
	Plug 'Yggdroot/indentLine'
	Plug 'tpope/vim-rails'
call plug#end()

let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
let g:sonokai_transparent_background = 1
colorscheme sonokai


let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='sonokai'

set termguicolors
set mouse=a
set noerrorbells
syntax on
set encoding=utf-8
set nobackup
set noswapfile
set undofile 
set undodir=~/.vim/undodir
set history=1000
set nocompatible
set number
set numberwidth=1
set ruler
set cursorline
set showmatch
set matchtime=1
set updatetime=300

" set relativenumber
set scrolloff=15
set backspace=indent,eol,start
set ttyfast 
set wrap

set sw=2
set ts=2
set noexpandtab
set autoindent
set smartindent
filetype plugin indent on

set timeoutlen=500
set splitbelow
set splitright

let mapleader=" "
let maplocalleader=","
nmap <Leader>wq :wq!<CR>
nmap <Leader>qq :q!<CR>
nmap <Leader>w :w<CR>
nmap <Leader>ss <Plug>(easymotion-s2)
"splits file into buffer
nmap <Leader>v :split<CR>
nmap <Leader>vv :vsplit<CR>

nmap <Leader>nn :call NERDTreeToggleAndRefresh()<CR>
nmap <Leader>nr :NERDTreeRefreshRoot<CR>
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=0
"Auto refresh when toggles nerdtree
function NERDTreeToggleAndRefresh()
  :NERDTreeToggle
  if g:NERDTree.IsOpen()
    :NERDTreeRefreshRoot
  endif
endfunction
"Move between buffers
nmap <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>bb :bp\|bd #<CR>

nnoremap <silent> <C-z> :ToggleTerminal<Enter>
tnoremap <silent> <C-z> <C-\><C-n>:ToggleTerminal<Enter>
"Copying and pasting 
vnoremap <C-y> "*y :let @+=@*<CR>
vnoremap <C-x> "*d :let @+=@*<CR>
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
nmap <F5> :source ~/.config/nvim/init.vim<CR>
vmap <F5> :source ~/.config/nvim/init.vim<CR>

let &showbreak=repeat(' ', 14)


" coc config
let g:coc_global_extensions = [
      \ 'coc-snippets',
      \ 'coc-pairs',
      \ 'coc-tsserver',
      \ 'coc-eslint', 
      \ 'coc-prettier', 
      \ 'coc-json',
      \ 'coc-solargraph',
      \ 'coc-emmet',
      \ 'coc-highlight',
      \ 'coc-prettier',
      \ 'coc-java',
      \ 'coc-clangd',
      \ 'coc-css',
      \ 'coc-fzf-preview',
      \ 'coc-html',
      \ 'coc-sh',
      \ ]
set hidden

set shortmess+=c

set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <F2>  <Plug>(coc-rename)

xmap <leader>d <Plug>(coc-format-selected)
nmap <leader>d  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

