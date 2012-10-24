" Vim is better.
set nocompatible

"
" Basic settings.
"
filetype on
filetype plugin on
filetype indent on
filetype detect

set history=50

" Unix endlines. Fuck dos.
au BufRead,BufNewFile * set ff=unix
au BufRead,BufNewFile * set ffs=unix,dos

" Important GUI settings.
if has('gui_running')
    set guifont=Consolas:h12
    " set guifont=Bitstream\ Vera\ Sans\ Mono\:h10
    " set guifont=Droid\ Sans\ Mono\:h10
    " set guifont=Anonymous\ Pro\:h12
    " set guifont=DejaVu\ Sans\ Mono\:h12
    " set guifont=Inconsolata:h12
    " set textwidth=76
    set columns=150
    colorscheme wombat
    "colorscheme Tomorrow-Night
endif

" Syntax highlighting.
syntax on

" Show ruler line at bottom of each buffer.
set ruler
" Show line numbers.
set number
" Current mode in status line.
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P
set laststatus=2
set showmode

"
" Formatting.
"
set nolbr
"set nowrap
"set nolist
"set textwidth=0
"set wrapmargin=0
" Textwidth set according to Python pep8 standard for line length.
set textwidth=150
" set cc=+1

" Indenting.
" Automatically indent based on file.
set autoindent
" Smart autoindenting on new line.
" set smartindent
" set smartindent
set cindent
" Make tabbing/deleting honor 'shiftwidth' as well as 'softtab' and 'tabstop'
set smarttab
" Use spaces for tabs, and set it to 4 spaces.
set expandtab
set expandtab ts=4 sw=4 ai
" Use 4 spaces for the indents.
set tabstop=4
set shiftwidth=4
set softtabstop=4
" < and > will hit indentation levels instead of always -4/+4.
set shiftround

" Folding
" Fold functions.
set foldmethod=syntax
 
" Close a fold when I leave it
" set foldclose=all

"
" End formatting.
"

"
" Navigation and search.
"
" Show matching braces.
set showmatch
" Highlight search terms
set hlsearch
" Incrementally search.
set incsearch
" Except if there's capitalized letters in the search term.
set smartcase
" Enable mouse in all modes.
set mouse=a
" Make search case insensitive except if there's a capital letter in the
" search expression, meaning it'll find UOLKUO if you search for uolkuo
set ignorecase
set smartcase

" Make backspace work like it should.
set backspace=indent,eol,start

"
" End navigation and search.
"

" Set backup dirs and all that.
set backup
set backupdir=C:/Users/Lasse/gVim/backup
set directory=C:/Users/Lasse/gVim/tmp

" Don't know what these source things do.
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

" Windows setting basically.
behave mswin

" Highlighting for Python
let python_highlight_all = 1

" SnipMate
" let g:snips_author = 'Lasse Vang Gravesen <gravesenlasse@gmail.com>'

" Set the default file encoding to UTF-8:
set encoding=utf8

" let g:SuperTabDefaultCompletionType = '<C-x><C-o>'
" let g:SuperTabContextDefaultCompletionType = '<C-x><C-n>'
" Use the SuperTab settings below this line, not the ones above it.
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabMappingTabLiteral = '<Tab>'
" let g:SuperTabContextDefaultCompletionType= '<C-x><C-n>'
"inoremap <Nul> <C-x><C-n> 

" let g:pydiction_location = 'J:\Program Files (x86)\Vim\vimfiles\ftplugin\pydiction\complete-dict'
" let &dictionary = 'J:\Program Files (x86)\Vim\vimfiles\ftplugin\pydiction\complete-dict'

" set ofu=syntaxcomplete#Complete
" autocmd FileType python set omnifunc=pythoncomplete#Complete
" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" autocmd FileType css set omnifunc=csscomplete#CompleteCSS

au BufNewFile,BufRead *.avs set filetype=avs
au BufNewFile,BufRead *.json set filetype=json

" Specific filetypes and their associated textwidths.
autocmd BufRead,BufNewFile *.txt set textwidth=500
autocmd BufRead,BufNewFile *.py,*.pyc set textwidth=150
autocmd BufRead,BufNewFile *.html,*.css,*.js,*.php  set expandtab ts=2 sw=2 ai

augroup BufNewFileFromTemplate
au!
autocmd BufNewFile *.py silent! 0r $VIM/vimfiles/templates/python_template.py
autocmd BufNewFile *.py normal! G"_dd1G
autocmd BufNewFile *.py exe "1," . 10 . "g/CURRTIME/s//".strftime("%d-%m-%Y %H:%M")
autocmd BufNewFile *.py exe "1," . 10 . "g/FILENAME/s//".expand('%:t')
autocmd BufNewFile *.py silent exe "!cp ".shellescape($VIM)."/vimfiles/templates/bat.bat ".expand("%:h")
autocmd BufNewFile *.html silent! 0r $VIM/vimfiles/templates/html_template.html
autocmd BufNewFile *.html normal! G"_dd1G
autocmd BufNewFile *.c silent! 0r $VIM/vimfiles/templates/c_template.c
autocmd BufNewFile *.c normal! G"_dd1G
autocmd BufNewFile *.cpp silent! 0r $VIM/vimfiles/templates/cpp_template.cpp
autocmd BufNewFile *.cpp normal! G"_dd1G
augroup BufNewFileFromTemplate

au BufNewFile,BufRead *.avs set syntax=avs
au BufRead,BufNewFile *.json set syntax=json 
"au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
"autocmd FileType python compiler pylint

map <F2> :%s/></>\r</g <CR>
nmap <F3> gg=G <CR>
map <F4> :n <CR> G <CR>
map <F5> :%!python -m json.tool<CR>
nmap <F10> :set invnumber <CR>
nmap <F9> :%s/\r//g <CR>
command WQ wq
command Wq wq
command W w
command Q q

let g:syntastic_python_checker='pylint'
let g:syntastic_python_checker_args='--disable=C0301'
call pathogen#infect()

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

