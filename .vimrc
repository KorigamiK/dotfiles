let mapleader=' '

" Enable syntax highlighting
syntax on
colorscheme sorbet

" Basic Vim settings
set splitright
set incsearch
set hlsearch
set hidden
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set updatetime=300
set shortmess+=c
set number
set relativenumber
set ignorecase
set wildmenu
set wildmode=full
set background=dark
set undofile
set undodir=~/.vim/undodir
set completeopt=menuone,noinsert,noselect
nnoremap L :bnext<CR>
nnoremap H :bprevious<CR>
set fillchars+=vert:\▏

" Key mappings for window navigation
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" Key mappings for quick commands
nmap <C-s> :write<CR>
nmap <leader>so :so %<CR>
nnoremap <silent> <Esc><Esc> :let @/ = ""<CR>

set statusline=%f\ [%n]\ %y\ %m
tnoremap <C-x> <C-\><C-n>

nmap <leader>Q :qall<cr>
nmap <leader>q <C-w>q
nmap <leader>x :bdelete<cr>

function! ToggleNetrw()
  " Check if a buffer with filetype 'netrw' is currently displayed in any window
  let netrw_winnr = -1
  for winnr in range(1, winnr('$')) " Loop through all window numbers
    let bufnr = winbufnr(winnr)       " Get buffer number for the window
    " Check if buffer is valid and its filetype is 'netrw'
    if bufnr != -1 && getbufvar(bufnr, '&filetype') ==# 'netrw'
      let netrw_winnr = winnr       " Found it! Store window number
      break                         " Stop searching
    endif
  endfor

  if netrw_winnr != -1
    " Netrw window exists, close it using its window number
    execute netrw_winnr . 'wincmd q'
  else
    " No netrw window found, open one using :Vex (Vertical Explore)
    " You could change this to :Explore or :Sex if you prefer
    execute 'Vex'
  endif
endfunction

" Map Ctrl+N to call the ToggleNetrw function
nnoremap <silent> <C-n> :call ToggleNetrw()<CR>

nnoremap <A-c> "+
xnoremap <A-c> "+
vnoremap <A-c> "+

nnoremap ; :
set clipboard=unnamed

let g:netrw_browse_split = 4

set guicursor=a:block


" Open files in a new vertical split to the right
let g:netrw_browse_split = 4

" Keep netrw open when opening a file (implicit with browse_split > 0)
" You don't strictly need another setting for this when using browse_split

" Set the width of the netrw vertical split window (e.g., 30% of the screen)
let g:netrw_winsize = 30

" Hide the big banner at the top of the netrw window
let g:netrw_banner = 0

" Use a tree listing format (alternative: 1=thin, 2=long, 4=wide)
let g:netrw_liststyle = 2

" Open preview window (using 'p') as a vertical split
let g:netrw_preview = 1

" Optional: Make netrw buffer settings specific (e.g., no wrapping, readonly)
" Your global settings for number/relativenumber will likely apply anyway
" Use 'noma nomod' to prevent accidental modification markers
let g:netrw_bufsettings = 'noma nomod nowrap'

" Optional: Hide dotfiles by default (toggle with 'gh')
" let g:netrw_hide = 1


nmap ]b :bnext<CR>
nmap [b :bprevious<CR>
