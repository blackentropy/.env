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
Plug 'powerman/vim-plugin-AnsiEsc'
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
" noremap <leader>d :CocCommand tsserver.goToSourceDefinition<CR>
noremap <leader>d <Plug>(coc-definition)
noremap <leader>t <Plug>(coc-type-definition)
noremap <leader>fr <Plug>(coc-references)
noremap <leader>qf <Plug>(coc-fix-current)


" map <leader>an to go the next diagnostic
noremap <leader>an :call CocAction('diagnosticNext')<CR>

" map <leader>ap to go the next diagnostic
noremap <leader>ap :call CocAction('diagnosticPrevious')<CR>


" Use Shift+k to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

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

" search files with Ctrl+p
noremap <C-p> :GFiles<CR>

" fzf with <leader>g
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
noremap <leader>g :GGrep<cr>
noremap <leader>fw :execute "GGrep " . expand("<cword>")<cr>


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
autocmd FileType fzf tnoremap <C-j> <Nop>
autocmd FileType fzf tnoremap <C-h> <Nop>
autocmd FileType fzf tnoremap <C-k> <Nop>
autocmd FileType fzf tnoremap <C-l> <Nop>
autocmd BufWinEnter,WinEnter,TermOpen term://* tnoremap <C-N> <C-\><C-n>:vsplit\|:terminal<cr>
autocmd BufWinEnter,WinEnter,TermOpen term://* tnoremap <Esc> <C-\><C-n>
autocmd BufWinEnter,WinEnter,TermOpen term://* tnoremap <silent> <C-h> <Cmd>TmuxNavigateLeft<CR>
autocmd BufWinEnter,WinEnter,TermOpen term://* tnoremap <silent> <C-j> <Cmd>TmuxNavigateDown<CR>
autocmd BufWinEnter,WinEnter,TermOpen term://* tnoremap <silent> <C-k> <Cmd>TmuxNavigateUp<CR>
autocmd BufWinEnter,WinEnter,TermOpen term://* tnoremap <silent> <C-l> <Cmd>TmuxNavigateRight<CR>


" map Ctrl+P to pasting
" but don't do it in fzf preview windows
autocmd TermOpen * tnoremap <expr> <C-P> '<C-\><C-N>""pi'
autocmd BufWinEnter,WinEnter term://* tnoremap <expr> <C-P> '<C-\><C-N>""pi'
autocmd FileType fzf tnoremap <C-p> <Up>


" map Option+M (??) (in terminals) to creating a terminal on the bottom
" Ctrl+Cmd+n is mapped to Ctrl+' in alacirtty
tnoremap ?? <C-\><C-n>:split\|:terminal<cr>

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

" Turn on ANSI color escaping on .log and .txt files
autocmd BufNewFile,BufRead *.log AnsiEsc
autocmd BufNewFile,BufRead *.txt AnsiEsc

" preview a file by pressing f on itin NERDTree
let NERDTreeMapPreview='f'
