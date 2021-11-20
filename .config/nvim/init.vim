call plug#begin('~/.local/share/nvim/site/autoload/plugged')
    Plug 'preservim/nerdtree'
    Plug 'christoomey/vim-tmux-navigator'

	Plug 'easymotion/vim-easymotion'
	Plug 'caenrique/nvim-toggle-terminal'

	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
    
	Plug 'sheerun/vim-polyglot'
    
	Plug 'rafi/awesome-vim-colorschemes'
	Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    
	Plug 'chun-yang/auto-pairs'
    Plug 'psliwka/vim-smoothie'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'ryanoasis/vim-devicons'
    Plug 'tpope/vim-commentary'
	" Plug 'tpope/vim-endwise'
	
	Plug 'rbgrouleff/bclose.vim'
	
	Plug 'tpope/vim-rails'
call plug#end()


colorscheme gruvbox
set background=dark
let g:gruvbox_italic=1

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='gruvbox'

set noerrorbells
set termguicolors
syntax on
set encoding=utf-8
set nobackup
set noswapfile
set undofile 
set undodir=~/.vim/undodir
set nocompatible
" set history=1000
set number
set numberwidth=1
set ruler
set cursorline
set showmatch
set matchtime=1
set relativenumber
set scrolloff=4
set backspace=indent,eol,start
set ttyfast 
set wrap
set sw=4
set ts=4
set smartindent
set autoindent
set noexpandtab
set timeoutlen=400
filetype plugin on

let mapleader=" "
nmap <Leader>nn :call NERDTreeToggleAndRefresh()<CR>
nmap <Leader>nr :NERDTreeRefreshRoot<CR>
nmap <Leader>wq :wq!<CR>
nmap <Leader>qq :q!<CR>
nmap <Leader>w :w<CR>

nmap <Leader>ss <Plug>(easymotion-s2)

let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=0

let g:endwise_no_mappings = 1

function NERDTreeToggleAndRefresh()
  :NERDTreeToggle
  if g:NERDTree.IsOpen()
    :NERDTreeRefreshRoot
  endif
endfunction

nmap <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>bb :Bclose<CR>
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
"nnoremap <C-s> :w<CR>
"nnoremap <C-q> :q!<CR>
"Ctrl c is Esc
map <C-c> <ESC>




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
  \ 'coc-tabnine'
  \ ]
" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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
inoremap <silent><expr> <c-space> coc#refresh()

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
inoremap <silent><expr> <cr> EnterSelect()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2>  <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>d <Plug>(coc-format-selected)
nmap <leader>d  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
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


let g:prettier#config#tab_width = 4
