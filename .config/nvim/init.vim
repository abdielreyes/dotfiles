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

let g:oceanic_material_allow_italic = 1
let g:oceanic_material_allow_bold = 1
set background=dark
colorscheme oceanic_material


let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='base16_material_palenight'

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
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
