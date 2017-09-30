set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
"
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

Plugin 'scrooloose/nerdcommenter'
Plugin 'junegunn/vim-easy-align'

Plugin 'vhda/verilog_systemverilog.vim'

Plugin 'tmhedberg/matchit'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'

" " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
" " plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Install L9 and avoid a Naming conflict if you've already installed a
" " different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
"
" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
"
" " Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
"
" " Align line-wise comment delimiters flush left instead of following code
" indentation
let g:NERDDefaultAlign = 'left'
"
" " Set a language to use its alternate delimiters by default
" let g:NERDAltDelims_java = 1
"
" " Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
"
" " Allow commenting and inverting empty lines (useful when commenting a
" region)
let g:NERDCommentEmptyLines = 1
"
" " Enable trimming of trailing whitespace when uncommenting
" let g:NERDTrimTrailingWhitespace = 1
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
let g:easy_align_delimiters = {
      \ '<': { 'pattern': '<=\|<' },
      \ '/': {
      \     'pattern':         '//\+\|/\*\|\*/',
      \     'delimiter_align': 'l',
      \     'ignore_groups':   ['!Comment'] },
      \ ']': {
      \     'pattern':       '[[\]]',
      \     'left_margin':   0,
      \     'right_margin':  0,
      \     'stick_to_left': 0
      \   },
      \ ')': {
      \     'pattern':       '[()]',
      \     'left_margin':   1,
      \     'right_margin':  0,
      \     'stick_to_left': 0
      \   },
      \ 'd': {
      \     'pattern':      ' \(\S\+\s*[;=]\)\@=',
      \     'left_margin':  0,
      \     'right_margin': 0
      \   }
      \ }

function! PortConnect() range
  execute a:firstline . ',' . a:lastline . 's/\[.\{-}\]/'
  execute a:firstline . ',' . a:lastline . 's/output\s\+\|input\s\+\|inout\s\+/.'
  execute a:firstline . ',' . a:lastline . 's/\,/(),'
  execute a:lastline . 's/$/()'
  for line in range(a:firstline, a:lastline)
    let text = getline(line)
    let port_name = matchstr(text, '\w\+')
    execute line . ',' . line . 's/()/' . '(' . port_name . ')'
  endfor
  execute a:firstline . ',' . a:lastline . 'EasyAlign )'
endfunction

function! ParamConnect() range
  execute a:firstline . ',' . a:lastline . 's/parameter\s\+/.'
  execute a:firstline . ',' . a:lastline . 's/\s\+=\s\+/('
  execute a:firstline . ',' . a:lastline . 's/\,/),'
  execute a:lastline . 's/$/)'
  execute a:firstline . ',' . a:lastline . 'EasyAlign )'
endfunction

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[2 q"
endif

" let &t_ti.="\e[1 q"
" let &t_SI.="\e[5 q"
" let &t_EI.="\e[1 q"
" let &t_te.="\e[0 q"

set list
set listchars=tab:→\ ,trail:·,nbsp:·

highlight ExtraWhitespace ctermbg=red guibg=red
highlight MixedWhitespace ctermbg=red guibg=red
" Show trailing whitespace:
match ExtraWhitespace /\s\+$/
" Show trailing whitespace and spaces before a tab:
match MixedWhitespace /\s\+$\| \+\ze\t/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight MixedWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match MixedWhitespace /\s\+$\| \+\ze\t/


set shell=bash
set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
set number
syntax on
let g:gruvbox_contrast_dark='hard'
set background=dark
"colorscheme jellybeans
colorscheme gruvbox
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set incsearch
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <Leader>r :%s/\%V<C-r><C-w>//g<Left><Left>
vnoremap <Leader>i :call PortConnect()<CR><CR>
vnoremap <Leader>p :call ParamConnect()<CR><CR>
nnoremap <C-d> :bp\|bd #<CR>
map <C-n> :NERDTreeToggle<CR>
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

setlocal spell spelllang=ru_yo,en_us
"let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'
"set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
highlight lCursor guifg=NONE guibg=Cyan
set wrap
" set linebreak
" set nolist  " list disables linebreak

set splitright
command MERR vertical cw

map <S-Up> <Nop>
map <S-Down> <Nop>
imap <S-Up> <Nop>
imap <S-Down> <Nop>
