" vim-plug
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'samjwill/nvim-unception'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

" make space the leader key
let mapleader = " "

" save by <leader>w
map <leader>w :w<enter>

" open up file explorer with <leader> e
map <leader>e <Cmd>CocCommand explorer<CR>

" use <tab> and <enter> for trigger completion
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#_select_confirm():
      \ "\<CR>"
inoremap <silent><expr> <CR>
      \ coc#pum#visible() ? coc#_select_confirm():
      \ "\<CR>"

" map <leader> d to tsserver.goToSourceDefinition
noremap <leader>d :CocCommand tsserver.goToSourceDefinition<CR>

" map <leader>an to go the next diagnostic
noremap <leader>an :call CocAction('diagnosticNext')<CR>

" map <leader>ap to go the next diagnostic
noremap <leader>ap :call CocAction('diagnosticPrevious')<CR>

" map <leader> q to :q
noremap <leader>q :q<cr>

" map <leader> x to :q!
noremap <leader>x :q!<cr>

" map <leader>r to :e!
map <leader>r :e!<cr>

" use gruvbox colorscheme
colorscheme gruvbox

" disable sign column
set signcolumn=no

" set tab sizes = 2
set tabstop=2
set shiftwidth=2
set expandtab

" enable true color mode
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


" show line numbers
set number


" create a vertical split with <leader> v
nnoremap <leader>v :vsplit<cr>

" navigate between splits using Ctrl+w/j/k/l
nnoremap <silent> <C-h> <Cmd>TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> <Cmd>TmuxNavigateDown<CR>
nnoremap <silent> <C-k> <Cmd>TmuxNavigateUp<CR>
nnoremap <silent> <C-l> <Cmd>TmuxNavigateRight<CR>
inoremap <silent> <C-h> <Cmd>TmuxNavigateLeft<CR>
inoremap <silent> <C-j> <Cmd>TmuxNavigateDown<CR>
inoremap <silent> <C-k> <Cmd>TmuxNavigateUp<CR>
inoremap <silent> <C-l> <Cmd>TmuxNavigateRight<CR>
tnoremap <silent> <C-h> <Cmd>TmuxNavigateLeft<CR>
tnoremap <silent> <C-j> <Cmd>TmuxNavigateDown<CR>
tnoremap <silent> <C-k> <Cmd>TmuxNavigateUp<CR>
tnoremap <silent> <C-l> <Cmd>TmuxNavigateRight<CR>

" search files with Ctrl+p
noremap <C-p> :GFiles<CR>
noremap <leader>g :execute "Ag " . expand("<cword>")<cr>


" automatically start in insert mode in termianls
autocmd TermOpen * startinsert

" disable line numbers in terminals
autocmd TermOpen * setlocal nonumber norelativenumber
autocmd BufWinEnter,WinEnter term://* startinsert


" make new splits appear on the right and bottom 
set splitright
set splitbelow

" allow escape to go to normal mode in terminals
tnoremap <Esc> <C-\><C-n>

" map Ctrl+n to creating a terminal on the right
" but don't do it in fzf preview windows
nnoremap <C-N> :vsplit\|:terminal<cr>
autocmd FileType fzf tnoremap <C-n> <Down>
autocmd FileType fzf tnoremap <Esc> <Nop>
autocmd TermOpen * tnoremap <C-N> <C-\><C-n>:vsplit\|:terminal<cr>
autocmd TermOpen * tnoremap <Esc> <C-\><C-n>
autocmd BufWinEnter,WinEnter term://* tnoremap <C-N> <C-\><C-n>:vsplit\|:terminal<cr>
autocmd BufWinEnter,WinEnter term://* tnoremap <Esc> <C-\><C-n>

" map Option+M (µ) (in terminals) to creating a terminal on the bottom
" Ctrl+Cmd+n is mapped to Ctrl+' in alacirtty
tnoremap µ <C-\><C-n>:split\|:terminal<cr>

" make it more obvious which vim split is active
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" map <leader>c to copy current relative path to clipboard
nnoremap <leader>c :let @+ = expand('%')<cr>

" make using nvr for git a bit easier
if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

" open current file in NERDTree with <leader>o
 map <leader>o :NERDTreeFind<cr>
