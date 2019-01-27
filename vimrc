set nocompatible
filetype off
filetype plugin indent on

syntax on
set number
color roboblu
set t_Co=16
set ruler
set noswapfile
set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set title
set splitright
set mouse=a
set incsearch
set wildmenu
set visualbell
set t_vb=
" Highlight space at the end of the line as an error,
" but don't highlight while in insert mode
hi TrailingWhitespace ctermbg=darkred cterm=none guibg=#cc0000
au InsertEnter * match TrailingWhitespace //
au InsertLeave * match TrailingWhitespace /\v\s+$/

" case insensitive when searching unless you type caps
set ignorecase
set smartcase

fu! DoRunAnyBuffer(interpreter, syntax)
   pclose!
   exe "setlocal ft=" . a:syntax
   exe "sil %y a | below new | sil put a | sil %!" . a:interpreter
   setlocal previewwindow ro nomodified
   winc p
endfu

command! RunPyBuffer call DoRunAnyBuffer("python -", "python")

map <Leader>p :RunPyBuffer<CR>:winc p<cr>:set filetype=pylog<cr>:winc p<cr>
nmap Q :confirm 1,999bd<CR>

autocmd FileType py autocmd BufWritePre <buffer> :%s/\s\+$//e
